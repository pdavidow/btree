module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isPrime)


type alias BTreeVariedType = BTree NodeTag


toStringLength : BTreeVariedType -> BTreeVariedType
toStringLength bTree =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
            IntNode i -> -- no op
                IntNode i

            StringNode s ->
                IntNode (String.length s)

            BoolNode b -> -- no op
                BoolNode b
    in
        map func bTree


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime bTree =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
            IntNode i -> -- no op
                BoolNode (Arithmetic.isPrime i)

            StringNode s -> -- no op
                StringNode s

            BoolNode b -> -- no op
                BoolNode b
    in
        map func bTree


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers bTree =
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
        map (func operand mappers) bTree


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTree =
    mapVariedTree delta incrementMappers bTree


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTree =
    mapVariedTree delta decrementMappers bTree


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTree =
    mapVariedTree exp raiseMappers bTree