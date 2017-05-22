module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isPrime)


type BTreeVariedType = BTreeVariedTypeValue (BTree NodeTag)


toStringLength : BTreeVariedType -> BTreeVariedType
toStringLength (BTreeVariedTypeValue bTree) =
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
        BTreeVariedTypeValue (map func bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVariedTypeValue bTree) =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
            IntNode i ->
                BoolNode (Arithmetic.isPrime i)

            StringNode s -> -- no op
                StringNode s

            BoolNode b -> -- no op
                BoolNode b
    in
        BTreeVariedTypeValue (map func bTree)


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers (BTreeVariedTypeValue bTree) =
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
        BTreeVariedTypeValue (map (func operand mappers) bTree)


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTreeVariedTypeValue =
    mapVariedTree delta incrementMappers bTreeVariedTypeValue


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTreeVariedTypeValue =
    mapVariedTree delta decrementMappers bTreeVariedTypeValue


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTreeVariedTypeValue =
    mapVariedTree exp raiseMappers bTreeVariedTypeValue