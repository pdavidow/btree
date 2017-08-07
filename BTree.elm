module BTree exposing (BTree(..), singleton, depth, map, flatten, isElement, fold, sumInt, sumMaybeSafeInt, sumBigInt, sumFloat, sumIntUsingFold, sumFloatUsingFold, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortBy, fromList, fromIntList, fromListBy, insert, insertBy, deDuplicate, deDuplicateBy, isAllNothing, isEmpty, toNothingNodes,   sortWith, fromListAsIsBy, fromListAsIs_directed, fromListWith, insertWith, insertAsIsBy, insertAsIs_directed)

-- http://elm-lang.org/examples/binary-Tree

import TreeDiagram as TD exposing (node, Tree)
import List.Extra exposing (uniqueBy)
import Maybe.Extra exposing (unwrap, values)
import BigInt exposing (BigInt, add)

import MaybeSafe exposing (MaybeSafe(..), compare, sumMaybeSafeInt, toMaybeSafeInt, isSafe)
import NodeTag exposing (NodeTag(..))

-- todo ?? fromList flatten fromList REVERSIBLE or not?


type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


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


sort: BTree comparable -> BTree comparable
sort bTree =
    sortBy identity bTree


ordererBy: (a -> comparable) -> (a -> a -> Order)
ordererBy fn =
    \a1 a2 -> Basics.compare (fn a1) (fn a2)


sortBy : (a -> comparable) -> BTree a -> BTree a
sortBy fn bTree =
    sortWith (ordererBy fn) bTree


sortWith : (a -> a -> Order) -> BTree a -> BTree a
sortWith fn bTree =
    bTree
        |> flatten
        |> List.sortWith fn
        |> fromListAsIs_left


fromList : List comparable -> BTree comparable
fromList xs =
    fromListBy identity xs


fromListBy : (a -> comparable) -> List a -> BTree a
fromListBy fn xs =
    fromListWith (ordererBy fn) xs


fromListWith : (a -> a -> Order) -> List a -> BTree a
fromListWith fn xs =
    List.foldl (insertWith fn) Empty xs


fromListAsIsBy : Bool -> List a -> BTree a
fromListAsIsBy isInsertRight xs =
    List.foldl (insertAsIsBy isInsertRight) Empty xs


fromListAsIs_left : List a -> BTree a -- todo del
fromListAsIs_left xs =
    List.foldl insertAsIs_left Empty xs


fromListAsIs_right : List a -> BTree a -- todo del
fromListAsIs_right xs =
    List.foldl insertAsIs_right Empty xs


fromListAsIs_directed : List (a, Bool) -> BTree a
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
    case bTree of
      Empty ->
          singleton x

      Node y left right ->
        let
            insertLeft = Node y (insertWith fn x left) right
            insertRight = Node y left (insertWith fn x right)
        in
            case fn x y of
                LT -> insertLeft
                EQ -> insertRight
                GT -> insertRight


insertAsIsBy : Bool -> a -> BTree a -> BTree a
insertAsIsBy isInsertRight x bTree =
     insertAsIs_directed (x, isInsertRight) bTree


insertAsIs_left : a -> BTree a -> BTree a --todo del
insertAsIs_left x bTree =
    insertAsIs_directed (x, False) bTree


insertAsIs_right : a -> BTree a -> BTree a -- todo del
insertAsIs_right x bTree =
    insertAsIs_directed (x, True) bTree


insertAsIs_directed : (a, Bool) -> BTree a -> BTree a
insertAsIs_directed (x, isInsertRight) bTree =
    case bTree of
        Empty ->
          singleton x

        Node val left right ->
            let
                insertBy isInsertRight = if isInsertRight
                    then Node val left (insertAsIs_directed (x, isInsertRight) right)
                    else Node val (insertAsIs_directed (x, isInsertRight) left) right
            in
                case (left, right) of
                    (Empty, Empty) -> insertBy isInsertRight
                    (Empty, _) -> Node val (singleton x) right
                    (_, Empty) -> Node val left (singleton x)
                    (_, _) -> insertBy isInsertRight


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