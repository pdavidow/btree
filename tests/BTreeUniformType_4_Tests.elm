module BTreeUniformType_4_Tests exposing (..)

import BTreeUniform exposing (BTreeUniform(..), sort, uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom)

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
 

bTreeUniformType_4 : Test
bTreeUniformType_4 =
    describe "BTreeUniform module"
         [ describe "BTreeUniform.sort"
            [ test "of empty.1" <|
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
                            [ BTreeUniform.sort Right <| uniformIntTreeFrom Empty
                            , BTreeUniform.sort Right <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.sort Right <| uniformStringTreeFrom Empty
                            , BTreeUniform.sort Right <| uniformBoolTreeFrom Empty
                            , BTreeUniform.sort Right <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| Empty
                            , BTreeUniform.sort Right <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of empty.2" <|
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
                            [ BTreeUniform.sort Left <| uniformIntTreeFrom Empty
                            , BTreeUniform.sort Left <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.sort Left <| uniformStringTreeFrom Empty
                            , BTreeUniform.sort Left <| uniformBoolTreeFrom Empty
                            , BTreeUniform.sort Left <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| Empty
                            , BTreeUniform.sort Left <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1a" <|
                \() ->
                    let
                        expected =
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (Safe 1)
                                    Empty
                                    (singleton <| Safe 2)

                        result = BTreeUniform.sort Right <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (Safe 1)
                                    (singleton <| Safe 2)
                                    Empty

                        result = BTreeUniform.sort Left <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (toMaybeSafeInt -9)
                                    (singleton <| toMaybeSafeInt 4)
                                    (Node (toMaybeSafeInt 4)
                                        Empty
                                        (singleton <| toMaybeSafeInt maxSafeInteger)
                                    )

                        result = BTreeUniform.sort Right <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (toMaybeSafeInt -9)
                                    (Node (toMaybeSafeInt 4)
                                        (singleton <| toMaybeSafeInt <| maxSafeInteger)
                                        Empty
                                    )
                                    (singleton <| toMaybeSafeInt 4)


                        result = BTreeUniform.sort Left <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (toMaybeSafeInt 66)
                                    (singleton <| toMaybeSafeInt 971)
                                    (singleton <| toMaybeSafeInt 286)

                        result = BTreeUniform.sort Right <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
                                Node (toMaybeSafeInt 66)
                                    (singleton <| toMaybeSafeInt 286)
                                    (singleton <| toMaybeSafeInt 971)

                        result = BTreeUniform.sort Left <|
                            uniformIntTreeFrom <| BTree.map IntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    Empty
                                    (singleton <| BigInt.fromInt 2)

                        result = BTreeUniform.sort Right <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 1)
                                    (singleton <| BigInt.fromInt 2)
                                    Empty

                        result = BTreeUniform.sort Left <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt -9)
                                    (singleton <| BigInt.fromInt 4)
                                    (Node (BigInt.fromInt 4)
                                        Empty
                                        (singleton <| BigInt.fromInt maxSafeInteger)
                                    )

                        result = BTreeUniform.sort Right <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt -9)
                                    (Node (BigInt.fromInt 4)
                                        (singleton <| BigInt.fromInt <| maxSafeInteger)
                                        Empty
                                    )
                                    (singleton <| BigInt.fromInt 4)


                        result = BTreeUniform.sort Left <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 66)
                                    (singleton <| BigInt.fromInt 971)
                                    (singleton <| BigInt.fromInt 286)

                        result = BTreeUniform.sort Right <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
                                Node (BigInt.fromInt 66)
                                    (singleton <| BigInt.fromInt 286)
                                    (singleton <| BigInt.fromInt 971)

                        result = BTreeUniform.sort Left <|
                            uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "Safe 1"
                                    Empty
                                    (singleton <| "Safe 2")

                        result = BTreeUniform.sort Right <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "Safe 1"
                                    (singleton <| "Safe 2")
                                    Empty

                        result = BTreeUniform.sort Left <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "-9"
                                    (singleton <| "4")
                                    (Node "4"
                                        Empty
                                        (singleton <| "444")
                                    )

                        result = BTreeUniform.sort Right <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "-9"
                                    (Node "4"
                                        (singleton <| "444")
                                        Empty
                                    )
                                    (singleton <| "4")

                        result = BTreeUniform.sort Left <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "286"
                                    (singleton <| "971")
                                    (singleton <| "66")

                        result = BTreeUniform.sort Right <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
                                Node "286"
                                    (singleton <| "66")
                                    (singleton <| "971")

                        result = BTreeUniform.sort Left <|
                            uniformStringTreeFrom <| BTree.map StringNodeVal <|
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
                        (uniformBoolTreeFrom <| BTree.map BoolNodeVal <| Node (Just False) Empty (singleton <| Just True))
                        (BTreeUniform.sort Right <| uniformBoolTreeFrom <| BTree.map BoolNodeVal <| Node (Just True) Empty (singleton <| Just False))
            , test "of non-empty.BTreeBool.1b" <|
                \() ->
                    Expect.equal
                        (uniformBoolTreeFrom <| BTree.map BoolNodeVal <| Node (Just False) (singleton <| Just True) Empty)
                        (BTreeUniform.sort Left <| uniformBoolTreeFrom <| BTree.map BoolNodeVal <| Node (Just True) Empty (singleton <| Just False))
            , test "of non-empty.BTreeBool.2a" <|
                \() ->
                    let
                        expected =
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
                                Node (Just False)
                                    (singleton <| Just True)
                                    (Node (Just False)
                                        (singleton <| Just True)
                                        (singleton <| Just True)
                                    )

                        result = BTreeUniform.sort Right <|
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
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
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
                                Node (Just False)
                                    (Node (Just False)
                                        (singleton <| Just True)
                                        (singleton <| Just True)
                                    )
                                    (singleton <| Just True)

                        result = BTreeUniform.sort Left <|
                            uniformBoolTreeFrom <| BTree.map BoolNodeVal <|
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
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                                    Empty
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)

                        result = BTreeUniform.sort Right <|
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    Empty
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.1b" <|
                \() ->
                    let
                        expected =
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    Empty

                        result = BTreeUniform.sort Left <|
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    Empty
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                    in
                        Expect.equal
                            expected
                            result
            , test "of non-empty.BTreeMusicNote.2a" <|
                \() ->
                    let
                        expected =
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 61)
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                    (Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                        Empty
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    )

                        result = BTreeUniform.sort Right <|
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    (Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 61)
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
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
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 61)
                                    (Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                        Empty
                                    )
                                    (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)

                        result = BTreeUniform.sort Left <|
                            uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <|
                                Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 65)
                                    (Node (MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 61)
                                        (singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64)
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
                        (BTreeUniform.sort Right uniformNothing3Nodes)
            , test "of non-empty.BTreeNothing.1b" <|
                \() ->
                    Expect.equal
                        (uniformNothing3Nodes)
                        (BTreeUniform.sort Left uniformNothing3Nodes)
            ]
        ]