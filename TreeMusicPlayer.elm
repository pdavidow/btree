module TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)

import Time exposing (Time, millisecond, inMilliseconds)
import Uuid exposing (Uuid)
import Maybe.Extra exposing (values)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (TraversalOrder(..), flattenBy, flattenUsingFoldBy, map)
import MusicNote exposing (Freq(..), toFreq)
import MusicNotePlayer exposing (MusicNotePlayer(..), isPlayable)
import AudioNote exposing (AudioNote, audioNote)
import Ports exposing (port_playNote)
import NodeTag exposing (NodeVariety(..), MusicNoteNode(..))
import TreePlayerParams exposing (TreePlayerParams, defaultTreePlayerParams)


treeMusicPlay : BTreeUniformType -> Cmd msg
treeMusicPlay bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer params bTree ->
            bTree
                |> map (\(MusicNoteNodeVal player) -> player)
                |> flattenBy params.traversalOrder
                |> List.filter isPlayable
                |> toAudioNotes params.noteDuration params.gapDuration
                |> List.map port_playNote
                |> Cmd.batch
        _ ->
            Cmd.none


toAudioNotes : Time -> Time -> List MusicNotePlayer -> List AudioNote
toAudioNotes noteDuration gapDuration notePlayers =
    let
        interval = noteDuration + gapDuration
        lastIndex = (List.length notePlayers) - 1

        fn: Int -> MusicNotePlayer -> Maybe AudioNote
        fn index (MusicNotePlayer params) =
            let
                startOffset = (toFloat index) * interval
                stopOffset = startOffset + noteDuration
                isLast = (index == lastIndex)
            in
                audioNote params.mbNote params.mbId startOffset noteDuration isLast
    in
        List.indexedMap fn notePlayers
            |> Maybe.Extra.values


setPlayMode : Bool -> Maybe Uuid -> BTreeUniformType -> BTreeUniformType
setPlayMode isPlaying mbUuid bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNotePlayer treeParams bTree ->
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
                BTreeMusicNotePlayer treeParams <| BTree.map fn bTree
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