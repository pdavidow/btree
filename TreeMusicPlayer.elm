module TreeMusicPlayer exposing (treeMusicPlayBy, startPlayNote, donePlayNote, donePlayNotes)

import Time exposing (Time, millisecond, inMilliseconds)
import Uuid exposing (Uuid)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (TraversalOrder(..), flattenBy, flattenUsingFoldBy, map)
import MusicNote exposing (Freq(..), toFreq)
import MusicNotePlayer exposing (MusicNotePlayer(..), isPlayable)
import AudioNote exposing (AudioNote, audioNote)
import Ports exposing (port_playNote)
import NodeTag exposing (NodeVariety(..), MusicNoteNode(..))


treeMusicPlayBy : TraversalOrder -> BTreeUniformType -> Cmd msg
treeMusicPlayBy order bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            bTree
                |> map (\(MusicNoteNodeVal player) -> player)
                |> flattenBy order
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


setPlayMode : Bool -> Maybe Uuid -> BTreeUniformType -> BTreeUniformType
setPlayMode isPlaying mbUuid bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer bTree ->
            let
                fn = \(MusicNoteNodeVal (MusicNotePlayer params)) ->
                    let
                        isUpdate = case mbUuid of
                            Just uuid -> params.mbId == Just uuid
                            Nothing -> True

                        updatedParams = if isUpdate
                            then {params | isPlaying = isPlaying}
                            else params
                    in
                        MusicNoteNodeVal <| MusicNotePlayer updatedParams
            in
                BTreeMusicNotePlayer <| BTree.map fn bTree
        _ ->
            bTreeUniformType


startPlayNote : Uuid -> BTreeUniformType -> BTreeUniformType
startPlayNote uuid bTreeUniformType =
    setPlayMode True (Just uuid) bTreeUniformType


donePlayNote : Uuid -> BTreeUniformType -> BTreeUniformType
donePlayNote uuid bTreeUniformType =
    setPlayMode False (Just uuid) bTreeUniformType


donePlayNotes : BTreeUniformType -> BTreeUniformType
donePlayNotes bTreeUniformType =
    setPlayMode False Nothing bTreeUniformType