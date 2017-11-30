module TreeMusicPlayer_Tests exposing (..)

import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)

import BTreeUniform exposing (BTreeUniform(..), MusicNotePlayerTree(..), uniformIntTreeFrom, uniformMusicNotePlayerTreeFrom, transformTreePlayerParamsIn)
import BTree exposing (BTree(..), TraversalOrder(..), singleton)
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import NodeTag exposing (MusicNoteNode(..))
import TreePlayerParams exposing (defaultTreePlayerParams)

import Random.Pcg exposing (initialSeed, step)
import Uuid exposing (uuidGenerator, fromString)

import Test exposing (..)
import Expect
 

setPlayMode : Bool -> Bool
setPlayMode isPlaying =
    let
        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
        player = MusicNotePlayer {mbNote = Just <| MusicNote <| MidiNumber 60, isPlaying = not isPlaying, mbId = Just uuid}
        tree1 = MusicNotePlayerTree defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| player

        tree2 = if isPlaying
            then startPlayNote uuid tree1
            else donePlayNote uuid tree1

        (MusicNotePlayerTree _ bTree) = tree2

        mbPlayer = BTree.flatten bTree
            |> List.map (\(MusicNoteNodeVal player) -> player)
            |> List.head
    in
        case mbPlayer of
            Just (MusicNotePlayer params) -> params.isPlaying
            Nothing -> not isPlaying -- should never get here


testTree : MusicNotePlayerTree
testTree =
    MusicNotePlayerTree defaultTreePlayerParams <|
        Node (MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 57, isPlaying = False, mbId = Uuid.fromString "435d0606-136a-4a3e-b093-e96e0a310d35" })
            (Node (MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 58, isPlaying = False, mbId = Uuid.fromString "22de94eb-cdfc-42ee-a397-1ef94d79e7cb" })
                (Node (MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 64, isPlaying = False, mbId = Uuid.fromString "03d1f029-e0fa-433e-aa2b-25ceb1c19216" })
                    (singleton <| MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 66, isPlaying = False, mbId = Uuid.fromString "0b9d1ebb-db5e-483a-b9aa-39b5f390ecd3" })
                    (singleton <| MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 67, isPlaying = False, mbId = Uuid.fromString "96f92b9f-9cb8-4815-9f7f-12c497551382" })
                )
                (singleton <| MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 64, isPlaying = False, mbId = Uuid.fromString "217e28d2-205f-4952-bf5b-4128e85a5901" })
            )
            (singleton <| MusicNoteNodeVal <| MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 61, isPlaying = False, mbId = Uuid.fromString "c778e0da-65a5-4460-ac78-869f76b3c964" })


treeMusicPlayer : Test
treeMusicPlayer =
    describe "TreeMusicPlayer module"
         [ describe "TreeMusicPlayer.playTreeMusic"
            [ test "non-empty, PreOrder" <|
                \() ->
                    let
                        fn = \params -> {params | traversalOrder = PreOrder}
                        updatedTestTree = transformTreePlayerParamsIn testTree fn
                    in
                        Expect.equal
                            "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, id = \"435d0606-136a-4a3e-b093-e96e0a310d35\", startOffset = 0, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 233.08, id = \"22de94eb-cdfc-42ee-a397-1ef94d79e7cb\", startOffset = 1, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"03d1f029-e0fa-433e-aa2b-25ceb1c19216\", startOffset = 2, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 369.99, id = \"0b9d1ebb-db5e-483a-b9aa-39b5f390ecd3\", startOffset = 3, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 392, id = \"96f92b9f-9cb8-4815-9f7f-12c497551382\", startOffset = 4, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"217e28d2-205f-4952-bf5b-4128e85a5901\", startOffset = 5, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 277.18, id = \"c778e0da-65a5-4460-ac78-869f76b3c964\", startOffset = 6, duration = 0.75, isLast = True } }] }"
                            (toString <| treeMusicPlay updatedTestTree)
            , test "non-empty, InOrder" <|
                \() ->
                    let
                        fn = \params -> {params | traversalOrder = InOrder}
                        updatedTestTree = transformTreePlayerParamsIn testTree fn
                    in
                        Expect.equal
                            "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 369.99, id = \"0b9d1ebb-db5e-483a-b9aa-39b5f390ecd3\", startOffset = 0, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"03d1f029-e0fa-433e-aa2b-25ceb1c19216\", startOffset = 1, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 392, id = \"96f92b9f-9cb8-4815-9f7f-12c497551382\", startOffset = 2, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 233.08, id = \"22de94eb-cdfc-42ee-a397-1ef94d79e7cb\", startOffset = 3, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"217e28d2-205f-4952-bf5b-4128e85a5901\", startOffset = 4, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, id = \"435d0606-136a-4a3e-b093-e96e0a310d35\", startOffset = 5, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 277.18, id = \"c778e0da-65a5-4460-ac78-869f76b3c964\", startOffset = 6, duration = 0.75, isLast = True } }] }"
                            (toString <| treeMusicPlay updatedTestTree)
            , test "non-empty, PostOrder" <|
                \() ->
                    let
                        fn = \params -> {params | traversalOrder = PostOrder}
                        updatedTestTree = transformTreePlayerParamsIn testTree fn
                    in
                    Expect.equal
                        "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 369.99, id = \"0b9d1ebb-db5e-483a-b9aa-39b5f390ecd3\", startOffset = 0, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 392, id = \"96f92b9f-9cb8-4815-9f7f-12c497551382\", startOffset = 1, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"03d1f029-e0fa-433e-aa2b-25ceb1c19216\", startOffset = 2, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 329.63, id = \"217e28d2-205f-4952-bf5b-4128e85a5901\", startOffset = 3, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 233.08, id = \"22de94eb-cdfc-42ee-a397-1ef94d79e7cb\", startOffset = 4, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 277.18, id = \"c778e0da-65a5-4460-ac78-869f76b3c964\", startOffset = 5, duration = 0.75, isLast = False } },{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, id = \"435d0606-136a-4a3e-b093-e96e0a310d35\", startOffset = 6, duration = 0.75, isLast = True } }] }"
                        (toString <| treeMusicPlay updatedTestTree)
            ]
         , describe "TreeMusicPlayer.startPlayNote"
            [ test "startPlayNote" <|
                \() ->
                    Expect.equal True (setPlayMode True)
            ]
         , describe "TreeMusicPlayer.donePlayNote"
            [ test "donePlayNote" <|
                \() ->
                    Expect.equal False (setPlayMode False)
            ]
         , describe "TreeMusicPlayer.donePlayNotes"
            [ test "donePlayNotes" <|
                \() ->
                    let
                        nodeVal = MusicNoteNodeVal <| MusicNotePlayer {mbNote = Just <| MusicNote <| MidiNumber 60, isPlaying = True, mbId = Nothing}
                        tree = MusicNotePlayerTree defaultTreePlayerParams <| Node nodeVal (singleton nodeVal) (singleton nodeVal)

                        (MusicNotePlayerTree _ bTree) = donePlayNotes tree

                        result = bTree
                            |> BTree.flatten
                            |> List.map (\(MusicNoteNodeVal (MusicNotePlayer params)) -> params.isPlaying)
                    in
                        Expect.equal [False,False,False] result
            ]
        ]
