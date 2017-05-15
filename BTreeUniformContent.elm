module BTreeUniformContent exposing (..)

import BTree exposing (BTree, map, depth, sumInt, sumString)

type BTreeUniformContent
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)


incrementNodes : BTreeUniformContent -> Int -> BTreeUniformContent
incrementNodes btreeUniformContent delta =
    case btreeUniformContent of
        BTreeInt btree ->
            let
                func = \n -> n + delta
            in
                BTreeInt (map func btree)

        BTreeString btree ->
            let
                func = \s -> s ++ " inc" ++ (toString delta)
            in
                BTreeString (map func btree)


decrementNodes : BTreeUniformContent -> Int -> BTreeUniformContent
decrementNodes btreeUniformContent delta =
    case btreeUniformContent of
        BTreeInt btree ->
            let
                func = \n -> n - delta
            in
                BTreeInt (map func btree)

        BTreeString btree ->
            let
                func = \s -> s ++ " dec" ++ (toString delta)
            in
                BTreeString (map func btree)


exponentizeNodes : BTreeUniformContent -> Int -> BTreeUniformContent
exponentizeNodes btreeUniformContent exp =
    case btreeUniformContent of
        BTreeInt btree ->
            let
                func = \n -> n^exp
            in
                BTreeInt (map func btree)

        BTreeString btree ->
            let
                func = \s -> s ++ " exp" ++ (toString exp)
            in
                BTreeString (map func btree)


-- Can this be simplified with pattern matching?
depth : BTreeUniformContent -> Int
depth btreeUniformContent =
    case btreeUniformContent of
        BTreeInt btree ->
            BTree.depth btree

        BTreeString btree ->
            BTree.depth btree


sumInt : BTreeUniformContent -> Int
sumInt btreeUniformContent =
    case btreeUniformContent of
        BTreeInt btree ->
            BTree.sumInt btree

        BTreeString btree ->
            0


sumString : BTreeUniformContent -> String
sumString btreeUniformContent =
    case btreeUniformContent of
        BTreeInt btree ->
            ""
        BTreeString btree ->
            BTree.sumString btree