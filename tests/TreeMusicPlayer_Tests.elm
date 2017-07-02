module TreeMusicPlayer_Tests exposing (..)

import TreeMusicPlayer exposing (treeMusicPlay)
import MusicNote exposing (MusicNote(..))
import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree(..), singleton)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


musicNote : Test
musicNote =
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
                        tree = BTreeMusicNotePlayer (Node (Just A) Empty Empty)
                        result = "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, startOffset = 0, stopOffset = 0.5, onEnded = Just True } }] }"

                    in
                        Expect.equal result (toString (treeMusicPlay tree))
            ]
        ]
