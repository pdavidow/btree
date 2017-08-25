module BTreeUniformType_3_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, nodeValOperate, depth, sumInt, sort, deDuplicate, isAllNothing)

import BTree exposing (BTree(..), Direction(..), fromIntList, fromList, fromListBy, singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt, toMaybeSafeInt)
import Lib exposing (IntFlex(..))
import BigInt exposing (fromInt, toString)
import TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes)
 
import Test exposing (..)
import Expect
 

bTreeUniformType_3 : Test
bTreeUniformType_3 =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.depth"
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
                            [ BTreeUniformType.depth <| BTreeInt <| Empty
                            , BTreeUniformType.depth <| BTreeBigInt <| Empty
                            , BTreeUniformType.depth <| BTreeString <| Empty
                            , BTreeUniformType.depth <| BTreeBool <| Empty
                            , BTreeUniformType.depth <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.depth <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( 3
                        )
                        ( BTreeUniformType.depth <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [40, 50, 60]
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( 3
                        )
                        ( BTreeUniformType.depth <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt 40, BigInt.fromInt 50, BigInt.fromInt 60]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( 4
                        )
                        ( BTreeUniformType.depth <| BTreeString <| BTree.map StringNodeVal <| BTree.fromList ["a", "b", "c", "d"]
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniformType.depth <| BTreeBool <| singleton <| BoolNodeVal <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( 2
                        )
                        ( BTreeUniformType.depth <| BTreeMusicNotePlayer <| BTree.map MusicNoteNodeVal <| BTree.fromListBy Basics.toString [MusicNotePlayer.on A, MusicNotePlayer.on A]
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniformType.depth <| uniformNothingSingelton
                        )
            ]
         , describe "BTreeUniformType.sumInt"
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
                            [ BTreeUniformType.sumInt <| BTreeInt <| Empty
                            , BTreeUniformType.sumInt <| BTreeBigInt <| Empty
                            , BTreeUniformType.sumInt <| BTreeString <| Empty
                            , BTreeUniformType.sumInt <| BTreeBool <| Empty
                            , BTreeUniformType.sumInt <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.sumInt <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe -10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [40, -50]
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInt - 10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt - 40, 30]
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| negate <| maxSafeInt - 10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [negate <| maxSafeInt - 40, -30]
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt - 40, 30, 20]
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [-100, maxSafeInt + 1]
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt - 40, 50, -20]
                        )
            , test "of non-empty.BTreeInt.6.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt, 50, -40, -20]
                        )
            , test "of non-empty.BTreeInt.6.1.1" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [-9, 4, 4, maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.6.1.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt, -9, 4, 4]
                        )
            , test "of non-empty.BTreeInt.6.1.3" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [-1, maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.6.1.4" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt, -1]
                        )
            , test "of non-empty.BTreeInt.6.2" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| Node (toMaybeSafeInt maxSafeInt) (singleton <| toMaybeSafeInt 40) (Node (toMaybeSafeInt -90) Empty (singleton <| toMaybeSafeInt 40))
                        )
            , test "of non-empty.BTreeInt.7" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe 0
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt, negate maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.8" <|
                \() ->
                    Expect.equal
                        ( Just <| IntVal <| Safe maxSafeInt
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.map IntNodeVal <| BTree.fromIntList [maxSafeInt]
                        )
            , test "of non-empty.BTreeBigInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt 40) (BigInt.fromInt -50)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt 40, BigInt.fromInt -50]
                        )
            , test "of non-empty.BTreeBigInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt -40) (BigInt.fromInt 30)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -40, BigInt.fromInt 30]
                        )
            , test "of non-empty.BTreeBigInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInt - 40) (BigInt.fromInt -30)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| negate <| maxSafeInt - 40, BigInt.fromInt -30]
                        )
            , test "of non-empty.BTreeBigInt.4" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInt - 40) (BigInt.fromInt 30)) (BigInt.fromInt 20)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInt - 40, BigInt.fromInt 30, BigInt.fromInt 20]
                        )
            , test "of non-empty.BTreeBigInt.5" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt <| -100) (BigInt.fromInt <| maxSafeInt + 1)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -100, BigInt.fromInt <| maxSafeInt + 1]
                        )
            , test "of non-empty.BTreeBigInt.6" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInt - 40) (BigInt.fromInt 50)) (BigInt.fromInt -20)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInt - 40, BigInt.fromInt 50, BigInt.fromInt -20]
                        )
            , test "of non-empty.BTreeBigInt.6.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt 50)) (BigInt.fromInt -40)) (BigInt.fromInt -20)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt <| maxSafeInt, BigInt.fromInt 50, BigInt.fromInt -40, BigInt.fromInt -20]
                        )
            , test "of non-empty.BTreeBigInt.6.1.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt -9) (BigInt.fromInt 4)) (BigInt.fromInt 4)) (BigInt.fromInt maxSafeInt)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy Basics.toString [BigInt.fromInt -9, BigInt.fromInt 4, BigInt.fromInt 4, BigInt.fromInt maxSafeInt]
                        )
            , test "of non-empty.BTreeBigInt.6.1.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt maxSafeInt) (BigInt.fromInt -9)) (BigInt.fromInt 4)) (BigInt.fromInt 4)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInt, BigInt.fromInt -9, BigInt.fromInt 4, BigInt.fromInt 4]
                        )
            , test "of non-empty.BTreeBigInt.6.1.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt -1) (BigInt.fromInt maxSafeInt)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt -1, BigInt.fromInt maxSafeInt]
                        )
            , test "of non-empty.BTreeBigInt.6.1.4" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInt) (BigInt.fromInt -1)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInt, BigInt.fromInt -1]
                        )
            , test "of non-empty.BTreeBigInt.6.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt maxSafeInt) (BigInt.fromInt 40)) (BigInt.fromInt -90)) (BigInt.fromInt 40)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| Node (BigInt.fromInt maxSafeInt) (singleton <| BigInt.fromInt 40) (Node (BigInt.fromInt -90) Empty (singleton <| BigInt.fromInt 40))
                        )
            , test "of non-empty.BTreeBigInt.7" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInt) (BigInt.fromInt -maxSafeInt)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInt, BigInt.fromInt <| negate maxSafeInt]
                        )
            , test "of non-empty.BTreeBigInt.8" <|
                \() ->
                    Expect.equal
                        ( Just <| BigIntVal <| BigInt.add (BigInt.fromInt maxSafeInt) (BigInt.fromInt 0)
                        )
                        ( BTreeUniformType.sumInt <| BTreeBigInt <| BTree.map BigIntNodeVal <| BTree.fromListBy BigInt.toString [BigInt.fromInt maxSafeInt]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeString <| BTree.map StringNodeVal <| singleton "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeBool <| BTree.map BoolNodeVal <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeMusicNotePlayer <| BTree.map MusicNoteNodeVal <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| uniformNothingSingelton
                        )
            ]
        ]