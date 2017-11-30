module BTreeUniformType_3_Tests exposing (..)

import BTreeUniform exposing (BTreeUniform(..), depth, sumInt, uniformIntTreeFrom, uniformBigIntTreeFrom, uniformStringTreeFrom, uniformBoolTreeFrom, uniformMusicNotePlayerTreeFrom, uniformNothingTreeFrom)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import Lib exposing (IntFlex(..))
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
import TreePlayerParams exposing (defaultTreePlayerParams)

import BigInt exposing (fromInt, toString)
import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect
 

bTreeUniformType_3 : Test
bTreeUniformType_3 =
    describe "BTreeUniform module"
         [ describe "BTreeUniform.depth"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ 0
                            , 0
                            , 0
                            , 0
                            , 0
                            , 0
                            ]
                        )
                        (
                            [ BTreeUniform.depth <| uniformIntTreeFrom Empty
                            , BTreeUniform.depth <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.depth <| uniformStringTreeFrom Empty
                            , BTreeUniform.depth <| uniformBoolTreeFrom Empty
                            , BTreeUniform.depth <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.depth <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( 3
                        )
                        ( BTreeUniform.depth <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [40, 50, 60]
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( 3
                        )
                        ( BTreeUniform.depth <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt 40, BigInt.fromInt 50, BigInt.fromInt 60]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( 4
                        )
                        ( BTreeUniform.depth <| uniformStringTreeFrom <| BTree.map StringNodeVal <| BTree.fromList ["a", "b", "c", "d"]
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniform.depth <| uniformBoolTreeFrom <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( 2
                        )
                        ( BTreeUniform.depth <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <| BTree.fromListBy Basics.toString [MusicNotePlayer.on <| MusicNote <| MidiNumber 57, MusicNotePlayer.on <| MusicNote <| MidiNumber 57]
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniform.depth <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniform.sumInt"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| IntVal <| Safe 0
                            , Just <| BigIntVal <| BigInt.fromInt 0
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniform.sumInt <| uniformIntTreeFrom Empty
                            , BTreeUniform.sumInt <| uniformBigIntTreeFrom Empty
                            , BTreeUniform.sumInt <| uniformStringTreeFrom Empty
                            , BTreeUniform.sumInt <| uniformBoolTreeFrom Empty
                            , BTreeUniform.sumInt <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams Empty
                            , BTreeUniform.sumInt <| uniformNothingTreeFrom Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe -10
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [40, -50]
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInteger - 10
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger - 40, 30]
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| negate <| maxSafeInteger - 10
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [negate <| maxSafeInteger - 40, -30]
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger - 40, 30, 20]
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [-100, maxSafeInteger + 1]
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger - 40, 50, -20]
                        )
            , test "of non-empty.BTreeInt.6.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger, 50, -40, -20]
                        )
            , test "of non-empty.BTreeInt.6.1.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInteger - 1
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [-9, 4, 4, maxSafeInteger]
                        )
            , test "of non-empty.BTreeInt.6.1.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInteger - 1
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger, -9, 4, 4]
                        )
            , test "of non-empty.BTreeInt.6.1.3" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInteger - 1
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [-1, maxSafeInteger]
                        )
            , test "of non-empty.BTreeInt.6.1.4" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInteger - 1
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger, -1]
                        )
            , test "of non-empty.BTreeInt.6.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| Node (toMaybeSafeInt maxSafeInteger) (singleton <| toMaybeSafeInt 40) (Node (toMaybeSafeInt -90) Empty (singleton <| toMaybeSafeInt 40))
                        )
            , test "of non-empty.BTreeInt.7" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe 0
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger, negate maxSafeInteger]
                        )
            , test "of non-empty.BTreeInt.8" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe maxSafeInteger
                        )
                        ( BTreeUniform.sumInt <| uniformIntTreeFrom <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInteger]
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt 40) (BigInt.fromInt -50)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt 40, BigInt.fromInt -50]
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt -40) (BigInt.fromInt 30)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -40, BigInt.fromInt 30]
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInteger - 40) (BigInt.fromInt -30)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| negate <| maxSafeInteger - 40, BigInt.fromInt -30]
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInteger - 40) (BigInt.fromInt 30)) (BigInt.fromInt 20)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInteger - 40, BigInt.fromInt 30, BigInt.fromInt 20]
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt <| -100) (BigInt.fromInt <| maxSafeInteger + 1)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -100, BigInt.fromInt <| maxSafeInteger + 1]
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInteger - 40) (BigInt.fromInt 50)) (BigInt.fromInt -20)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInteger - 40, BigInt.fromInt 50, BigInt.fromInt -20]
                        )
            , test "of non-empty.BTreeBigInt.6.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInteger) (BigInt.fromInt 50)) (BigInt.fromInt -40)) (BigInt.fromInt -20)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInteger, BigInt.fromInt 50, BigInt.fromInt -40, BigInt.fromInt -20]
                        )
            , test "of non-empty.BTreeBigInt.6.1.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt -9) (BigInt.fromInt 4)) (BigInt.fromInt 4)) (BigInt.fromInt maxSafeInteger)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy Basics.toString [BigInt.fromInt -9, BigInt.fromInt 4, BigInt.fromInt 4, BigInt.fromInt maxSafeInteger]
                        )
            , test "of non-empty.BTreeBigInt.6.1.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt maxSafeInteger) (BigInt.fromInt -9)) (BigInt.fromInt 4)) (BigInt.fromInt 4)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInteger, BigInt.fromInt -9, BigInt.fromInt 4, BigInt.fromInt 4]
                        )
            , test "of non-empty.BTreeBigInt.6.1.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt -1) (BigInt.fromInt maxSafeInteger)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -1, BigInt.fromInt maxSafeInteger]
                        )
            , test "of non-empty.BTreeBigInt.6.1.4" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInteger) (BigInt.fromInt -1)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInteger, BigInt.fromInt -1]
                        )
            , test "of non-empty.BTreeBigInt.6.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt maxSafeInteger) (BigInt.fromInt 40)) (BigInt.fromInt -90)) (BigInt.fromInt 40)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| Node (BigInt.fromInt maxSafeInteger) (singleton <| BigInt.fromInt 40) (Node (BigInt.fromInt -90) Empty (singleton <| BigInt.fromInt 40))
                        )
            , test "of non-empty.BTreeBigInt.7" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInteger) (BigInt.fromInt -maxSafeInteger)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInteger, BigInt.fromInt <| negate maxSafeInteger]
                        )
            , test "of non-empty.BTreeBigInt.8" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInteger) (BigInt.fromInt 0)
                        )
                        ( BTreeUniform.sumInt <| uniformBigIntTreeFrom <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInteger]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.sumInt <| uniformStringTreeFrom <| BTree.map StringNodeVal <| singleton "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.sumInt <| uniformBoolTreeFrom <| BTree.map BoolNodeVal <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.sumInt <| uniformMusicNotePlayerTreeFrom defaultTreePlayerParams <| BTree.map MusicNoteNodeVal <| singleton <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniform.sumInt <| uniformNothingSingelton
                        )
            ]
        ]