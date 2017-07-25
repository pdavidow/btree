-- http://elm-lang.org/examples/binary-Tree

module BTree exposing (BTree(..), NodeTag(..), singleton, depth, map, sumInt, flatten, isElement, fold, sumUsingFold, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortBy, fromList, fromListBy, insert, insertBy, removeDuplicates, removeDuplicatesBy, isAllNothing, isEmpty, toNothingNodes, sumMaybeSafeInt, fromMaybeSafeInts)

import TreeDiagram as TD exposing (node, Tree)
import List.Extra exposing (uniqueBy)
import Maybe.Extra exposing (unwrap, values)

import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe(..), sumInt, toMaybeSafeInt, isSafe)

-- todo ?? fromList flatten fromList REVERSIBLE or not?


type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


type NodeTag -- todo refactor put into separte module
    = IntNode (MaybeSafe Int)
    | StringNode String
    | BoolNode (Maybe Bool)
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
map fn bTree =
    case bTree of
        Empty ->
            Empty

        Node v left right ->
            Node (fn v) (map fn left) (map fn right)


sumInt : BTree Int -> MaybeSafe Int
sumInt bTree =
    let
        sumOfNonEmpty : BTree Int -> MaybeSafe Int
        sumOfNonEmpty bTree =
            case bTree of
                -- todo https://elmlang.slack.com/archives/C0CJ3SBBM/p1500928211761545
                Empty -> -- should never get here
                    Safe 0

                Node num left right ->
                    let
                        mbsNum = toMaybeSafeInt num
                    in
                        case mbsNum of
                            Unsafe ->
                                Unsafe

                            Safe num ->
                                let
                                    leftResult = if isEmpty left
                                        then Safe 0
                                        else sumOfNonEmpty left

                                    rightResult = if isEmpty right
                                        then Safe 0
                                        else sumOfNonEmpty right
                                in
                                    MaybeSafe.sumInt [mbsNum, leftResult, rightResult]
    in
        case bTree of
            Empty -> Safe 0 -- modeled on: List.sum [] == 0
            _-> sumOfNonEmpty bTree


sumMaybeSafeInt : BTree (MaybeSafe Int) -> MaybeSafe Int
sumMaybeSafeInt bTree =
    if isEmpty bTree
        then
            Safe 0 -- modeled on: List.sum [] == 0
        else
            if isAllSafe bTree
                then
                    let
                        fn = \mbsInt -> case mbsInt of
                            Unsafe -> 0 -- should never get here
                            Safe int -> int
                    in
                        bTree
                            |> map fn
                            |> sumInt
                else
                    Unsafe


isAllSafe : BTree (MaybeSafe a) -> Bool
isAllSafe bTree =
    bTree
        |> flatten
        |> List.all MaybeSafe.isSafe


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
fold fn accumulator bTree =
    case bTree of
        Empty ->
            accumulator

        Node v left right ->
            let
                leftAccumulator = fold fn (fn v accumulator) left
            in
                fold fn leftAccumulator right


sumUsingFold : BTree number -> number
sumUsingFold bTree =
    let
        fn = (+)
        seed = 0
    in
        fold fn seed bTree


sumString : BTree String -> String
sumString bTree =
    let
        fn = (++)
        seed = ""
    in
        fold fn seed bTree


flattenUsingFold : BTree a -> List a
flattenUsingFold bTree =
    let
        fn = (::)
        seed = []
    in
        fold fn seed bTree


isElementUsingFold : a -> BTree a -> Bool
isElementUsingFold a bTree =
    let
        fn v acc =
            if acc.isFound then acc
            else if acc.a == v then {acc | isFound = True}
            else acc
        seed = {a = a, isFound = False}
    in
        (fold fn seed bTree).isFound


toTreeDiagramTree : BTree a -> Maybe (TD.Tree (Maybe a))
toTreeDiagramTree bTree =
    let
        toTreeDiagramTreeOfNonEmpty : BTree a -> TD.Tree (Maybe a)
        toTreeDiagramTreeOfNonEmpty bTree =
            case bTree of
                Empty -> -- should never get here
                    TD.node Nothing []

                Node v left right ->
                    let -- todo https://elmlang.slack.com/archives/C0CJ3SBBM/p1500928211761545
                        leftResult = if isEmpty left
                            then []
                            else [ toTreeDiagramTreeOfNonEmpty left ]

                        rightResult = if isEmpty right
                            then []
                            else [ toTreeDiagramTreeOfNonEmpty right ]

                        treeList = leftResult ++ rightResult
                    in
                        TD.node (Just v) treeList
    in
        case bTree of
            Empty ->
                Nothing

            _ ->
                Just <| toTreeDiagramTreeOfNonEmpty bTree


sort: BTree comparable -> BTree comparable
sort bTree =
    sortBy identity bTree


sortBy : (a -> comparable) -> BTree a -> BTree a
sortBy fn bTree =
    bTree
        |> flatten
        |> List.sortBy fn
        |> fromListBy fn


fromList : List comparable -> BTree comparable
fromList xs =
    fromListBy identity xs


fromListBy : (a -> comparable) -> List a -> BTree a
fromListBy fn xs =
    List.foldl (insertBy fn) Empty xs


fromMaybeSafeInts : List Int -> BTree (MaybeSafe Int)
fromMaybeSafeInts ints =
    ints
        |> List.map toMaybeSafeInt
        |> fromListBy toString


insert : comparable -> BTree comparable -> BTree comparable
insert x bTree =
    insertBy identity x bTree


insertBy : (a -> comparable) -> a -> BTree a -> BTree a
insertBy fn x bTree =
    case bTree of
      Empty ->
          singleton x

      Node y left right ->
          if fn x >= fn y then
            Node y left (insertBy fn x right)
          else
            Node y (insertBy fn x left) right


removeDuplicates : BTree comparable -> BTree comparable
removeDuplicates bTree =
    removeDuplicatesBy identity bTree


removeDuplicatesBy : (a -> comparable) -> BTree a -> BTree a
removeDuplicatesBy fn bTree =
    bTree
        |> flatten
        |> List.Extra.uniqueBy fn
        |> fromListBy fn


isAllNothing : BTree (Maybe a) -> Bool
isAllNothing bTree =
    bTree
        |> flatten
        |> Maybe.Extra.values
        |> List.isEmpty


isEmpty : BTree a -> Bool
isEmpty bTree =
    bTree == Empty


toNothingNodes : BTree a -> BTree NodeTag
toNothingNodes bTree =
    map (\a -> NothingNode) bTree