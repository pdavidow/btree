module BTreeVariedType_2_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, nodeValOperate, deDuplicate, hasAnyIntNodes)
import BigInt exposing (fromInt)

import BTree exposing (BTree(..), singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))

import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt, toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import TestsHelper exposing (musicNotePlayerOnNothing, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

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
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInt + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInt - 3
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInt
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
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| maxSafeInt - 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInt + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInt + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInt) (BigInt.fromInt 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInt
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
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeVariedType.nodeValOperate (Increment -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Increment 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on G_sharp
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
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInt + 2
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInt - 3
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInt
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
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInt - 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInt + 2) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt + 2
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.sub (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt <| 3)
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 3) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt
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
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A_sharp
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteVariety.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.nodeValOperate (Decrement 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
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
                            singleton <| toIntVariety <| Safe <| negate <| maxSafeInt - 2
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Safe <| maxSafeInt
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInt
                        )
            ,  test "of non-empty.IntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt maxSafeInt
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
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInt - 2
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.BigIntVariety.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt
                        )
            ,  test "of non-empty.BigIntVariety.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.mul (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt <| maxSafeInt)
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 2) <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInt
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
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.nodeValOperate (Raise -1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 0) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.nodeValOperate (Raise 1) <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on A
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