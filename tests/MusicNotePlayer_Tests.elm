module MusicNotePlayer_Tests exposing (..)

import MusicNotePlayer exposing (playTreeMusic)
import MusicNote exposing (MusicNote(..))
import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree(..), singleton)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


musicNote : Test
musicNote =
    describe "MusicNotePlayer module"
         [ describe "MusicNotePlayer.playTreeMusic"
            [ test "invalid" <|
                \() ->
                    let
                        tree = BTreeInt Empty
                        result = Cmd.none

                    in
                        Expect.equal result (playTreeMusic tree)
            , test "valid" <|
                \() ->
                    let
                        tree = BTreeMusicNote (Node (Just A) Empty Empty)
                        result = "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, startOffset = 0, stopOffset = 0.5, onEnded = Just True } }] }"

                    in
                        Expect.equal result (toString (playTreeMusic tree))
            ]
        ]
