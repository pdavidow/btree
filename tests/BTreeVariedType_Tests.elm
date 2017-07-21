module BTreeVariedType_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, removeDuplicates, hasAnyIntNodes)

import BTree exposing (..)
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (on)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


bTreeVariedType : Test
bTreeVariedType =
    describe "BTreeVariedType module"
         [ describe "BTreeVariedType.toLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toLength (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 3))) (BTreeVariedType.toLength (BTreeVaried (singleton (StringNode "abc"))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (IntNode 5) (singleton (IntNode 3)) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toLength (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode -500)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toIsIntPrime (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (BoolNode False))) (BTreeVariedType.toIsIntPrime (BTreeVaried (singleton (IntNode 1))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node NothingNode (singleton (UnsafeNode)) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toIsIntPrime (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode (2^53))) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.incrementNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 11))) (BTreeVariedType.incrementNodes 1 (BTreeVaried (singleton (IntNode 10))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "abcde3") (singleton (IntNode 14)) (Node (MusicNoteNode (MusicNotePlayer.on G)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.incrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.decrementNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 9))) (BTreeVariedType.decrementNodes 1 (BTreeVaried (singleton (IntNode 10))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "ab") (singleton (IntNode 8)) (Node (MusicNoteNode (MusicNotePlayer.on C_sharp)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.decrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.raiseNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 8))) (BTreeVariedType.raiseNodes 3 (BTreeVaried (singleton (IntNode 2))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 8)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.raiseNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 2)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.removeDuplicates"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.removeDuplicates (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 2))) (BTreeVariedType.removeDuplicates (BTreeVaried (singleton (IntNode 2))))
            , test "of StringNode A, MusicNoteNode... A" <|
                \() ->
                     Expect.equal (BTreeVaried (Node (StringNode "A") (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node (StringNode "A") (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty)))
            , test "of IntNode" <|
                \() ->
                     Expect.equal (BTreeVaried (Node (IntNode 2) (singleton (IntNode 1)) Empty)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node (IntNode 2) (singleton (IntNode 2)) (singleton (IntNode 1)))))
            , test "of StringNode" <|
                \() ->
                     Expect.equal (BTreeVaried (Node (StringNode "B") (singleton (StringNode "A")) Empty)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node (StringNode "B") (singleton (StringNode "B")) (singleton (StringNode "A")))))
            , test "of BoolNode" <|
                \() ->
                     Expect.equal (BTreeVaried (Node (BoolNode True) (singleton (BoolNode False)) Empty)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node (BoolNode True) (singleton (BoolNode True)) (singleton (BoolNode False)))))
            , test "of MusicNoteNode" <|
                \() ->
                     Expect.equal (BTreeVaried (Node (MusicNoteNode (MusicNotePlayer.on B)) (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node (MusicNoteNode (MusicNotePlayer.on B)) (singleton (MusicNoteNode (MusicNotePlayer.on B))) (singleton (MusicNoteNode (MusicNotePlayer.on A))))))
            , test "of NothingNode" <|
                \() ->
                     Expect.equal (BTreeVaried (singleton NothingNode)) (BTreeVariedType.removeDuplicates (BTreeVaried (Node NothingNode (singleton NothingNode) (singleton NothingNode))))
            ]
         , describe "BTreeVariedType.hasAnyIntNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried Empty))
            , test "of singleton IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried (singleton (IntNode 2))))
            , test "of 4 values, including IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 2)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            , test "of 4 values, not including IntNode" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried (Node (StringNode "abcde") (singleton (BoolNode False)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
        ]
