module BTreeUniformType_4_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, nodeValOperate, depth, sumInt, sort, deDuplicate, isAllNothing)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
import TreePlayerParams exposing (defaultTreePlayerParams)

import BigInt exposing (fromInt, toString)
import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect
 

bTreeUniformType_4 : Test
bTreeUniformType_4 =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.sort"
            [ test "of empty.1" <|
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
                            [ BTreeUniformType.sort Right <| BTreeInt <| Empty
                            , BTreeUniformType.sort Right <| BTreeBigInt <| Empty
                            , BTreeUniformType.sort Right <| BTreeString <| Empty
                            , BTreeUniformType.sort Right <| BTreeBool <| Empty
                            , BTreeUniformType.sort Right <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.sort Right <| BTreeNothing <| Empty
                            ]
                        )
            , test "of empty.2" <|
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
                            [ BTreeUniformType.sort Left <| BTreeInt <| Empty
                            , BTreeUniformType.sort Left <| BTreeBigInt <| Empty
                            , BTreeUniformType.sort Left<| BTreeString <| Empty
                            , BTreeUniformType.sort Left<| BTreeBool <| Empty
                            , BTreeUniformType.sort Left <| BTreeMusicNotePlayer defaultTreePlayerParams <| Empty
                            , BTreeUniformType.sort Left <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1a" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (Safe 1)
                                    Empty
                                    (singleton <| Safe 2)

                        result = BTreeUniformType.sort Right <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (Safe 2)
                                    Empty
                                    (singleton <| Safe 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.1b" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    Empty

                        result = BTreeUniformType.sort Left <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (Safe 2)
                                    Empty
                                    (singleton <| Safe 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.2a" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt -9)
                                    (singleton <| toMaybeSafeInt 4)
                                    (Node (toMaybeSafeInt 4)
                                        Empty
                                        (singleton <| toMaybeSafeInt maxSafeInteger)
                                    )

                        result = BTreeUniformType.sort Right <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt <| maxSafeInteger)
                                    (singleton <| toMaybeSafeInt 4)
                                    (Node (toMaybeSafeInt -9)
                                        Empty
                                        (singleton <| toMaybeSafeInt 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.2b" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt -9)
                                    (Node (toMaybeSafeInt 4)
                                        (singleton <| toMaybeSafeInt <| maxSafeInteger)
                                        Empty
                                    )
                                    (singleton <| toMaybeSafeInt 4)


                        result = BTreeUniformType.sort Left <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt <| maxSafeInteger)
                                    (singleton <| toMaybeSafeInt 4)
                                    (Node (toMaybeSafeInt -9)
                                        Empty
                                        (singleton <| toMaybeSafeInt 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.3a" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt 66)
                                    (singleton <| toMaybeSafeInt 971)
                                    (singleton <| toMaybeSafeInt 286)

                        result = BTreeUniformType.sort Right <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt <| 286)
                                    Empty
                                    (Node (toMaybeSafeInt 66)
                                        Empty
                                        (singleton <| toMaybeSafeInt 971)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeInt.3b" <|
                \() ->
                    let
                        expected =
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt 66)
                                    (singleton <| toMaybeSafeInt 286)
                                    (singleton <| toMaybeSafeInt 971)

                        result = BTreeUniformType.sort Left <|
                            BTreeInt <| BTree.map IntNodeVal <| 
                                Node (toMaybeSafeInt <| 286)
                                    Empty
                                    (Node (toMaybeSafeInt 66)
                                        Empty
                                        (singleton <| toMaybeSafeInt 971)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.1a" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <| 
                                Node (BigInt.fromInt 1)
                                    Empty
                                    (singleton <| BigInt.fromInt 2)

                        result = BTreeUniformType.sort Right <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 2)
                                    Empty
                                    (singleton <| BigInt.fromInt 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.1b" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    Empty

                        result = BTreeUniformType.sort Left <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 2)
                                    Empty
                                    (singleton <| BigInt.fromInt 1)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.2a" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt -9)
                                    (singleton <| BigInt.fromInt 4)
                                    (Node (BigInt.fromInt 4)
                                        Empty
                                        (singleton <| BigInt.fromInt maxSafeInteger)
                                    )

                        result = BTreeUniformType.sort Right <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt <| maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (Node (BigInt.fromInt -9)
                                        Empty
                                        (singleton <| BigInt.fromInt 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.2b" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt -9)
                                    (Node (BigInt.fromInt 4)
                                        (singleton <| BigInt.fromInt <| maxSafeInteger)
                                        Empty
                                    )
                                    (singleton <| BigInt.fromInt 4)


                        result = BTreeUniformType.sort Left <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt <| maxSafeInteger)
                                    (singleton <| BigInt.fromInt 4)
                                    (Node (BigInt.fromInt -9)
                                        Empty
                                        (singleton <| BigInt.fromInt 4)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.3a" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 66)
                                    (singleton <| BigInt.fromInt 971)
                                    (singleton <| BigInt.fromInt 286)

                        result = BTreeUniformType.sort Right <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt <| 286)
                                    Empty
                                    (Node (BigInt.fromInt 66)
                                        Empty
                                        (singleton <| BigInt.fromInt 971)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBigInt.3b" <|
                \() ->
                    let
                        expected =
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 66)
                                    (singleton <| BigInt.fromInt 286)
                                    (singleton <| BigInt.fromInt 971)

                        result = BTreeUniformType.sort Left <|
                            BTreeBigInt <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt <| 286)
                                    Empty
                                    (Node (BigInt.fromInt 66)
                                        Empty
                                        (singleton <| BigInt.fromInt 971)
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.1a" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "Safe 1"
                                    Empty
                                    (singleton <| "Safe 2")

                        result = BTreeUniformType.sort Right <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "Safe 2"
                                    Empty
                                    (singleton <| "Safe 1")
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.1b" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "Safe 1"
                                    (singleton <| "Safe 2")
                                    Empty

                        result = BTreeUniformType.sort Left <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "Safe 2"
                                    Empty
                                    (singleton <| "Safe 1")
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.2a" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "-9"
                                    (singleton <| "4")
                                    (Node "4"
                                        Empty
                                        (singleton <| "444")
                                    )

                        result = BTreeUniformType.sort Right <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "444"
                                    (singleton <| "4")
                                    (Node "-9"
                                        Empty
                                        (singleton <| "4")
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.2b" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "-9"
                                    (Node "4"
                                        (singleton <| "444")
                                        Empty
                                    )
                                    (singleton <| "4")

                        result = BTreeUniformType.sort Left <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "444"
                                    (singleton <| "4")
                                    (Node "-9"
                                        Empty
                                        (singleton <| "4")
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.3a" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "286"
                                    (singleton <| "971")
                                    (singleton <| "66")

                        result = BTreeUniformType.sort Right <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "286"
                                    Empty
                                    (Node "66"
                                        Empty
                                        (singleton <| "971")
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeString.3b" <|
                \() ->
                    let
                        expected =
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "286"
                                    (singleton <| "66")
                                    (singleton <| "971")

                        result = BTreeUniformType.sort Left <|
                            BTreeString <| BTree.map StringNodeVal <|
                                Node "286"
                                    Empty
                                    (Node "66"
                                        Empty
                                        (singleton <| "971")
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBool.1a" <|
                \() ->
                    Expect.equal
                        (BTreeBool <| BTree.map BoolNodeVal <| Node (Just False) Empty (singleton <| Just True))
                        (BTreeUniformType.sort Right <| BTreeBool <| BTree.map BoolNodeVal <| Node (Just True) Empty (singleton <| Just False))
            , test "of non-empty.BTreeBool.1b" <|
                \() ->
                    Expect.equal
                        (BTreeBool <| BTree.map BoolNodeVal <| Node (Just False) (singleton <| Just True) Empty)
                        (BTreeUniformType.sort Left <| BTreeBool <| BTree.map BoolNodeVal <| Node (Just True) Empty (singleton <| Just False))
            , test "of non-empty.BTreeBool.2a" <|
                \() ->
                    let
                        expected =
                            BTreeBool <| BTree.map BoolNodeVal <| 
                                Node (Just False)
                                    (singleton <| Just True)
                                    (Node (Just False)
                                        (singleton <| Just True)
                                        (singleton <| Just True)
                                    )

                        result = BTreeUniformType.sort Right <|
                            BTreeBool <| BTree.map BoolNodeVal <| 
                                Node (Just True)
                                    (singleton <| Just True)
                                    (Node (Just False)
                                        Empty
                                        (Node (Just True)
                                            Empty
                                            (singleton <| Just False)
                                        )
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeBool.2b" <|
                \() ->
                    let
                        expected =
                            BTreeBool <| BTree.map BoolNodeVal <| 
                                Node (Just False)
                                    (Node (Just False)
                                        (singleton <| Just True)
                                        (singleton <| Just True)
                                    )
                                    (singleton <| Just True)

                        result = BTreeUniformType.sort Left <|
                            BTreeBool <| BTree.map BoolNodeVal <| 
                                Node (Just True)
                                    (singleton <| Just True)
                                    (Node (Just False)
                                        Empty
                                        (Node (Just True)
                                            Empty
                                            (singleton <| Just False)
                                        )
                                    )
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.1a" <|
                \() ->
                    let
                        expected =
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on A)
                                    Empty
                                    (singleton <| MusicNotePlayer.on E)

                        result = BTreeUniformType.sort Right <|
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on E)
                                    Empty
                                    (singleton <| MusicNotePlayer.on A)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.1b" <|
                \() ->
                    let
                        expected =
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on A)
                                    (singleton <| MusicNotePlayer.on E)
                                    Empty

                        result = BTreeUniformType.sort Left <|
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on E)
                                    Empty
                                    (singleton <| MusicNotePlayer.on A)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.2a" <|
                \() ->
                    let
                        expected =
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on C_sharp)
                                    (singleton <| MusicNotePlayer.on E)
                                    (Node (MusicNotePlayer.on E)
                                        Empty
                                        (singleton <| MusicNotePlayer.on F)
                                    )

                        result = BTreeUniformType.sort Right <|
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on F)
                                    (Node (MusicNotePlayer.on E)
                                        (singleton <| MusicNotePlayer.on C_sharp)
                                        (singleton <| MusicNotePlayer.on E)
                                    )
                                Empty

                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.2b" <|
                \() ->
                    let
                        expected =
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on C_sharp)
                                    (Node (MusicNotePlayer.on E)
                                        (singleton <| MusicNotePlayer.on F)
                                        Empty
                                    )
                                    (singleton <| MusicNotePlayer.on E)

                        result = BTreeUniformType.sort Left <|
                            BTreeMusicNotePlayer defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on F)
                                    (Node (MusicNotePlayer.on E)
                                        (singleton <| MusicNotePlayer.on C_sharp)
                                        (singleton <| MusicNotePlayer.on E)
                                    )
                                Empty
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeNothing.1a" <|
                \() ->
                    Expect.equal
                        (uniformNothing3Nodes)
                        (BTreeUniformType.sort Right uniformNothing3Nodes)
            , test "of non-empty.BTreeNothing.1b" <|
                \() ->
                    Expect.equal
                        (uniformNothing3Nodes)
                        (BTreeUniformType.sort Left uniformNothing3Nodes)
            ]
        ]