module BTreeUniformType_5_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniform(..), deDuplicate, isAllNothing)

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
                            [ UniformInt Empty
                            , UniformBigInt Empty
                            , UniformString Empty
                            , UniformBool Empty
                            , UniformMusicNotePlayer defaultTreePlayerParams Empty
                            , UniformNothing Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.deDuplicate <| UniformInt <| Empty
                            , BTreeUniformType.deDuplicate <| UniformBigInt <| Empty
                            , BTreeUniformType.deDuplicate <| UniformString <| Empty
                            , BTreeUniformType.deDuplicate <| UniformBool <| Empty
                            , BTreeUniformType.deDuplicate <| UniformMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.deDuplicate <| UniformNothing <| Empty
                            ]
                        ) 
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    let
                        expected =
                            UniformInt <| BTree.map IntNodeVal <|
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            UniformInt <| BTree.map IntNodeVal <|
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
                            UniformInt <| BTree.map IntNodeVal <|
                                Node (Safe maxSafeInteger)
                                    (singleton <| Safe 4)
                                    (singleton <| Safe -9)

                        result = BTreeUniformType.deDuplicate <|
                            UniformInt <| BTree.map IntNodeVal <|
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
                            UniformBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            UniformBigInt <| BTree.map BigIntNodeVal <|
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
                            UniformBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (singleton <| BigInt.fromInt -9)

                        result = BTreeUniformType.deDuplicate <|
                            UniformBigInt <| BTree.map BigIntNodeVal <|
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
                            UniformString <| BTree.map StringNodeVal <|
                                Node "a"
                                    (singleton <| "b")
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            UniformString <| BTree.map StringNodeVal <|
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
                            UniformBool <| BTree.map BoolNodeVal <|
                                Node (Just True)
                                    (singleton <| Just False)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            UniformBool <| BTree.map BoolNodeVal <|
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
                            UniformMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    Empty

                        result = BTreeUniformType.deDuplicate <|
                            UniformMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
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
                            [ BTreeUniformType.isAllNothing <| UniformInt <| Empty
                            , BTreeUniformType.isAllNothing <| UniformBigInt <| Empty
                            , BTreeUniformType.isAllNothing <| UniformString <| Empty
                            , BTreeUniformType.isAllNothing <| UniformBool <| Empty
                            , BTreeUniformType.isAllNothing <| UniformMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.isAllNothing <| UniformNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| UniformInt <| BTree.map IntNodeVal <| singleton <| Safe 1)
            , test "of non-empty.BTreeBigInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| UniformBigInt <| BTree.map BigIntNodeVal <| singleton <| BigInt.fromInt 1)
            , test "of non-empty.BTreeString" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| UniformString <| BTree.map StringNodeVal <| singleton "a")
            , test "of non-empty.BTreeBool" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| UniformBool <| BTree.map BoolNodeVal <| singleton <| Just True)
            , test "of non-empty.BTreeMusicNotePlayer" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| UniformMusicNotePlayer defaultTreePlayerParams <|  BTree.map MusicNoteNodeVal <| singleton (MusicNotePlayer.on <| MusicNote <| MidiNumber 57))
            , test "of non-empty.BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing uniformNothing3Nodes)
            ]
        ]