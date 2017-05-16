module BTreeUniformType exposing (..)

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, map, depth, sumInt, sumString, sort)
import ValueOps exposing (..)


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


incrementNodes : Int -> BTreeUniformType -> BTreeUniformType
incrementNodes delta bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (ValueOps.incrementInt delta) bTree)

        BTreeString bTree ->
            BTreeString (map (ValueOps.incrementString delta) bTree)


decrementNodes : Int -> BTreeUniformType -> BTreeUniformType
decrementNodes delta bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (ValueOps.decrementInt delta) bTree)

        BTreeString bTree ->
            BTreeString (map (ValueOps.decrementString delta) bTree)


raiseNodes : Int -> BTreeUniformType -> BTreeUniformType
raiseNodes exp bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (ValueOps.raiseInt exp) bTree)

        BTreeString bTree ->
            BTreeString (map (ValueOps.raiseString exp) bTree)


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