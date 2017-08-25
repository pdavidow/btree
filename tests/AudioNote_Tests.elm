module AudioNote_Tests exposing (..)

import AudioNote exposing (AudioNote, audioNote)
import MusicNote exposing (MusicNote(..))

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
                    Expect.equal (AudioNote 0.0 "" 1.0 0.5 False) (AudioNote.audioNote Nothing Nothing 1000 500 False)
            , test "Justs" <|
                \() ->
                    let
                        ( uuid, seed ) = step uuidGenerator (initialSeed 1)
                    in
                        Expect.equal (AudioNote 220.0 "bc178883-a0ee-487b-8059-30db806ed2a9" 1.0 0.5 True) (AudioNote.audioNote (Just A) (Just uuid) 1000 500 True)

            ]
        ]
