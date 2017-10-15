module MusicNote_Tests exposing (..)

import MusicNote exposing (MusicNote(..), Freq(..), sorter, mbSorter, (:+:), (:-:), displayString, toFreq)

import Test exposing (..)
import Expect


musicNote : Test
musicNote =
    describe "MusicNote module"
         [ describe "MusicNote.sortOrder"
            [ test "sortOrder" <|
                \() ->
                    Expect.equal (64) (sorter <| MusicNote 64)
            ]
         , describe "MusicNote.mbSortOrder"
            [ test "Just" <|
                \() ->
                    Expect.equal (57) (mbSorter (Just <| MusicNote 57))
            , test "Nothing" <|
                \() ->
                    Expect.equal (0) (mbSorter Nothing)
            ]
         , describe "MusicNote.(:+:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just <| MusicNote 68) ((Just <| MusicNote 65) :+: 3)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just <| MusicNote 105) :+: 4)
            ]
         , describe "MusicNote.(:-:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just <| MusicNote 57) ((Just <| MusicNote 59) :-: 2)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just <| MusicNote 23) :-: 3)
            ]
         , describe "MusicNote.displayString"
            [ test "plain" <|
                \() ->
                    Expect.equal (Just "D4") (MusicNote.displayString <| MusicNote 62)
            , test "sharp" <|
                \() ->
                    Expect.equal (Just "D4#") (MusicNote.displayString <| MusicNote 63)
            ]
         , describe "MusicNote.toFrequency"
            [ test "toFrequency" <|
                \() ->
                    Expect.equal (Just <| Freq 293.67) (MusicNote.toFreq <| MusicNote 62)
            ]
        ]
