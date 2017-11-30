module BTreeUniformType_5_Tests exposing (..)

import BTreeUniform exposing (BTreeUniform(..), deDuplicate, isAllNothing, uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom)

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
    describe "BTreeUniform module"
         [ describe "BTreeUniform.deDuplicate"
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
                            [ BTreeUniform.deDuplicate <| uniformIntTreeFrom Empty
                            , BTreeUniform.deDuplicate <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.deDuplicate <| uniformStringTreeFrom Empty
                            , BTreeUniform.deDuplicate <| uniformBoolTreeFrom Empty
                            , BTreeUniform.deDuplicate <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.deDuplicate <| uniformNothingTreeFrom Empty
                            ]
                        ) 
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    let
                        expected =
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    Empty

                        result = BTreeUniform.deDuplicate <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (Safe maxSafeInteger)
                                    (singleton <| Safe 4)
                                    (singleton <| Safe -9)

                        result = BTreeUniform.deDuplicate <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    Empty

                        result = BTreeUniform.deDuplicate <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (singleton <| BigInt.fromInt -9)

                        result = BTreeUniform.deDuplicate <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "a"
                                    (singleton <| "b")
                                    Empty

                        result = BTreeUniform.deDuplicate <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
                                Node (Just True)
                                    (singleton <| Just False)
                                    Empty

                        result = BTreeUniform.deDuplicate <|
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
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
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    Empty

                        result = BTreeUniform.deDuplicate <|
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTreeUniform.isAllNothing"
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
                            [ BTreeUniform.isAllNothing <| uniformIntTreeFrom Empty
                            , BTreeUniform.isAllNothing <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.isAllNothing <| uniformStringTreeFrom Empty
                            , BTreeUniform.isAllNothing <| uniformBoolTreeFrom Empty
                            , BTreeUniform.isAllNothing <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| Empty
                            , BTreeUniform.isAllNothing <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt" <|
                \() ->
                    Expect.equal False (BTreeUniform.isAllNothing <| uniformIntTreeFrom <| BTree.map IntNodeVal <| singleton <| Safe 1)
            , test "of non-empty.BTreeBigInt" <|
                \() ->
                    Expect.equal False (BTreeUniform.isAllNothing <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| singleton <| BigInt.fromInt 1)
            , test "of non-empty.BTreeString" <|
                \() ->
                    Expect.equal False (BTreeUniform.isAllNothing <| uniformStringTreeFrom <| BTree.map StringNodeVal <| singleton "a")
            , test "of non-empty.BTreeBool" <|
                \() ->
                    Expect.equal False (BTreeUniform.isAllNothing <| uniformBoolTreeFrom <| BTree.map BoolNodeVal <| singleton <| Just True)
            , test "of non-empty.BTreeMusicNotePlayer" <|
                \() ->
                    Expect.equal False (BTreeUniform.isAllNothing <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <|  BTree.map MusicNoteNodeVal <| singleton (MusicNotePlayer.on <| MusicNote <| MidiNumber 57))
            , test "of non-empty.BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniform.isAllNothing uniformNothing3Nodes)
            ]
        ]