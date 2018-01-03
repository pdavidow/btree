module BTreeVariedType_2_Tests exposing (..)

import BTreeVaried exposing (BTreeVaried(..), nodeValOperate, deDuplicate, hasAnyIntNodes)
import BigInt exposing (fromInt)

import BTree exposing (BTree(..), singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))

import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import TestsHelper exposing (musicNotePlayerOnNothing, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect
  

bTreeVariedType_2 : Test
bTreeVariedType_2 =
    describe "BTreeVaried module"
         [ describe "BTreeVaried.nodeValOperate Increment"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVaried.nodeValOperate (Increment 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVaried.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 3
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInteger - 3
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeVaried.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 3) (BigInt.fromInt 1)
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 3
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| maxSafeInteger - 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger) (BigInt.fromInt 3)
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <| "a3"
                        )
                        ( BTreeVaried.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toStringVariety <|  "a"
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <|  "a0"
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toStringVariety <|  "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <| "a3"
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toStringVariety <| "a"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Increment 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Increment 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeVaried.nodeValOperate (Increment -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 108
                        )
            ,  test "of non-empty.MusicNoteVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Increment -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVaried.nodeValOperate Decrement"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVaried.nodeValOperate (Decrement 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe -2
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 5
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInteger - 3
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 1) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 1) (BigInt.fromInt <| 0)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 5) (BigInt.fromInt <| 1)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 5
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger - 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInteger) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
            ,  test "of non-empty.StringVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
            ,  test "of non-empty.StringVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "ab"
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcde"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 21
                        )
            ,  test "of non-empty.MusicNoteVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVaried.nodeValOperate Raise"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVaried.nodeValOperate (Raise 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 8
                        )
                        ( BTreeVaried.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 8
                        )
                        ( BTreeVaried.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInteger - 2
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInteger
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 8
                        )
                        ( BTreeVaried.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 1
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 8
                        )
                        ( BTreeVaried.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.mul (BigInt.fromInt <| maxSafeInteger) (BigInt.fromInt <| maxSafeInteger)
                        )
                        ( BTreeVaried.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVaried.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
                        ( BTreeVaried.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
            ,  test "of non-empty.StringVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
                        ( BTreeVaried.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.nodeValOperate (Raise 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.nodeValOperate (Raise 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVaried.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         ]