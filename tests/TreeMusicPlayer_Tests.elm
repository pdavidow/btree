module TreeMusicPlayer_Tests exposing (..)

import TreeMusicPlayer exposing (treeMusicPlay)
import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree(..), singleton)
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (on)

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
                        tree = BTreeMusicNotePlayer (singleton (MusicNotePlayer.on A))
                        result = "{ type = \"node\", branches = [{ type = \"leaf\", home = \"port_playNote\", value = { freq = 220, id = \"\", startOffset = 0, duration = 1, isLast = True } }] }"

                    in
                        Expect.equal result (toString (treeMusicPlay tree))
            ]
        ]
