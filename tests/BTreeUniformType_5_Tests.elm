module BTreeUniformType_5_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, nodeValOperate, depth, sumInt, sort, deDuplicate, isAllNothing)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
import TreePlayerParams exposing (defaultTreePlayerParams)

import BigInt exposing (fromInt, toString)
import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect


bTreeUniformType_5 : Test
bTreeUniformType_5 =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.deDuplicate"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt Empty
                            , BTreeBigInt Empty
                            , BTreeString Empty
                            , BTreeBool Empty
                            , BTreeMusicNotePlayer defaultTreePlayerParams Empty
                            , BTreeNothing Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.deDuplicate <| BTreeInt <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeBigInt <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeString <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeBool <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeNothing <| Empty
                            ]
                        ) 
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            BTreeInt <| BTree.map IntNodeVal <|
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    (singleton <| Safe 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <|
                                Node (Safe maxSafeInteger)
                                    (singleton <| Safe 4)
                                    (singleton <| Safe -9)

                        result = BTreeUniformType.deDuplicate <|
                            BTreeInt <| BTree.map IntNodeVal <|
                                Node (Safe maxSafeInteger)
                                    (singleton <| Safe 4)
                                    (Node (Safe -9)
                                        Empty
                                        (singleton <| Safe 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    (singleton <| BigInt.fromInt 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (singleton <| BigInt.fromInt -9)

                        result = BTreeUniformType.deDuplicate <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (Node (BigInt.fromInt -9)
                                        Empty
                                        (singleton <| BigInt.fromInt 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
           , test "of non-empty.BTreeString.1" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "a"
                                    (singleton <| "b")
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "a"
                                    (singleton <| "b")
                                    (singleton <| "a")
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    let
                        expected =
                            BTreeBool <| BTree.map BoolNodeVal <|
                                Node (Just True)
                                    (singleton <| Just False)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            BTreeBool <| BTree.map BoolNodeVal <|
                                Node (Just True)
                                    (singleton <| Just False)
                                    (singleton <| Just True)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    let
                        expected =
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTreeUniformType.isAllNothing"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ True
                            , True
                            , True
                            , True
                            , True
                            , True
                            ]
                        )
                        (
                            [ BTreeUniformType.isAllNothing <| BTreeInt <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeBigInt <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeString <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeBool <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeInt <| BTree.map IntNodeVal <| singleton <| Safe 1)
            , test "of non-empty.BTreeBigInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeBigInt <| BTree.map BigIntNodeVal <| singleton <| BigInt.fromInt 1)
            , test "of non-empty.BTreeString" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeString <| BTree.map StringNodeVal <| singleton "a")
            , test "of non-empty.BTreeBool" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeBool <| BTree.map BoolNodeVal <| singleton <| Just True)
            , test "of non-empty.BTreeMusicNotePlayer" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeMusicNotePlayer defaultTreePlayerParams <|  BTree.map MusicNoteNodeVal <| singleton (MusicNotePlayer.on <| MusicNote <| MidiNumber 57))
            , test "of non-empty.BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing uniformNothing3Nodes)
            ]
        ]