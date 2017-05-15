module BTreeUniformContent exposing (..)

import BTree exposing (BTree, map, depth, sumInt, sumString)

type BTreeUniformContent
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)


type NodeTag
    = IntNode Int
    | StringNode String


toTaggedBTree : BTreeUniformContent -> BTree NodeTag
toTaggedBTree bTreeUniformContent =
    case bTreeUniformContent of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeString bTree ->
            map StringNode bTree


incrementNodes : BTreeUniformContent -> Int -> BTreeUniformContent
incrementNodes bTreeUniformContent delta =
    case bTreeUniformContent of
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


decrementNodes : BTreeUniformContent -> Int -> BTreeUniformContent
decrementNodes bTreeUniformContent delta =
    case bTreeUniformContent of
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


raiseNodes : BTreeUniformContent -> Int -> BTreeUniformContent
raiseNodes bTreeUniformContent exp =
    case bTreeUniformContent of
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


-- Can this be simplified with pattern matching?
depth : BTreeUniformContent -> Int
depth bTreeUniformContent =
    case bTreeUniformContent of
        BTreeInt bTree ->
            BTree.depth bTree

        BTreeString bTree ->
            BTree.depth bTree


sumInt : BTreeUniformContent -> Int
sumInt bTreeUniformContent =
    case bTreeUniformContent of
        BTreeInt bTree ->
            BTree.sumInt bTree

        BTreeString bTree ->
            0


sumString : BTreeUniformContent -> String
sumString bTreeUniformContent =
    case bTreeUniformContent of
        BTreeInt bTree ->
            ""

        BTreeString bTree ->
            BTree.sumString bTree