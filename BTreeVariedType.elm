module BTreeVariedType exposing (BTreeVariedType, BTreeVariedType(..), toStringLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, removeDuplicates)

import Arithmetic exposing (isPrime)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MusicNote exposing (mbSorter)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)


type BTreeVariedType = BTreeVaried (BTree NodeTag)


toStringLength : BTreeVariedType -> BTreeVariedType
toStringLength (BTreeVaried bTree) =
    let
        fn : NodeTag -> NodeTag
        fn nodeTag = case nodeTag of
            IntNode x ->
                NothingNode

            StringNode x ->
                IntNode (String.length x)

            BoolNode x ->
                NothingNode

            MusicNoteNode x ->
                NothingNode

            NothingNode ->
                NothingNode
    in
        BTreeVaried (map fn bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVaried bTree) =
    let
        fn : NodeTag -> NodeTag
        fn nodeTag = case nodeTag of
            IntNode x ->
                BoolNode (Arithmetic.isPrime x)

            StringNode x ->
                NothingNode

            BoolNode x ->
                NothingNode

            MusicNoteNode x ->
                NothingNode

            NothingNode ->
                NothingNode
    in
        BTreeVaried (map fn bTree)


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers (BTreeVaried bTree) =
    let
        fn : Int -> Mappers -> NodeTag -> NodeTag
        fn operand mappers nodeTag =
            case nodeTag of
                IntNode x ->
                    IntNode (mappers.int operand x)

                StringNode x ->
                    StringNode (mappers.string operand x)

                BoolNode x ->
                    BoolNode (mappers.bool operand x)

                MusicNoteNode x ->
                    MusicNoteNode (mappers.musicNotePlayer operand x)

                NothingNode ->
                    NothingNode
    in
        BTreeVaried (map (fn operand mappers) bTree)


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTreeVaried =
    mapVariedTree delta incrementMappers bTreeVaried


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTreeVaried =
    mapVariedTree delta decrementMappers bTreeVaried


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTreeVaried =
    mapVariedTree exp raiseMappers bTreeVaried


removeDuplicates : BTreeVariedType -> BTreeVariedType
removeDuplicates (BTreeVaried bTree) =
    let
        fn = \node ->
            case node of
                IntNode v ->
                    toString node

                StringNode v ->
                    toString node

                BoolNode v ->
                    toString node

                MusicNoteNode (MusicNotePlayer params) ->
                    "MusicNoteNode " ++ (MusicNote.mbSorter params.mbNote)

                NothingNode ->
                    toString node
    in
        BTreeVaried (BTree.removeDuplicatesBy fn bTree)