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
                    Expect.equal ("E") (sorter E)
            ]
         , describe "MusicNote.mbSortOrder"
            [ test "Just" <|
                \() ->
                    Expect.equal ("Just E") (mbSorter (Just E))
            , test "Nothing" <|
                \() ->
                    Expect.equal ("Nothing") (mbSorter Nothing)
            ]
         , describe "MusicNote.(:+:)"
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
         , describe "MusicNote.toFrequency"
            [ test "toFrequency" <|
                \() ->
                    Expect.equal (Freq 293.67) (MusicNote.toFreq D)
            ]
        ]
