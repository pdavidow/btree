module BTreeVariedType_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
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
         [ describe "BTreeVariedType.toStringLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toStringLength (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 3))) (BTreeVariedType.toStringLength (BTreeVaried (singleton (StringNode "abc"))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (IntNode 5) (singleton NothingNode) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toStringLength (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 1)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
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
                    Expect.equal (BTreeVaried (Node NothingNode (singleton (BoolNode True)) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toIsIntPrime (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
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
                    Expect.equal (BTreeVaried (Node (StringNode "abcde +3") (singleton (IntNode 14)) (Node (MusicNoteNode (MusicNotePlayer.on G)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.incrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
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
                    Expect.equal (BTreeVaried (Node (StringNode "abcde -3") (singleton (IntNode 8)) (Node (MusicNoteNode (MusicNotePlayer.on C_sharp)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.decrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
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
                    Expect.equal (BTreeVaried (Node (StringNode "abcde ^3") (singleton (IntNode 8)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.raiseNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 2)) (Node (MusicNoteNode (MusicNotePlayer.on E)) (singleton (BoolNode True)) Empty))))
            ]
        ]
