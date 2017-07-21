module TreeMusicPlayer_Tests exposing (..)

import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree(..), singleton)
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)

import Random.Pcg exposing (initialSeed, step)
import Uuid exposing (uuidGenerator)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


setPlayMode : Bool -> Bool
setPlayMode isPlaying =
    let
        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
        player = MusicNotePlayer {mbNote = Just C, isPlaying = not isPlaying, mbId = Just uuid}
        tree = BTreeMusicNotePlayer (singleton player)

        bTreeUniformType = if isPlaying
            then startPlayNote uuid tree
            else donePlayNote uuid tree

        bTree = case bTreeUniformType of
            BTreeMusicNotePlayer bTree -> bTree
            _ -> Empty

        mbPlayer = BTree.flatten bTree
            |> List.head
    in
        case mbPlayer of
            Just (MusicNotePlayer params) -> params.isPlaying
            Nothing -> not isPlaying -- should never get here, but might as well


treeMusicPlayer : Test
treeMusicPlayer =
    describe "TreeMusicPlayer module"
         [ describe "TreeMusicPlayer.playTreeMusic"
            [ test "invalid" <|
                \() ->
                    let
                        tree = BTreeInt Empty
                        result = Cmd.none

                    in
                        Expect.equal result (treeMusicPlay tree)
            , test "valid" <|
                \() ->
                    let
                        tree = BTreeMusicNotePlayer (singleton (MusicNotePlayer.on A))
                        result = "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, id = \"\", startOffset = 0, duration = 1, isLast = True } }] }"

                    in
                        Expect.equal result (toString (treeMusicPlay tree))
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
        ]
