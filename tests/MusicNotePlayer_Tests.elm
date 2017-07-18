module MusicNotePlayer_Tests exposing (..)

import MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter, isPlayable)
import MusicNote exposing (MusicNote(..))

import Random.Pcg exposing (initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


musicNotePlayer : Test
musicNotePlayer =
    describe "MusicNotePlayer module"
         [ describe "MusicNotePlayer.on"
            [ test "on" <|
                \() ->
                    Expect.equal (MusicNotePlayer { mbNote = Just E, isPlaying = False, mbId = Nothing }) (MusicNotePlayer.on E)
            ]
         , describe "MusicNotePlayer.idedOn"
            [ test "Nothing id" <|
                \() ->
                    Expect.equal (MusicNotePlayer { mbNote = Just E, isPlaying = False, mbId = Nothing }) (MusicNotePlayer.idedOn Nothing E)
            , test "Just id" <|
                \() ->
                    let
                        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
                    in
                        Expect.equal (MusicNotePlayer { mbNote = Just E, isPlaying = False, mbId = (Just uuid) }) (MusicNotePlayer.idedOn (Just uuid) E)
            ]
         , describe "MusicNotePlayer.sorter"
            [ test "Nothing note" <|
                \() ->
                    Expect.equal ("Nothing") (MusicNotePlayer.sorter (MusicNotePlayer {mbNote = Nothing, isPlaying = True, mbId = Nothing}))
            , test "Just note" <|
                \() ->
                    Expect.equal ("Just F_sharp") (MusicNotePlayer.sorter (MusicNotePlayer.on F_sharp))
            ]
         , describe "MusicNotePlayer.isPlayable"
            [ test "True" <|
                \() ->
                    Expect.equal True (MusicNotePlayer.isPlayable (MusicNotePlayer.on F_sharp))
            , test "False" <|
                \() ->
                    Expect.equal False (MusicNotePlayer.isPlayable (MusicNotePlayer {mbNote = Nothing, isPlaying = True, mbId = Nothing}))
            ]
        ]
