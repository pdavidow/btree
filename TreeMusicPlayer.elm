module TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote)

import Time exposing (Time, millisecond, inMilliseconds)
import Uuid exposing (Uuid)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (flatten, map)
import MusicNote exposing (Freq(..), toFreq)
import MusicNotePlayer exposing (MusicNotePlayer(..), isPlayable)
import AudioNote exposing (AudioNote(..), toJS)
import Ports exposing (port_playNote)


treeMusicPlay : BTreeUniformType -> Cmd msg
treeMusicPlay bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            Debug.log "tojs" (flatten bTree
                |> List.filter isPlayable
                |> toAudioNotes
                |> List.map toJS
                |> List.map port_playNote
                |> Cmd.batch)

        _ ->
            Cmd.none


toAudioNotes : List MusicNotePlayer -> List AudioNote
toAudioNotes players =
    let
        noteDuration = 1000 * millisecond
        gapDuration = 100 * millisecond

        interval = noteDuration + gapDuration
        lastIndex = (List.length players) - 1

        func: Int -> MusicNotePlayer -> AudioNote
        func index (MusicNotePlayer params) =
            let
                startOffset = (toFloat index) * interval
                stopOffset = startOffset + noteDuration
                isLast = (index == lastIndex)
            in
                AudioNote
                    { mbNote = params.mbNote
                    , mbId = params.mbId
                    , startOffset = startOffset
                    , stopOffset = stopOffset
                    , isLast = isLast
                    }
    in
        List.indexedMap func players


setPlayMode : Bool -> Uuid -> BTreeUniformType -> BTreeUniformType
setPlayMode isPlaying uuid bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            let
                func = \(MusicNotePlayer params) ->
                    let
                        updatedParams =  if params.mbId == Just uuid
                            then {params | isPlaying = isPlaying}
                            else params
                    in
                        MusicNotePlayer updatedParams

                updatedBTree = BTree.map func bTree
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