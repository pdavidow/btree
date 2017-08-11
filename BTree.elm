module BTree exposing (BTree(..), TraversalOrder(..), Direction(..), singleton, depth, map, flatten, isElement, fold, sumInt, sumMaybeSafeInt, sumBigInt, sumFloat, sumIntUsingFold, sumFloatUsingFold, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortTo, sortByTo, sortWithTo, fromList, fromIntList, fromListBy, insert, insertBy, deDuplicate, deDuplicateBy, isAllNothing, isEmpty, toNothingNodes,    fromListAsIsBy, fromListAsIs_left, fromListAsIs_right, fromListAsIs_directed, fromListWith, insertWith, insertWith_directed, insertAsIsBy, insertAsIs_directed, flattenBy, flattenUsingFoldBy)

-- http://elm-lang.org/examples/binary-Tree

import TreeDiagram as TD exposing (node, Tree)
import List.Extra exposing (uniqueBy)
import Maybe.Extra exposing (unwrap, values)
import BigInt exposing (BigInt, add)

import MaybeSafe exposing (MaybeSafe(..), compare, sumMaybeSafeInt, toMaybeSafeInt, isSafe)
import NodeTag exposing (NodeTag(..))

-- todo ?? fromList flatten fromList REVERSIBLE


type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


type TraversalOrder
    = InOrder
    | PreOrder
    | PostOrder


type Direction
    = Right
    | Left


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
    bTree
        |> map toMaybeSafeInt
        |> sumMaybeSafeInt


sumMaybeSafeInt : BTree (MaybeSafe Int) -> MaybeSafe Int
sumMaybeSafeInt bTree =
    bTree
        |> flatten
        |> MaybeSafe.sumMaybeSafeInt


sumBigInt : BTree BigInt -> BigInt
sumBigInt bTree =
    bTree
        |> flatten
        |> List.foldl BigInt.add (BigInt.fromInt 0)


sumFloat : BTree Float -> Float
sumFloat bTree =
    case bTree of
        Empty ->
            0.0

        Node number left right ->
            number + (sumFloat left) + (sumFloat right)


isAllSafe : BTree (MaybeSafe a) -> Bool
isAllSafe bTree =
    bTree
        |> flatten
        |> List.all MaybeSafe.isSafe


isElement : a -> BTree a -> Bool
isElement a bTree =
    case bTree of
        Empty ->
            False

        Node v left right ->
            if v == a then True
            else (isElement a left) || (isElement a right)


flatten : BTree a -> List a
flatten bTree =
    flattenBy PreOrder bTree


flattenBy : TraversalOrder -> BTree a -> List a
flattenBy order bTree =
    case bTree of
        Empty ->
            []

        Node val left right ->
            case order of
                InOrder ->
                    let
                        resultLeft = flattenBy order left
                        resultRight = flattenBy order right
                    in
                        resultLeft ++ [val] ++ resultRight

                PreOrder ->
                    let
                        resultLeft = flattenBy order left
                        resultRight = flattenBy order right
                    in
                        [val] ++ resultLeft ++ resultRight

                PostOrder ->
                    let
                        resultLeft = flattenBy order left
                        resultRight = flattenBy order right
                    in
                        resultLeft ++ resultRight ++ [val]


fold : (a -> b -> b) -> b -> BTree a -> b
fold fn accumulator bTree =
    foldBy PreOrder fn accumulator bTree


foldBy : TraversalOrder -> (a -> b -> b) -> b -> BTree a -> b
foldBy order fn accumulator bTree =
    case bTree of
        Empty ->
            accumulator

        Node val left right ->
            case order of
                InOrder ->
                    let
                        resultLeft = foldBy order fn accumulator left
                        resultEval = fn val resultLeft
                        resultRight = foldBy order fn resultEval right
                    in
                        resultRight

                PreOrder ->
                    let
                        resultEval = fn val accumulator
                        resultLeft = foldBy order fn resultEval left
                        resultRight = foldBy order fn resultLeft right
                    in
                        resultRight

                PostOrder ->
                    let
                        resultLeft = foldBy order fn accumulator left
                        resultRight = foldBy order fn resultLeft right
                        resultEval = fn val resultRight
                    in
                        resultEval


sumIntUsingFold : BTree Int -> MaybeSafe Int
sumIntUsingFold bTree =
    let
        fn = \int mbsInt -> MaybeSafe.sumMaybeSafeInt <| [toMaybeSafeInt int, mbsInt]
        seed = Safe 0
    in
        fold fn seed bTree


sumFloatUsingFold : BTree Float -> Float
sumFloatUsingFold bTree =
    let
        fn = (+)
        seed = 0.0
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
    flattenUsingFoldBy PreOrder bTree


flattenUsingFoldBy : TraversalOrder -> BTree a -> List a
flattenUsingFoldBy order bTree =
    let
        fn = \a list -> list ++ [a]
        seed = []
    in
        foldBy order fn seed bTree


isElementUsingFold : a -> BTree a -> Bool
isElementUsingFold a bTree =
    let
        fn v accumulator =
            if accumulator.isFound then accumulator
            else if accumulator.a == v then {accumulator | isFound = True}
            else accumulator
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
                    let
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


ordererBy: (a -> comparable) -> (a -> a -> Order)
ordererBy fn =
    \a1 a2 -> Basics.compare (fn a1) (fn a2)


sort: BTree comparable -> BTree comparable
sort bTree =
    sortTo Left bTree


sortTo: Direction -> BTree comparable -> BTree comparable
sortTo direction bTree =
    sortByTo identity direction bTree


sortByTo : (a -> comparable) -> Direction -> BTree a -> BTree a
sortByTo fn direction bTree =
    sortWithTo (ordererBy fn) direction bTree


sortWithTo : (a -> a -> Order) -> Direction -> BTree a -> BTree a
sortWithTo fn direction bTree =
    bTree
        |> flatten
        |> List.sortWith fn
        |> fromListAsIsBy direction


fromList : List comparable -> BTree comparable
fromList xs =
    fromListBy identity xs


fromListBy : (a -> comparable) -> List a -> BTree a
fromListBy fn xs =
    fromListWith (ordererBy fn) xs


fromListWith : (a -> a -> Order) -> List a -> BTree a
fromListWith fn xs =
    List.foldl (insertWith fn) Empty xs


fromListAsIsBy : Direction -> List a -> BTree a
fromListAsIsBy direction xs =
    List.foldl (insertAsIsBy direction) Empty xs


fromListAsIs_left : List a -> BTree a
fromListAsIs_left xs =
    List.foldl insertAsIs_left Empty xs


fromListAsIs_right : List a -> BTree a
fromListAsIs_right xs =
    List.foldl insertAsIs_right Empty xs


fromListAsIs_directed : List (a, Direction) -> BTree a
fromListAsIs_directed xs =
    List.foldl insertAsIs_directed Empty xs


fromIntList : List Int -> BTree (MaybeSafe Int)
fromIntList ints =
    ints
        |> List.map toMaybeSafeInt
        |> fromListWith MaybeSafe.compare


insert : comparable -> BTree comparable -> BTree comparable
insert x bTree =
    insertBy identity x bTree


insertBy : (a -> comparable) -> a -> BTree a -> BTree a
insertBy fn x bTree =
    insertWith (ordererBy fn) x bTree


insertWith : (a -> a -> Order) -> a -> BTree a -> BTree a
insertWith fn x bTree =
    insertWith_directed Left fn x bTree


insertWith_directed : Direction -> (a -> a -> Order) -> a -> BTree a -> BTree a
insertWith_directed direction fn x bTree =
    case bTree of
      Empty ->
          singleton x

      Node y left right ->
        let
            order = fn x y

            insertLeft = \unit -> Node y (insertWith fn x left) right
            insertRight = \unit -> Node y left (insertWith fn x right)
        in
            case (order, direction) of
                (LT, Right) -> insertRight ()
                (EQ, Right) -> insertLeft ()
                (GT, Right) -> insertLeft ()
                -------------------------
                (LT, Left) -> insertLeft ()
                (EQ, Left) -> insertRight ()
                (GT, Left) -> insertRight ()


insertAsIsBy : Direction -> a -> BTree a -> BTree a
insertAsIsBy direction x bTree =
     insertAsIs_directed (x, direction) bTree


insertAsIs_left : a -> BTree a -> BTree a --todo del
insertAsIs_left x bTree =
    insertAsIs_directed (x, Left) bTree


insertAsIs_right : a -> BTree a -> BTree a -- todo del
insertAsIs_right x bTree =
    insertAsIs_directed (x, Right) bTree


insertAsIs_directed : (a, Direction) -> BTree a -> BTree a
insertAsIs_directed (x, direction) bTree =
    case bTree of
        Empty ->
          singleton x

        Node val leftTree rightTree ->
            let
                continue = \unit -> case direction of
                    Right -> Node val leftTree (insertAsIs_directed (x, direction) rightTree)
                    Left -> Node val (insertAsIs_directed (x, direction) leftTree) rightTree
            in
                case (leftTree, rightTree) of
                    (Empty, Empty) -> continue ()
                    (Empty, _) -> Node val (singleton x) rightTree
                    (_, Empty) -> Node val leftTree (singleton x)
                    (_, _) -> continue ()


deDuplicate : BTree comparable -> BTree comparable
deDuplicate bTree =
    deDuplicateBy identity bTree


deDuplicateBy : (a -> comparable) -> BTree a -> BTree a
deDuplicateBy fn bTree =
    let
        potentialSet = flatten bTree
        set = List.Extra.uniqueBy fn potentialSet
    in
        if potentialSet == set
            then bTree
            else fromListAsIs_left set


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