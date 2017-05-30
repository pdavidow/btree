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
            IntNode x -> -- no op
                nodeTag

            StringNode x ->
                IntNode (String.length x)

            BoolNode x -> -- no op
                nodeTag

            MusicScaleNode x -> -- no op
                nodeTag
    in
        BTreeVaried (map func bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVaried bTree) =
    let
        func : NodeTag -> NodeTag
        func nodeTag = case nodeTag of
            IntNode x ->
                BoolNode (Arithmetic.isPrime x)

            StringNode x -> -- no op
                nodeTag

            BoolNode x -> -- no op
                nodeTag

            MusicScaleNode x -> -- no op
                nodeTag
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

                MusicScaleNode x ->
                    MusicScaleNode x -- todo (mappers.musicScale operand x)
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