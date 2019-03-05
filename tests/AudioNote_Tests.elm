module AudioNote_Tests exposing (..)

import AudioNote exposing (AudioNote, audioNote)
import MusicNote exposing (MusicNote(..), MidiNumber(..))

import Random.Pcg exposing (initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)

import Test exposing (..)
import Expect
 

audioNote : Test
audioNote =
    describe "AudioNote module"
         [ describe "AudioNote.audioNote"
            [ test "Nothings" <|
                \() ->
                    Expect.equal Nothing (AudioNote.audioNote Nothing Nothing 1000 500 False False)
            , test "Justs" <|
                \() ->
                    let
                        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
                    in
                        Expect.equal (Just <| AudioNote 220.0 "bc178883-a0ee-487b-8059-30db806ed2a9" 1.0 0.5 False True) (AudioNote.audioNote (Just <| MusicNote <| MidiNumber 57) (Just uuid) 1000 500 False True)

            ]
        ]
