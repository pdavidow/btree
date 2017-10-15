module BTreeVariedType_1_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, nodeValOperate, deDuplicate, hasAnyIntNodes)
import BigInt exposing (fromInt)

import BTree exposing (BTree(..), singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))

import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect

  
bTreeVariedType_1 : Test
bTreeVariedType_1 =
    describe "BTreeVariedType module"
         [ describe "BTreeVariedType.toLength"
            [ test "of Empty" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried Empty
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried Empty
                        )
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt -12
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toIntVariety <| toMaybeSafeInt 34567
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt -12
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt 34567
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 16
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toStringVariety <| "ab"
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toStringVariety <| "cdefg"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| 
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 57
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVariedType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toIsIntPrime (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Nothing
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toIntVariety <| toMaybeSafeInt 13
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toBigIntVariety <| BigInt.fromInt 13
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toStringVariety <| "a"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 57
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVariedType.deDuplicate"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.deDuplicate (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            (singleton <| toIntVariety <| Safe 2)
                        )
                        ( BTreeVariedType.deDuplicate <| BTreeVaried <| 
                            (singleton <| toIntVariety <| Safe 2)
                        )
            , test "of StringNode A, MusicNoteNode... A" <|
                \() ->
                     Expect.equal
                        ( BTreeVaried <|
                            Node (toStringVariety <|  "A")
                                (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 57)
                                Empty
                        )
                        ( BTreeVariedType.deDuplicate <| BTreeVaried <|
                            Node (toStringVariety <|  "A")
                                (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 57)
                                Empty
                        )
            , test "of IntNode" <|
                \() ->
                     Expect.equal
                        ( BTreeVaried <|
                            Node (toIntVariety <| Safe 2)
                                (singleton <| toIntVariety <| Unsafe)
                                Empty
                        )
                        ( BTreeVariedType.deDuplicate <| BTreeVaried <|
                            Node (toIntVariety <| Safe 2)
                                (singleton <| toIntVariety <| Safe 2)
                                (Node (toIntVariety <| Unsafe)
                                    (singleton <| toIntVariety <| Unsafe)
                                    Empty
                                )
                        )
            , test "of BigIntNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) (singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) Empty))
            , test "of StringNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toStringVariety "B") (singleton <| toStringVariety "A") Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (toStringVariety "B") (singleton <| toStringVariety "B") (singleton <| toStringVariety "A")))
            , test "of BoolNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just False) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just False)))
            , test "of MusicNoteNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 59) (singleton <| toMusicNoteVariety (MusicNotePlayer.on <| MusicNote 57)) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 59) (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 59) (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 57)))
            , test "of NothingNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| singleton <| NothingVariety <| NothingNodeVal) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (NothingVariety <| NothingNodeVal) (singleton <| NothingVariety <| NothingNodeVal) (singleton <| NothingVariety <| NothingNodeVal)))
            ]
         , describe "BTreeVariedType.hasAnyIntNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried Empty))
            , test "of singleton IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| singleton <| toIntVariety <| Safe 2))
            , test "of 4 values, including IntNode but not BigIntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety <| "abcde") (singleton <| toIntVariety <| Safe 2) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 64) (singleton <| toBoolVariety <| Just True) Empty)))
            , test "of 4 values, neither including IntNode, nor BigIntNode" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety "abcde") (singleton <| toBoolVariety <| Just False) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 64) (singleton <| toBoolVariety <| Just True) Empty)))
            , test "of singleton BigIntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| singleton <| toBigIntVariety <| BigInt.fromInt 2))
            , test "of 4 values, including BigIntNode but not IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety "abcde") (singleton <| toBigIntVariety <| BigInt.fromInt 2) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote 65) (singleton <| toBoolVariety <| Just True) Empty)))
            ]         
        ]
