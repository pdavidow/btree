module BTreeVariedType exposing (..)

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
            StringNode s ->
                IntNode (String.length s)

            IntNode i -> -- no op
                nodeTag

            BoolNode b -> -- no op
                nodeTag
    in
        BTreeVaried (map func bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVaried bTree) =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
            IntNode i ->
                BoolNode (Arithmetic.isPrime i)

            StringNode s -> -- no op
                nodeTag

            BoolNode b -> -- no op
                nodeTag
    in
        BTreeVaried (map func bTree)


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers (BTreeVaried bTree) =
    let
        func : Int -> Mappers -> NodeTag -> NodeTag
        func operand mappers nodeTag =
            case nodeTag of
                IntNode i ->
                    IntNode (mappers.int operand i)

                StringNode s ->
                    StringNode (mappers.string operand s)

                BoolNode b ->
                    BoolNode (mappers.bool operand b)
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