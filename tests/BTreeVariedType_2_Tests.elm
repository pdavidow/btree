module BTreeVariedType_2_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), nodeValOperate, deDuplicate, hasAnyIntNodes)
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
    describe "BTreeVariedType module" 
         [ describe "BTreeVariedType.nodeValOperate Increment"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.nodeValOperate (Increment 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 3
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInteger - 3
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt 3) (BigInt.fromInt 1)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 3
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| maxSafeInteger - 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <| "a3"
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toStringVariety <|  "a"
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <|  "a0"
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toStringVariety <|  "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety <| "a3"
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toStringVariety <| "a"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 108
                        )
            ,  test "of non-empty.MusicNoteVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVariedType.nodeValOperate Decrement"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.nodeValOperate (Decrement 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe -2
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 4
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 5
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInteger - 3
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 1) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 1) (BigInt.fromInt <| 0)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 1
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| 5) (BigInt.fromInt <| 1)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 5
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger - 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInteger) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
            ,  test "of non-empty.StringVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
            ,  test "of non-empty.StringVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "ab"
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcde"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 21
                        )
            ,  test "of non-empty.MusicNoteVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVariedType.nodeValOperate Raise"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.nodeValOperate (Raise 1) (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 8
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 1
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe 8
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInteger - 2
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInteger
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 8
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 1
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 8
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| 2
                        )
            ,  test "of non-empty.BigIntVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.mul (BigInt.fromInt <| maxSafeInteger) (BigInt.fromInt <| maxSafeInteger)
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger
                        )
            ,  test "of non-empty.StringVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| toStringVariety ""
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toStringVariety "a"
                        )
            ,  test "of non-empty.StringVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abc"
                        )
            ,  test "of non-empty.StringVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toStringVariety "abcd"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -3) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.BoolVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.BoolVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 8) <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just False
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ,  test "of non-empty.NothingVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         ]