module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)


type alias BTreeVariedType = BTree NodeTag


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers bTree =
    let
        func operand mappers nodeTag =
            case nodeTag of
                IntNode i ->
                    IntNode (mappers.int operand i)

                StringNode s ->
                    StringNode (mappers.string operand s)
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