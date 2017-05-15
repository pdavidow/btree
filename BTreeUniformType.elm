module BTreeUniformType exposing (..)

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, map, depth, sumInt, sumString)


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


incrementNodes : BTreeUniformType -> Int -> BTreeUniformType
incrementNodes bTreeUniformType delta =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                func = \n -> n + delta
            in
                BTreeInt (map func bTree)

        BTreeString bTree ->
            let
                func = \s -> s ++ " +" ++ (toString delta)
            in
                BTreeString (map func bTree)


decrementNodes : BTreeUniformType -> Int -> BTreeUniformType
decrementNodes bTreeUniformType delta =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                func = \n -> n - delta
            in
                BTreeInt (map func bTree)

        BTreeString bTree ->
            let
                func = \s -> s ++ " -" ++ (toString delta)
            in
                BTreeString (map func bTree)


raiseNodes : BTreeUniformType -> Int -> BTreeUniformType
raiseNodes bTreeUniformType exp =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                func = \n -> n ^ exp
            in
                BTreeInt (map func bTree)

        BTreeString bTree ->
            let
                func = \s -> s ++ " ^" ++ (toString exp)
            in
                BTreeString (map func bTree)


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