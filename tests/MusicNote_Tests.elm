module MusicNote_Tests exposing (..)

import MusicNote exposing (MusicNote(..), (:+:), (:-:), displayString, sortOrder)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


musicNote : Test
musicNote =
    describe "MusicNote module"
         [ describe "MusicNote.(:+:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just G_sharp) ((Just F) :+: 3)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just F) :+: 4)
            ]
         , describe "MusicNote.(:-:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just A) ((Just B) :-: 2)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just B) :-: 3)
            ]
         , describe "MusicNote.displayString"
            [ test "plain" <|
                \() ->
                    Expect.equal ("D") (MusicNote.displayString D)
            , test "sharp" <|
                \() ->
                    Expect.equal ("D#") (MusicNote.displayString D_sharp)
            ]
        ]