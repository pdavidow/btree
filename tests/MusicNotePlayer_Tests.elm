module MusicNotePlayer_Tests exposing (..)

import MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter, isPlayable)

import MusicNote exposing (MusicNote(..), MidiNumber(..))

import Random.Pcg exposing (initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)

import Test exposing (..)
import Expect


musicNotePlayer : Test
musicNotePlayer =
    describe "MusicNotePlayer module"
         [ describe "MusicNotePlayer.on"
            [ test "on" <|
                \() ->
                    Expect.equal (MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 64, isPlaying = False, mbId = Nothing }) (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
            ]
         , describe "MusicNotePlayer.idedOn"
            [ test "Nothing id" <|
                \() ->
                    Expect.equal (MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 64, isPlaying = False, mbId = Nothing }) (MusicNotePlayer.idedOn Nothing <| MusicNote <| MidiNumber 64)
            , test "Just id" <|
                \() ->
                    let
                        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
                    in
                        Expect.equal (MusicNotePlayer { mbNote = Just <| MusicNote <| MidiNumber 64, isPlaying = False, mbId = (Just uuid) }) (MusicNotePlayer.idedOn (Just uuid) <| MusicNote <| MidiNumber 64)
            ]
         , describe "MusicNotePlayer.sorter"
            [ test "Nothing note" <|
                \() ->
                    Expect.equal (0) (MusicNotePlayer.sorter (MusicNotePlayer {mbNote = Nothing, isPlaying = True, mbId = Nothing}))
            , test "Just note" <|
                \() ->
                    Expect.equal (66) (MusicNotePlayer.sorter (MusicNotePlayer.on <| MusicNote <| MidiNumber 66))
            ]
         , describe "MusicNotePlayer.isPlayable"
            [ test "True" <|
                \() ->
                    Expect.equal True (MusicNotePlayer.isPlayable (MusicNotePlayer.on <| MusicNote <| MidiNumber 66))
            , test "False" <|
                \() ->
                    Expect.equal False (MusicNotePlayer.isPlayable (MusicNotePlayer {mbNote = Nothing, isPlaying = True, mbId = Nothing}))
            ]
        ]
