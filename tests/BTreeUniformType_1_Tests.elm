module BTreeUniformType_1_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom, toNothing, toTaggedNodes, toLength, toIsIntPrime)

import BTree exposing (BTree(..), Direction(..), TraversalOrder(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)
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
                    Expect.equal (UniformNothing <| NothingTree <| Empty) (BTreeUniformType.toNothing (UniformInt <| IntTree <| Empty))
            , test "of toNothing.1" <|
                \() ->
                    1
                        |> Safe
                        |> IntNodeVal
                        |> BTree.singleton
                        |> uniformIntTreeFrom
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (UniformNothing <| NothingTree <| singleton NothingNodeVal)

            , test "of toNothing.2" <|
                \() ->
                    ["a", "b"] 
                        |> List.map StringNodeVal
                        |> fromListBy Basics.toString 
                        |> uniformStringTreeFrom
                        |> BTreeUniformType.toNothing
                        |> Expect.equal (UniformNothing <| NothingTree <|
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
                            [ BTreeUniformType.toTaggedNodes <| uniformIntTreeFrom Empty
                            , BTreeUniformType.toTaggedNodes <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.toTaggedNodes <| uniformStringTreeFrom Empty
                            , BTreeUniformType.toTaggedNodes <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.toTaggedNodes <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.toTaggedNodes <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| IntVariety <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe <| 1
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BigIntVariety <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| StringVariety <| StringNodeVal <| "a"
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BoolVariety <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniformType.toTaggedNodes <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                            [ Just <| uniformIntTreeFrom Empty
                            , Just <| uniformIntTreeFrom Empty
                            , Just <| uniformIntTreeFrom Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toLength <| uniformIntTreeFrom Empty
                            , BTreeUniformType.toLength <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.toLength <| uniformStringTreeFrom Empty
                            , BTreeUniformType.toLength <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.toLength <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.toLength <| uniformNothingTreeFrom Empty
                            ]
                        )
            ,  test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe -12
                        )
            ,  test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 34567
                        )
            ,  test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniformType.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| -12
                        )
            ,  test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| 34567
                        )
            ,  test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 16
                        )
                        ( BTreeUniformType.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "ab"
                        )
            ,  test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "cdefg"
                        )
            ,  test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            ,  test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                            [ Just <| uniformBoolTreeFrom Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toIsIntPrime <| uniformIntTreeFrom Empty
                            , BTreeUniformType.toIsIntPrime <| uniformBigIntTreeFrom Empty
                            , BTreeUniformType.toIsIntPrime <| uniformStringTreeFrom Empty
                            , BTreeUniformType.toIsIntPrime <| uniformBoolTreeFrom Empty
                            , BTreeUniformType.toIsIntPrime <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniformType.toIsIntPrime <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 13
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 13
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
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
                        tree = uniformMusicNotePlayerTreeFrom (fn defaultTreePlayerParams) Empty

                        mbParams = case tree of
                            UniformInt _ -> Nothing
                            UniformBigInt _ -> Nothing
                            UniformString _ -> Nothing
                            UniformBool _ -> Nothing
                            UniformMusicNotePlayer (MusicNotePlayerTree params _) -> Just params
                            UniformNothing _ -> Nothing

                        resultParams = Maybe.withDefault defaultTreePlayerParams mbParams
                    in
                        Expect.equal
                            (traversalOrder, playSpeed, gapDuration)
                            (resultParams.traversalOrder, resultParams.playSpeed, resultParams.gapDuration)
            ]
         ]

