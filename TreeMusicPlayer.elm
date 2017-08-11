module TreeMusicPlayer exposing (treeMusicPlay, treeMusicPlayBy, startPlayNote, donePlayNote)

import Time exposing (Time, millisecond, inMilliseconds)
import Uuid exposing (Uuid)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (TraversalOrder(..), flattenBy, flattenUsingFoldBy, map)
import MusicNote exposing (Freq(..), toFreq)
import MusicNotePlayer exposing (MusicNotePlayer(..), isPlayable)
import AudioNote exposing (AudioNote, audioNote)
import Ports exposing (port_playNote)


treeMusicPlay : BTreeUniformType -> Cmd msg
treeMusicPlay bTreeUniformType =
    treeMusicPlayBy PreOrder bTreeUniformType


treeMusicPlayBy : TraversalOrder -> BTreeUniformType -> Cmd msg
treeMusicPlayBy order bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            flattenBy order bTree
                |> List.filter isPlayable
                |> toAudioNotes
                |> List.map port_playNote
                |> Cmd.batch

        _ ->
            Cmd.none


toAudioNotes : List MusicNotePlayer -> List AudioNote
toAudioNotes players =
    let
        noteDuration = 750 * millisecond
        gapDuration = 250 * millisecond

        interval = noteDuration + gapDuration
        lastIndex = (List.length players) - 1

        fn: Int -> MusicNotePlayer -> AudioNote
        fn index (MusicNotePlayer params) =
            let
                startOffset = (toFloat index) * interval
                stopOffset = startOffset + noteDuration
                isLast = (index == lastIndex)
            in
                audioNote params.mbNote params.mbId startOffset noteDuration isLast
    in
        List.indexedMap fn players


setPlayMode : Bool -> Uuid -> BTreeUniformType -> BTreeUniformType
setPlayMode isPlaying uuid bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            let
                fn = \(MusicNotePlayer params) ->
                    let
                        updatedParams =  if params.mbId == Just uuid
                            then {params | isPlaying = isPlaying}
                            else params
                    in
                        MusicNotePlayer updatedParams

                updatedBTree = BTree.map fn bTree
            in
                BTreeMusicNotePlayer updatedBTree
        _ ->
            bTreeUniformType


startPlayNote : Uuid -> BTreeUniformType -> BTreeUniformType
startPlayNote uuid bTreeUniformType =
    setPlayMode True uuid bTreeUniformType


donePlayNote : Uuid -> BTreeUniformType -> BTreeUniformType
donePlayNote uuid bTreeUniformType =
    setPlayMode False uuid bTreeUniformType