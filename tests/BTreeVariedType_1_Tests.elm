module BTreeVariedType_1_Tests exposing (..)

import BTreeVaried exposing (BTreeVaried(..), toLength, toIsIntPrime)
import BigInt exposing (fromInt)

import BTree exposing (BTree(..), singleton, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))

import MusicNote exposing (MusicNote(..), MidiNumber(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import TestsHelper exposing (toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect

  
bTreeVariedType_1 : Test
bTreeVariedType_1 =
    describe "BTreeVaried module"
         [ describe "BTreeVaried.toLength"
            [ test "of Empty" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried Empty
                        )
                        ( BTreeVaried.toLength <| BTreeVaried Empty
                        )
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt -12
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt 34567
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Unsafe
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt -12
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 34567
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 16
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 2
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toStringVariety <| "ab"
                        )
            ,  test "of non-empty.StringVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toIntVariety <| Safe 5
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toStringVariety <| "cdefg"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| StringVariety <| StringNodeVal "220 hz"
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toLength <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVaried.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVaried.toIsIntPrime (BTreeVaried Empty))
            ,  test "of non-empty.IntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Nothing
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.IntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Just False
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.IntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| toBoolVariety <| Just True
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toIntVariety <| toMaybeSafeInt 13
                        )
            ,  test "of non-empty.BigIntVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 1
                        )
            ,  test "of non-empty.BigIntVariety.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt <| negate <| maxSafeInteger
                        )
            ,  test "of non-empty.BigIntVariety.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toBigIntVariety <| BigInt.fromInt 13
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toStringVariety <| "a"
                        )
            ,  test "of non-empty.BoolVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toBoolVariety <| Just True
                        )
            ,  test "of non-empty.MusicNoteVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57
                        )
            ,  test "of non-empty.NothingVariety.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            singleton <| NothingVariety <| NothingNodeVal
                        )
                        ( BTreeVaried.toIsIntPrime <| BTreeVaried <|
                            singleton <| NothingVariety <| NothingNodeVal
                        )
            ]
         , describe "BTreeVaried.deDuplicate"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVaried.deDuplicate (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| 
                            (singleton <| toIntVariety <| Safe 2)
                        )
                        ( BTreeVaried.deDuplicate <| BTreeVaried <|
                            (singleton <| toIntVariety <| Safe 2)
                        )
            , test "of StringNode A, MusicNoteNode... A" <|
                \() ->
                     Expect.equal
                        ( BTreeVaried <|
                            Node (toStringVariety <|  "A")
                                (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                                Empty
                        )
                        ( BTreeVaried.deDuplicate <| BTreeVaried <|
                            Node (toStringVariety <|  "A")
                                (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
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
                        ( BTreeVaried.deDuplicate <| BTreeVaried <|
                            Node (toIntVariety <| Safe 2)
                                (singleton <| toIntVariety <| Safe 2)
                                (Node (toIntVariety <| Unsafe)
                                    (singleton <| toIntVariety <| Unsafe)
                                    Empty
                                )
                        )
            , test "of BigIntNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) (BTreeVaried.deDuplicate (BTreeVaried <| Node (toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) (singleton <| toBigIntVariety <| BigInt.fromInt <| maxSafeInteger + 2) Empty))
            , test "of StringNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toStringVariety "B") (singleton <| toStringVariety "A") Empty) (BTreeVaried.deDuplicate (BTreeVaried <| Node (toStringVariety "B") (singleton <| toStringVariety "B") (singleton <| toStringVariety "A")))
            , test "of BoolNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just False) Empty) (BTreeVaried.deDuplicate (BTreeVaried <| Node (toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just True) (singleton <| toBoolVariety <| Just False)))
            , test "of MusicNoteNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 59) (singleton <| toMusicNoteVariety (MusicNotePlayer.on <| MusicNote <| MidiNumber 57)) Empty) (BTreeVaried.deDuplicate (BTreeVaried <| Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 59) (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 59) (singleton <| toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)))
            , test "of NothingNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| singleton <| NothingVariety <| NothingNodeVal) (BTreeVaried.deDuplicate (BTreeVaried <| Node (NothingVariety <| NothingNodeVal) (singleton <| NothingVariety <| NothingNodeVal) (singleton <| NothingVariety <| NothingNodeVal)))
            ]
         , describe "BTreeVaried.hasAnyIntNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal False (BTreeVaried.hasAnyIntNodes (BTreeVaried Empty))
            , test "of singleton IntNode" <|
                \() ->
                    Expect.equal True (BTreeVaried.hasAnyIntNodes (BTreeVaried <| singleton <| toIntVariety <| Safe 2))
            , test "of 4 values, including IntNode but not BigIntNode" <|
                \() ->
                    Expect.equal True (BTreeVaried.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety <| "abcde") (singleton <| toIntVariety <| Safe 2) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64) (singleton <| toBoolVariety <| Just True) Empty)))
            , test "of 4 values, neither including IntNode, nor BigIntNode" <|
                \() ->
                    Expect.equal False (BTreeVaried.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety "abcde") (singleton <| toBoolVariety <| Just False) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 64) (singleton <| toBoolVariety <| Just True) Empty)))
            , test "of singleton BigIntNode" <|
                \() ->
                    Expect.equal True (BTreeVaried.hasAnyIntNodes (BTreeVaried <| singleton <| toBigIntVariety <| BigInt.fromInt 2))
            , test "of 4 values, including BigIntNode but not IntNode" <|
                \() ->
                    Expect.equal True (BTreeVaried.hasAnyIntNodes (BTreeVaried <| Node (toStringVariety "abcde") (singleton <| toBigIntVariety <| BigInt.fromInt 2) (Node (toMusicNoteVariety <| MusicNotePlayer.on <| MusicNote <| MidiNumber 65) (singleton <| toBoolVariety <| Just True) Empty)))
            ]         
        ]
