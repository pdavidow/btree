module BTreeUniformType_1_Tests exposing (..)

import BTreeUniform exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom, toNothing, toTaggedNodes, toLength, toIsIntPrime)

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
    describe "BTreeUniform module"
         [ describe "BTreeUniform.toNothing"
            [ test "of toNothing.0" <|
                \() ->
                    Expect.equal (UniformNothing <| NothingTree <| Empty) (BTreeUniform.toNothing (UniformInt <| IntTree <| Empty))
            , test "of toNothing.1" <|
                \() ->
                    1
                        |> Safe
                        |> IntNodeVal
                        |> BTree.singleton
                        |> uniformIntTreeFrom
                        |> BTreeUniform.toNothing
                        |> Expect.equal (UniformNothing <| NothingTree <| singleton NothingNodeVal)

            , test "of toNothing.2" <|
                \() ->
                    ["a", "b"] 
                        |> List.map StringNodeVal
                        |> fromListBy Basics.toString 
                        |> uniformStringTreeFrom
                        |> BTreeUniform.toNothing
                        |> Expect.equal (UniformNothing <| NothingTree <|
                            Node NothingNodeVal
                                Empty
                                (singleton NothingNodeVal))
            ]
         , describe "BTreeUniform.toTaggedNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (List.repeat 6 Empty)
                        (
                            [ BTreeUniform.toTaggedNodes <| uniformIntTreeFrom Empty
                            , BTreeUniform.toTaggedNodes <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.toTaggedNodes <| uniformStringTreeFrom Empty
                            , BTreeUniform.toTaggedNodes <| uniformBoolTreeFrom Empty
                            , BTreeUniform.toTaggedNodes <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.toTaggedNodes <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| IntVariety <| IntNodeVal <| Safe 1
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe <| 1
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BigIntVariety <| BigIntNodeVal <| BigInt.fromInt 1
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 1
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| StringVariety <| StringNodeVal <| "a"
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BoolVariety <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeUniform.toTaggedNodes <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniform.toLength"
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
                            [ BTreeUniform.toLength <| uniformIntTreeFrom Empty
                            , BTreeUniform.toLength <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.toLength <| uniformStringTreeFrom Empty
                            , BTreeUniform.toLength <| uniformBoolTreeFrom Empty
                            , BTreeUniform.toLength <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.toLength <| uniformNothingTreeFrom Empty
                            ]
                        )
            ,  test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniform.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe -12
                        )
            ,  test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniform.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 34567
                        )
            ,  test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Unsafe
                        )
                        ( BTreeUniform.toLength <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniform.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| -12
                        )
            ,  test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniform.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| 34567
                        )
            ,  test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 16
                        )
                        ( BTreeUniform.toLength <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 2
                        )
                        ( BTreeUniform.toLength <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "ab"
                        )
            ,  test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformIntTreeFrom <| singleton <| IntNodeVal <| Safe 5
                        )
                        ( BTreeUniform.toLength <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "cdefg"
                        )
            ,  test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toLength <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            ,  test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toLength <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toLength <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniform.toIsIntPrime"
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
                            [ BTreeUniform.toIsIntPrime <| uniformIntTreeFrom Empty
                            , BTreeUniform.toIsIntPrime <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.toIsIntPrime <| uniformStringTreeFrom Empty
                            , BTreeUniform.toIsIntPrime <| uniformBoolTreeFrom Empty
                            , BTreeUniform.toIsIntPrime <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.toIsIntPrime <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just False
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformIntTreeFrom <| singleton <| IntNodeVal <| toMaybeSafeInt <| 13
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformBigIntTreeFrom <| singleton <| BigIntNodeVal <| BigInt.fromInt 13
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformStringTreeFrom <| singleton <| StringNodeVal <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| singleton <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.toIsIntPrime <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniform.setTreePlayerParams"
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

