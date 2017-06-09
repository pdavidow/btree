module BTreeVariedType exposing (BTreeVariedType, BTreeVariedType(..), toStringLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isPrime)


type BTreeVariedType = BTreeVaried (BTree NodeTag)


toStringLength : BTreeVariedType -> BTreeVariedType
toStringLength (BTreeVaried bTree) =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
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
        BTreeVaried (map func bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVaried bTree) =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
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
        BTreeVaried (map func bTree)


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers (BTreeVaried bTree) =
    let
        func : Int -> Mappers -> NodeTag -> NodeTag
        func operand mappers nodeTag =
            case nodeTag of
                IntNode x ->
                    IntNode (mappers.int operand x)

                StringNode x ->
                    StringNode (mappers.string operand x)

                BoolNode x ->
                    BoolNode (mappers.bool operand x)

                MusicNoteNode x ->
                    MusicNoteNode (mappers.musicNote operand x)

                NothingNode ->
                    NothingNode
    in
        BTreeVaried (map (func operand mappers) bTree)


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTreeVaried =
    mapVariedTree delta incrementMappers bTreeVaried


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTreeVaried =
    mapVariedTree delta decrementMappers bTreeVaried


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTreeVaried =
    mapVariedTree exp raiseMappers bTreeVaried