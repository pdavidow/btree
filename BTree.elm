-- http://elm-lang.org/examples/binary-Tree

module BTree exposing (BTree, BTree(..), NodeTag, NodeTag(..), singleton, depth, map, sum, flatten, isElement, fold, sumUsingFold, sumInt, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortBy, fromList, fromListBy, insert, insertBy, removeDuplicates, removeDuplicatesBy, isAllNothing, isEmpty)

import TreeDiagram as TD exposing (node, Tree)
import List.Extra exposing (uniqueBy)
import Maybe.Extra exposing (values)

import MusicNotePlayer exposing (MusicNotePlayer(..))


type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


type NodeTag
    = IntNode Int
    | StringNode String
    | BoolNode Bool
    | MusicNoteNode MusicNotePlayer
    | NothingNode


singleton : a -> BTree a
singleton v =
    Node v Empty Empty


depth : BTree a -> Int
depth bTree =
    case bTree of
        Empty ->
            0

        Node v left right ->
            1 + max (depth left) (depth right)


map : (a -> b) -> BTree a -> BTree b
map func bTree =
    case bTree of
        Empty ->
            Empty

        Node v left right ->
            Node (func v) (map func left) (map func right)


sum : BTree number -> number
sum bTree =
    case bTree of
        Empty ->
            0

        Node number left right ->
            number + (sum left) + (sum right)


flatten : BTree a -> List a
flatten bTree =
    case bTree of
        Empty ->
            []

        Node v left right ->
            v :: ((flatten left) ++ (flatten right))


isElement : a -> BTree a -> Bool
isElement a bTree =
    case bTree of
        Empty ->
            False

        Node v left right ->
            if v == a then True
            else (isElement a left) || (isElement a right)


fold : (a -> b -> b) -> b -> BTree a -> b
fold func acc bTree =
    case bTree of
        Empty ->
            acc

        Node v left right ->
            let
                leftAcc = fold func (func v acc) left
            in
                fold func leftAcc right


sumUsingFold : BTree number -> number
sumUsingFold bTree =
    let
        func = (+)
        seed = 0
    in
        fold func seed bTree


sumInt : BTree Int -> Int
sumInt bTree =
    sumUsingFold bTree


sumString : BTree String -> String
sumString bTree =
    let
        func = (++)
        seed = ""
    in
        fold func seed bTree


flattenUsingFold : BTree a -> List a
flattenUsingFold bTree =
    let
        func = (::)
        seed = []
    in
        fold func seed bTree


isElementUsingFold : a -> BTree a -> Bool
isElementUsingFold a bTree =
    let
        func v acc =
            if acc.isFound then acc
            else if acc.a == v then {acc | isFound = True}
            else acc
        seed = {a = a, isFound = False}
    in
        (fold func seed bTree).isFound


toTreeDiagramTree : BTree a -> TD.Tree (Maybe a)
toTreeDiagramTree bTree =
    case bTree of
        Empty ->
            TD.node Nothing []

        Node v left right ->
            TD.node (Just v)[toTreeDiagramTree left, toTreeDiagramTree right]


sort: BTree comparable -> BTree comparable
sort bTree =
    sortBy identity bTree


sortBy : (a -> comparable) -> BTree a -> BTree a
sortBy func bTree =
    bTree
        |> flatten
        |> List.sortBy func
        |> fromListBy func


fromList : List comparable -> BTree comparable
fromList xs =
    fromListBy identity xs


fromListBy : (a -> comparable) -> List a -> BTree a
fromListBy func xs =
    List.foldl (insertBy func) Empty xs


insert : comparable -> BTree comparable -> BTree comparable
insert x bTree =
    insertBy identity x bTree


insertBy : (a -> comparable) -> a -> BTree a -> BTree a
insertBy func x bTree =
    case bTree of
      Empty ->
          singleton x

      Node y left right ->
          if func x >= func y then
            Node y left (insertBy func x right)
          else
            Node y (insertBy func x left) right


removeDuplicates : BTree comparable -> BTree comparable
removeDuplicates bTree =
    removeDuplicatesBy identity bTree


removeDuplicatesBy : (a -> comparable) -> BTree a -> BTree a
removeDuplicatesBy func bTree =
    bTree
        |> flatten
        |> List.Extra.uniqueBy func
        |> fromListBy func


isAllNothing : BTree (Maybe a) -> Bool
isAllNothing bTree =
    bTree
        |> flatten
        |> Maybe.Extra.values
        |> List.isEmpty


isEmpty : BTree a -> Bool
isEmpty bTree =
    bTree == Empty

-- todo ?? fromList flatten fromList REVERSIBLE or not?