module BTreeUniformType_1_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniform(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, setTreePlayerParams)

import BTree exposing (BTree(..), Direction(..), TraversalOrder(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
import TreePlayerParams exposing (PlaySpeed(..), defaultTreePlayerParams)

import BigInt exposing (fromInt, toString)
import Basics.Extra exposing (maxSafeInteger)
import Time exposing (millisecond)

import Test exposing (..)
import Expect

 
bTreeUniformType_1 : Test
bTreeUniformType_1 =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.toNothing"
            [ test "of toNothing.0" <|
                \() ->
                    Expect.equal (UniformNothing Empty) (BTreeUniformType.toNothing (UniformInt Empty))
            , test "of toNothing.1" <|
                \() ->
                    1
                        |> Safe
                        |> IntNodeVal
                        |> BTree.singleton
                        |> UniformInt
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (UniformNothing <| singleton NothingNodeVal)

            , test "of toNothing.2" <|
                \() ->
                    ["a", "b"] 
                        |> List.map StringNodeVal
                        |> fromListBy Basics.toString 
                        |> UniformString
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (UniformNothing <|
                            Node NothingNodeVal
                                Empty
                                (singleton NothingNodeVal))
            ]
         , describe "BTreeUniformType.toTaggedNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (List.repeat 6 Empty)
                        (
                            [ BTreeUniformType.toTaggedNodes <| UniformInt <| Empty
                            , BTreeUniformType.toTaggedNodes <| UniformBigInt <| Empty
                            , BTreeUniformType.toTaggedNodes <| UniformString <| Empty
                            , BTreeUniformType.toTaggedNodes <| UniformBool <| Empty
                            , BTreeUniformType.toTaggedNodes <| UniformMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toTaggedNodes <| UniformNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| IntVariety <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| UniformInt <| singleton <| IntNodeVal <| Safe <| 1
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BigIntVariety <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| UniformBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| StringVariety <| StringNodeVal <| "a"
                        )
                        ( BTreeUniformType.toTaggedNodes <| UniformString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BoolVariety <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toTaggedNodes <| UniformBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.toTaggedNodes <| UniformMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniformType.toLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| UniformInt <| Empty
                            , Just <| UniformInt <| Empty
                            , Just <| UniformInt <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toLength <| UniformInt <| Empty
                            , BTreeUniformType.toLength <| UniformBigInt <| Empty
                            , BTreeUniformType.toLength <| UniformString <| Empty
                            , BTreeUniformType.toLength <| UniformBool <| Empty
                            , BTreeUniformType.toLength <| UniformMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toLength <| UniformNothing <| Empty
                            ]
                        )
            ,  test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| UniformInt <| singleton <| IntNodeVal <| Safe -12
                        )
            ,  test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| UniformInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 34567
                        )
            ,  test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.toLength <| UniformInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| UniformBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| -12
                        )
            ,  test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| UniformBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| 34567
                        )
            ,  test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 16
                        )
                        ( BTreeUniformType.toLength <| UniformBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| UniformString <| singleton <| StringNodeVal <| "ab"
                        )
            ,  test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| UniformString <| singleton <| StringNodeVal <| "cdefg"
                        )
            ,  test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| UniformBool <| singleton <| BoolNodeVal <| Just True
                        )
            ,  test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| UniformMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniformType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| UniformBool <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toIsIntPrime <| UniformInt <| Empty
                            , BTreeUniformType.toIsIntPrime <| UniformBigInt <| Empty
                            , BTreeUniformType.toIsIntPrime <| UniformString <| Empty
                            , BTreeUniformType.toIsIntPrime <| UniformBool <| Empty
                            , BTreeUniformType.toIsIntPrime <| UniformMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toIsIntPrime <| UniformNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformBool <| singleton <| BoolNodeVal <| Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| UniformBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 13
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 13
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| UniformMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniformType.setTreePlayerParams"
            [ test "setTreePlayerParams" <|
                \() ->
                    let
                        traversalOrder = PreOrder
                        playSpeed = Fast
                        gapDuration = 123456 * millisecond

                        fn = \params ->
                            { params
                            | traversalOrder = traversalOrder
                            , playSpeed = playSpeed
                            , gapDuration = gapDuration
                            }
                        tree = setTreePlayerParams fn <| UniformMusicNotePlayer defaultTreePlayerParams Empty

                        mbParams = case tree of
                            UniformInt _ -> Nothing
                            UniformBigInt _ -> Nothing
                            UniformString _ -> Nothing
                            UniformBool _ -> Nothing
                            UniformMusicNotePlayer params _ -> Just params
                            UniformNothing _ -> Nothing

                        resultParams = Maybe.withDefault defaultTreePlayerParams mbParams
                    in
                        Expect.equal
                            (traversalOrder, playSpeed, gapDuration)
                            (resultParams.traversalOrder, resultParams.playSpeed, resultParams.gapDuration)
            ]
         ]

