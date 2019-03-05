module TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)

import Time exposing (Time, millisecond, inMilliseconds)
import Uuid exposing (Uuid)
import Maybe.Extra exposing (values)

import BTreeUniform exposing (BTreeUniform(..), MusicNotePlayerTree(..))
import BTree exposing (TraversalOrder(..), flattenBy, flattenUsingFoldBy, map)
import MusicNotePlayer exposing (MusicNotePlayer(..), isPlayable)
import AudioNote exposing (AudioNote, audioNote)
import Ports exposing (port_playNote)
import NodeTag exposing (NodeVariety(..), MusicNoteNode(..))
import TreePlayerParams exposing (TreePlayerParams, PlaySpeed, defaultTreePlayerParams, noteDurationFor)


treeMusicPlay : Bool -> MusicNotePlayerTree -> Cmd msg
treeMusicPlay isHarmonize (MusicNotePlayerTree params bTree) =
    bTree
        |> map (\(MusicNoteNodeVal player) -> player)
        |> flattenBy params.traversalOrder
        |> List.filter isPlayable
        |> toAudioNotes isHarmonize params.playSpeed params.gapDuration
        |> List.map port_playNote
        |> Cmd.batch


toAudioNotes : Bool -> PlaySpeed -> Time -> List MusicNotePlayer -> List AudioNote
toAudioNotes isHarmonize playSpeed gapDuration notePlayers =
    let
        noteDuration = noteDurationFor playSpeed
        interval = noteDuration + gapDuration
        lastIndex = (List.length notePlayers) - 1

        fn: Int -> MusicNotePlayer -> Maybe AudioNote
        fn index (MusicNotePlayer params) =
            let
                startOffset = (toFloat index) * interval
                stopOffset = startOffset + noteDuration
                isLast = (index == lastIndex)
            in
                audioNote params.mbNote params.mbId startOffset noteDuration isHarmonize isLast
    in
        List.indexedMap fn notePlayers
            |> Maybe.Extra.values


setPlayMode : Bool -> Maybe Uuid -> MusicNotePlayerTree -> MusicNotePlayerTree
setPlayMode isPlaying mbUuid (MusicNotePlayerTree treeParams bTree) =
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
        MusicNotePlayerTree treeParams <| BTree.map fn bTree


startPlayNote : Uuid -> MusicNotePlayerTree -> MusicNotePlayerTree
startPlayNote uuid musicNotePlayerTree =
    setPlayMode True (Just uuid) musicNotePlayerTree


donePlayNote : Uuid -> MusicNotePlayerTree -> MusicNotePlayerTree
donePlayNote uuid musicNotePlayerTree =
    setPlayMode False (Just uuid) musicNotePlayerTree


donePlayNotes : MusicNotePlayerTree -> MusicNotePlayerTree
donePlayNotes musicNotePlayerTree =
    setPlayMode False Nothing musicNotePlayerTree