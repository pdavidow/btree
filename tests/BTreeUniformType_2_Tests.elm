module BTreeUniformType_2_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, nodeValOperate, depth, sumInt, sort, deDuplicate, isAllNothing)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)

import BigInt exposing (fromInt, toString)
import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect
  

bTreeUniformType_2 : Test
bTreeUniformType_2 =
    describe "BTreeUniformType module"
        [ describe "BTreeUniformType.nodeValOperate Increment"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeBigInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Increment 1) <| BTreeInt <| Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| BTreeBigInt <| Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| BTreeString <| Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| BTreeBool <| Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 4
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 4
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger - 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe <| negate <| maxSafeInteger - 3
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| maxSafeInteger - 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger - 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "a3"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| BTreeString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "a0"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| BTreeString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "a3"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -1) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| uniformNothingSingelton
                        )
            ]
        , describe "BTreeUniformType.nodeValOperate Decrement"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeBigInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeInt <| Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeBigInt <| Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeString <| Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeBool <| Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe -2
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe -2
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe <| negate <| maxSafeInteger
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger - 3) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "ab"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "ab"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| ""
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| ""
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -1) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| uniformNothingSingelton
                        )
            ]
        , describe "BTreeUniformType.nodeValOperate Raise"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeBigInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Raise 2) <| BTreeInt <| Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| BTreeBigInt <| Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| BTreeString <| Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| BTreeBool <| Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.mul (BigInt.mul (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt <| maxSafeInteger + 2)) (BigInt.fromInt <| maxSafeInteger + 2)
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.mul (BigInt.mul (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt <| negate <| maxSafeInteger + 2)) (BigInt.fromInt <| negate <| maxSafeInteger + 2)
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeString <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeString <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 8) <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -2) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on G_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| BTreeMusicNotePlayer <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -2) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformNothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( uniformNothingSingelton
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| uniformNothingSingelton
                        )
            ]
        ]

