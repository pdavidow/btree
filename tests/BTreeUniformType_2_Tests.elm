module BTreeUniformType_2_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom, nodeValOperate)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)
import TreePlayerParams exposing (defaultTreePlayerParams)

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
                            [ uniformIntTreeFrom Empty
                            , uniformBigIntTreeFrom Empty
                            , uniformStringTreeFrom Empty
                            , uniformBoolTreeFrom Empty
                            , uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , uniformNothingTreeFrom Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Increment 1) <| uniformIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| uniformStringTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.nodeValOperate (Increment 1) <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 4
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 4
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger - 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe <| negate <| maxSafeInteger - 3
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| maxSafeInteger - 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger - 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "a3"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "a0"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "a3"
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeUniformType.nodeValOperate (Increment -1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 0) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 67
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 108
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Increment 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
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
                            [ uniformIntTreeFrom Empty
                            , uniformBigIntTreeFrom Empty
                            , uniformStringTreeFrom Empty
                            , uniformBoolTreeFrom Empty
                            , uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , uniformNothingTreeFrom Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Decrement 1) <| uniformIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| uniformStringTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.nodeValOperate (Decrement 1) <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe -2
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe -2
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe <| negate <| maxSafeInteger
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 0)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt 1) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.sub (BigInt.fromInt <| negate <| maxSafeInteger - 3) (BigInt.fromInt 3)
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "ab"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "ab"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| ""
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| ""
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement -1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 21
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 0) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 21
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 58
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Decrement 1) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
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
                            [ uniformIntTreeFrom Empty
                            , uniformBigIntTreeFrom Empty
                            , uniformStringTreeFrom Empty
                            , uniformBoolTreeFrom Empty
                            , uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , uniformNothingTreeFrom Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.nodeValOperate (Raise 2) <| uniformIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| uniformStringTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.nodeValOperate (Raise 2) <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 8
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 2
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.mul (BigInt.mul (BigInt.fromInt <| maxSafeInteger + 2) (BigInt.fromInt <| maxSafeInteger + 2)) (BigInt.fromInt <| maxSafeInteger + 2)
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.mul (BigInt.mul (BigInt.fromInt <| negate <| maxSafeInteger + 2) (BigInt.fromInt <| negate <| maxSafeInteger + 2)) (BigInt.fromInt <| negate <| maxSafeInteger + 2)
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger + 2
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| negate <| maxSafeInteger - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 3) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 8) <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.nodeValOperate (Raise -2) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 0) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 68
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.nodeValOperate (Raise 2) <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| musicNotePlayerOnNothing
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

