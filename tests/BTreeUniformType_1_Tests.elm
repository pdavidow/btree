module BTreeUniformType_1_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, nodeValOperate, depth, sumInt, sort, deDuplicate, isAllNothing, setTreePlayerParams)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
import TreePlayerParams exposing (defaultTreePlayerParams)

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
                    Expect.equal (BTreeNothing Empty) (BTreeUniformType.toNothing (BTreeInt Empty))
            , test "of toNothing.1" <|
                \() ->
                    1
                        |> Safe
                        |> IntNodeVal
                        |> BTree.singleton
                        |> BTreeInt
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (BTreeNothing <| singleton NothingNodeVal)

            , test "of toNothing.2" <|
                \() ->
                    ["a", "b"] 
                        |> List.map StringNodeVal
                        |> fromListBy Basics.toString 
                        |> BTreeString
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (BTreeNothing <|
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
                            [ BTreeUniformType.toTaggedNodes <| BTreeInt <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeBigInt <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeString <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeBool <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| IntVariety <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeInt <| singleton <| IntNodeVal <| Safe <| 1
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BigIntVariety <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| StringVariety <| StringNodeVal <| "a"
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BoolVariety <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                            [ Just <| BTreeInt <| Empty
                            , Just <| BTreeInt <| Empty
                            , Just <| BTreeInt <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toLength <| BTreeInt <| Empty
                            , BTreeUniformType.toLength <| BTreeBigInt <| Empty
                            , BTreeUniformType.toLength <| BTreeString <| Empty
                            , BTreeUniformType.toLength <| BTreeBool <| Empty
                            , BTreeUniformType.toLength <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toLength <| BTreeNothing <| Empty
                            ]
                        )
            ,  test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| IntNodeVal <| Safe -12
                        )
            ,  test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 34567
                        )
            ,  test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| -12
                        )
            ,  test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| 34567
                        )
            ,  test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 16
                        )
                        ( BTreeUniformType.toLength <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| BTreeString <| singleton <| StringNodeVal <| "ab"
                        )
            ,  test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| BTreeString <| singleton <| StringNodeVal <| "cdefg"
                        )
            ,  test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            ,  test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| BTreeMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                            [ Just <| BTreeBool <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toIsIntPrime <| BTreeInt <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeBigInt <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeString <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeBool <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| BoolNodeVal <| Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| IntNodeVal <| toMaybeSafeInt <| 13
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeBigInt <| singleton <| BigIntNodeVal <| BigInt.fromInt 13
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeString <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeMusicNotePlayer defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                        time = 123456 * millisecond
                        fn = \params -> {params | noteDuration = time}
                        tree = setTreePlayerParams fn <| BTreeMusicNotePlayer defaultTreePlayerParams Empty

                        mbParams = case tree of
                            BTreeInt _ -> Nothing
                            BTreeBigInt _ -> Nothing
                            BTreeString _ -> Nothing
                            BTreeBool _ -> Nothing
                            BTreeMusicNotePlayer params _ -> Just params
                            BTreeNothing _ -> Nothing

                        resultParams = Maybe.withDefault defaultTreePlayerParams mbParams
                    in
                        Expect.equal time resultParams.noteDuration
            ]
         ]

