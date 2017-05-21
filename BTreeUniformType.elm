module BTreeUniformType exposing (..)

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, map, depth, sumInt, sumString, sort)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)


type BTreeUniformType
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)


toTaggedBTree : BTreeUniformType -> BTree NodeTag
toTaggedBTree bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeString bTree ->
            map StringNode bTree


mapUniformTree : Int -> Mappers -> BTreeUniformType -> BTreeUniformType
mapUniformTree operand mappers bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (mappers.int operand) bTree)

        BTreeString bTree ->
            BTreeString (map (mappers.string operand) bTree)


incrementNodes : Int -> BTreeUniformType -> BTreeUniformType
incrementNodes delta bTreeUniformType =
    mapUniformTree delta incrementMappers bTreeUniformType


decrementNodes : Int -> BTreeUniformType -> BTreeUniformType
decrementNodes delta bTreeUniformType =
    mapUniformTree delta decrementMappers bTreeUniformType


raiseNodes : Int -> BTreeUniformType -> BTreeUniformType
raiseNodes exp bTreeUniformType =
    mapUniformTree exp raiseMappers bTreeUniformType


depth : BTreeUniformType -> Int
depth bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTree.depth bTree

        BTreeString bTree ->
            BTree.depth bTree


sumInt : BTreeUniformType -> Int
sumInt bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTree.sumInt bTree

        BTreeString bTree ->
            0


sumString : BTreeUniformType -> String
sumString bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            ""

        BTreeString bTree ->
            BTree.sumString bTree

sort : BTreeUniformType -> BTreeUniformType
sort bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (BTree.sort bTree)

        BTreeString bTree ->
            BTreeString (BTree.sort bTree)