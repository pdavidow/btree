module MusicNote_Tests exposing (..)

import MusicNote exposing (MusicNote(..), Freq(..), MidiNumber(..), sorter, mbSorter, (:+:), (:-:), displayString, toFreq)

import Test exposing (..)
import Expect


musicNote : Test
musicNote =
    describe "MusicNote module"
         [ describe "MusicNote.sortOrder"
            [ test "sortOrder" <|
                \() ->
                    Expect.equal (64) (sorter <| MusicNote <| MidiNumber 64)
            ]
         , describe "MusicNote.mbSortOrder"
            [ test "Just" <|
                \() ->
                    Expect.equal (57) (mbSorter (Just <| MusicNote <| MidiNumber 57))
            , test "Nothing" <|
                \() ->
                    Expect.equal (0) (mbSorter Nothing)
            ]
         , describe "MusicNote.(:+:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just <| MusicNote <| MidiNumber 68) ((Just <| MusicNote <| MidiNumber 65) :+: 3)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just <| MusicNote <| MidiNumber 105) :+: 4)
            ]
         , describe "MusicNote.(:-:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just <| MusicNote <| MidiNumber 57) ((Just <| MusicNote <| MidiNumber 59) :-: 2)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just <| MusicNote <| MidiNumber 23) :-: 3)
            ]
         , describe "MusicNote.displayString"
            [ test "plain" <|
                \() ->
                    Expect.equal (Just "D4") (MusicNote.displayString <| MusicNote <| MidiNumber 62)
            , test "sharp" <|
                \() ->
                    Expect.equal (Just "D4#") (MusicNote.displayString <| MusicNote <| MidiNumber 63)
            ]
         , describe "MusicNote.toFrequency"
            [ test "toFrequency" <|
                \() ->
                    Expect.equal (Just <| Freq 293.67) (MusicNote.toFreq <| MusicNote <| MidiNumber 62)
            ]
        ]
