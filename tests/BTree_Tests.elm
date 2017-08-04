module BTree_Tests exposing (..)

import BTree exposing (BTree(..), singleton, depth, map, flatten, isElement, fold, sumInt, sumMaybeSafeInt, sumBigInt, sumFloat, sumIntUsingFold, sumFloatUsingFold, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortBy, fromList, fromListBy, insert, insertBy, deDuplicate, deDuplicateBy, isAllNothing, isEmpty, toNothingNodes)
import NodeTag exposing (NodeTag(..))
import MusicNote exposing (MusicNote(..), sorter)
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt)

import TreeDiagram as TD exposing (node)
import BigInt exposing (fromInt)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


bTree : Test
bTree =
    describe "BTree module"
        [ describe "BTree.singleton"
            [ test "singleton.1" <|
                \() ->
                    Expect.equal (Node 1 Empty Empty) (BTree.singleton 1)
            ]
        , describe "BTree.depth"
            [ test "of depth.0" <|
                \() ->
                    Empty
                        |> BTree.depth
                        |> Expect.equal 0
            , test "of depth.1" <|
                \() ->
                    'a'
                        |> singleton
                        |> BTree.depth
                        |> Expect.equal 1
            , test "of depth.2" <|
                \() ->
                    ['a', 'b', 'c']
                        |> fromList
                        |> BTree.depth
                        |> Expect.equal 3
            ]
        , describe "BTree.map"
            [ test "of map.0" <|
                \() ->
                    Empty
                        |> BTree.map (\n -> n + 1)
                        |> Expect.equal Empty
            , test "of map.1" <|
                \() ->
                    3
                        |> singleton
                        |> BTree.map (\n -> n - 1)
                        |> Expect.equal (singleton 2)
            , test "of map.2" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> BTree.map (\n -> n ^ 2)
                        |> Expect.equal (fromList [1, 4, 9])
            ]
        , describe "BTree.flatten"
            [ test "of flatten.0" <|
                \() ->
                    let
                        list = []
                        tree = fromList list
                    in
                        Expect.equal (list) (BTree.flatten tree)
            , test "of flatten.1" <|
                \() ->
                    let
                        list = [1]
                        tree = fromList list
                    in
                        Expect.equal (list) (BTree.flatten tree)
            , test "of flatten.2" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (list) (BTree.flatten tree)
            , test "of flatten.3" <|
                \() ->
                    let
                        list = [3, 2, 1]
                        tree = fromList list
                    in
                        Expect.equal (list) (BTree.flatten tree)
            , test "of flatten.4" <|
                \() ->
                    let
                        list = [3, 1, 2]
                        tree = fromList list
                    in
                        Expect.equal (list) (BTree.flatten tree)
            ]
        , describe "BTree.isElement"
            [ test "of isElement.0" <|
                \() ->
                    Expect.equal (False) (BTree.isElement 1 Empty)
            , test "of isElement.1" <|
                \() ->
                    Expect.equal (True) (BTree.isElement 1 (singleton 1))
            , test "of isElement.2" <|
                \() ->
                    Expect.equal (False) (BTree.isElement 2 (singleton 1))
            , test "of isElement.3" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (BTree.isElement 1 tree)
            , test "of isElement.4" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (BTree.isElement 2 tree)
            , test "of isElement.5" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (BTree.isElement 3 tree)
            , test "of isElement.6" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (False) (BTree.isElement 4 tree)
            ]
        , describe "BTree.fold"
            [ test "of fold.0" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        tree = Empty
                    in
                        Expect.equal (seed) (BTree.fold fn seed tree)

            , test "of fold.1" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        v = 5
                        tree = singleton v
                    in
                        Expect.equal (fn seed v) (BTree.fold fn seed tree)
            , test "of fold.2" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        list = [4, 5, 6]
                        tree = fromList list
                    in
                        Expect.equal (List.foldl fn seed list) (BTree.fold fn seed tree) -- same with List.foldr
        , describe "BTree.sumInt"
            [ test "of sumInt.0" <|
                \() ->
                    Empty
                        |> BTree.sumInt
                        |> Expect.equal (Safe 0)
            , test "of sumInt.1" <|
                \() ->
                    1
                        |> singleton
                        |> BTree.sumInt
                        |> Expect.equal (Safe 1)
            , test "of sumInt.2" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> BTree.sumInt
                        |> Expect.equal (Safe 6)
            , test "of sumInt.3" <|
                \() ->
                    maxSafeInt
                        |> singleton
                        |> BTree.sumInt
                        |> Expect.equal (Safe maxSafeInt)
            , test "of sumInt.4" <|
                \() ->
                    maxSafeInt + 1
                        |> singleton
                        |> BTree.sumInt
                        |> Expect.equal (Unsafe)
            , test "of sumInt.5" <|
                \() ->
                    maxSafeInt + 1
                        |> negate
                        |> singleton
                        |> BTree.sumInt
                        |> Expect.equal (Unsafe)
            , test "of sumInt.6" <|
                \() ->
                    [maxSafeInt + 1, 2, 3]
                        |> fromList
                        |> BTree.sumInt
                        |> Expect.equal (Unsafe)
            , test "of sumInt.7" <|
                \() ->
                    [maxSafeInt, 2, -3]
                        |> fromList
                        |> BTree.sumInt
                        |> Expect.equal (Unsafe)
            ]
        , describe "BTree.sumMaybeSafeInt"
            [ test "of sumMaybeSafeInt.0" <|
                \() ->
                    Empty
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe 0)
            , test "of sumMaybeSafeInt.1" <|
                \() ->
                    (singleton <| Safe 0)
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe 0)
            , test "of sumMaybeSafeInt.2" <|
                \() ->
                    Node (Safe 1) (singleton <| Safe -1) Empty
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe 0)
            , test "of sumMaybeSafeInt.3" <|
                \() ->
                    Node (Safe 1) (singleton <| Safe -1) (singleton <| Safe 0)
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe 0)
            , test "of sumMaybeSafeInt.4" <|
                \() ->
                    Node (Safe 1) (singleton <| Safe 2) (singleton <| Safe -3)
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe 0)
            , test "of sumMaybeSafeInt.5" <|
                \() ->
                    Node (Safe -1) (singleton <| Safe -2) (singleton <| Safe -3)
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe -6)
            , test "of sumMaybeSafeInt.6" <|
                \() ->
                    (singleton <| Safe maxSafeInt)
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe maxSafeInt)
            , test "of sumMaybeSafeInt.7" <|
                \() ->
                    Node (Safe maxSafeInt) (singleton <| Safe -1) Empty
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Safe <| maxSafeInt - 1)
            , test "of sumMaybeSafeInt.8" <|
                \() ->
                    Node (Safe maxSafeInt) (singleton <| Safe 1) Empty
                        |> BTree.sumMaybeSafeInt
                        |> Expect.equal (Unsafe)
            ]
        , describe "BTree.sumBigInt"
            [ test "of sumBigInt.0" <|
                \() ->
                    Empty
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.fromInt 0)
            , test "of sumBigInt.1" <|
                \() ->
                    BigInt.fromInt 1
                        |> singleton
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.fromInt 1)
            , test "of sumBigInt.2" <|
                \() ->
                    [BigInt.fromInt 1, BigInt.fromInt 2, BigInt.fromInt 3]
                        |> fromListBy BigInt.toString
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.fromInt 6)
            , test "of sumBigInt.3" <|
                \() ->
                    BigInt.fromInt maxSafeInt
                        |> singleton
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.add (BigInt.fromInt 0) (BigInt.fromInt maxSafeInt))
            , test "of sumBigInt.4" <|
                \() ->
                    BigInt.fromInt (maxSafeInt + 1)
                        |> singleton
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.add (BigInt.fromInt 0) (BigInt.fromInt <| maxSafeInt + 1))
            , test "of sumBigInt.5" <|
                \() ->
                    (BigInt.fromInt <| negate <| maxSafeInt + 1)
                        |> singleton
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.add (BigInt.fromInt 0) (BigInt.fromInt <| negate <| maxSafeInt + 1))
            , test "of sumBigInt.6" <|
                \() ->
                    [BigInt.fromInt <| maxSafeInt + 1, BigInt.fromInt 2, BigInt.fromInt 3]
                        |> fromListBy BigInt.toString
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt 0) (BigInt.fromInt <| maxSafeInt + 1)) (BigInt.fromInt 2)) (BigInt.fromInt 3))
            , test "of sumBigInt.7" <|
                \() ->
                    [BigInt.fromInt maxSafeInt, BigInt.fromInt 2, BigInt.fromInt -3]
                        |> fromListBy BigInt.toString
                        |> BTree.sumBigInt
                        |> Expect.equal (BigInt.add (BigInt.add (BigInt.add (BigInt.fromInt 0) (BigInt.fromInt <| maxSafeInt)) (BigInt.fromInt 2)) (BigInt.fromInt -3))
            ]
        , describe "BTree.sumFloat"
            [ test "of sumFloat.0" <|
                \() ->
                    Empty
                        |> BTree.sumFloat
                        |> Expect.equal 0.0
            , test "of sumFloat.1" <|
                \() ->
                    [1.0, 2.0, 3.0]
                        |> fromList
                        |> BTree.sumFloat
                        |> Expect.equal (1.0 + 2.0 + 3.0)
            ]
        , describe "BTree.sumIntUsingFold"
            [ test "of sumIntUsingFold.0" <|
                \() ->
                    Empty
                        |> BTree.sumIntUsingFold
                        |> Expect.equal (Safe 0)
            , test "of sumIntUsingFold.1" <|
                \() ->
                    1
                        |> singleton
                        |> BTree.sumIntUsingFold
                        |> Expect.equal (Safe 1)
            , test "of sumIntUsingFold.2" <|
                \() ->
                    [maxSafeInt, 2, -3]
                        |> fromList
                        |> BTree.sumIntUsingFold
                        |> Expect.equal Unsafe
            , test "of sumIntUsingFold.3" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (sumInt tree) (BTree.sumIntUsingFold tree)
            , test "of sumIntUsingFold.4" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1000^1000]
                    in
                        Expect.equal (sumInt tree) (BTree.sumIntUsingFold tree)
            ]
        , describe "BTree.sumFloatUsingFold"
            [ test "of sumFloatUsingFold.0" <|
                \() ->
                    Empty
                        |> BTree.sumFloatUsingFold
                        |> Expect.equal 0.0
            , test "of sumFloatUsingFold.1" <|
                \() ->
                    1.0
                        |> singleton
                        |> BTree.sumFloatUsingFold
                        |> Expect.equal 1.0
            , test "of sumFloatUsingFold.2" <|
                \() ->
                    [toFloat maxSafeInt + 1.0, 2.0, -5.0]
                        |> fromList
                        |> BTree.sumFloatUsingFold
                        |> Expect.equal (toFloat maxSafeInt + 1.0 + 2.0 - 5.0)
            ]
        , describe "BTree.sumString"
            [ test "of sumString.0" <|
                \() ->
                    Empty
                        |> BTree.sumString
                        |> Expect.equal ""
            , test "of sumString.1" <|
                \() ->
                    "abc"
                        |> singleton
                        |> BTree.sumString
                        |> Expect.equal "abc"
            , test "of sumString.2" <|
                \() ->
                    ["abc", "def", "ghi"]
                        |> fromList
                        |> BTree.sumString
                        |> Expect.equal "ghidefabc"
            ]
        , describe "BTree.flattenUsingFold"
            [ test "of flattenUsingFold.1" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (List.sort (flatten tree)) (List.sort (BTree.flattenUsingFold tree))
            ]
        , describe "BTree.isElementUsingFold"
            [ test "of isElementUsingFold.1" <|
                \() ->
                    let
                        a = 5
                        tree = Empty
                    in
                        Expect.equal (isElement a tree) (BTree.isElementUsingFold a tree)
            ]
            , test "of isElementUsingFold.2" <|
                \() ->
                    let
                        a = 5
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (isElement a tree) (BTree.isElementUsingFold a tree)
            , test "of isElementUsingFold.3" <|
                \() ->
                    let
                        a = 50
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (isElement a tree) (BTree.isElementUsingFold a tree)
            ]
         , describe "BTree.toTreeDiagramTree" -- not much of a test because constructors are not exposed
            [ test "of toTreeDiagramTree.0" <|
                \() ->
                    Expect.equal Nothing (BTree.toTreeDiagramTree Empty)
            , test "of toTreeDiagramTree.1" <|
                \() ->
                    Expect.equal (Just (TD.node (Just 1) [])) (BTree.toTreeDiagramTree (singleton 1))
            , test "of toTreeDiagramTree.2" <|
                \() ->
                    Expect.equal (Just (TD.node (Just 1) [TD.node (Just 2) []])) (BTree.toTreeDiagramTree (fromList [1,2]))
            ]
         , describe "BTree.sort"
            [ test "of sort.0" <|
                \() ->
                    Expect.equal (Empty) (BTree.sort Empty)
            , test "of sort.1" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.sort (singleton 1))
            , test "of sort.2" <|
                \() ->
                    Expect.equal (fromList [1,2,3,4,5]) (BTree.sort (fromList [4,1,3,5,2]))
            ]
         , describe "BTree.sortBy"
            [ test "of sortBy.0" <|
                \() ->
                    Expect.equal (Empty) (BTree.sortBy (MusicNote.sorter) Empty)
            , test "of sortBy.1" <|
                \() ->
                    Expect.equal (singleton A) (BTree.sortBy (MusicNote.sorter) (singleton A))
            , test "of sortBy.2" <|
                \() ->
                    Expect.equal (fromListBy (MusicNote.sorter) [A, B, D, E, G]) (BTree.sortBy (MusicNote.sorter) (fromListBy (MusicNote.sorter) [D, A, E, G, B]))
            ]
        , describe "BTree.fromList"
            [ test "of fromList.0" <|
                \() ->
                    []
                        |> BTree.fromList
                        |> Expect.equal Empty
            , test "of fromList.1" <|
                \() ->
                    ['a']
                        |> BTree.fromList
                        |> Expect.equal (singleton 'a')
            , test "of fromList.2" <|
                \() ->
                    ['a', 'b', 'c']
                        |> BTree.fromList
                        |> Expect.equal (Node 'a' Empty (Node 'b' Empty (singleton 'c')))
            , test "of fromList.3" <|
                \() ->
                    ['c', 'b', 'a']
                        |> BTree.fromList
                        |> Expect.equal (Node 'c' (Node 'b' (singleton 'a') Empty) Empty)
            , test "of fromList.4" <|
                \() ->
                    ['c', 'a', 'b']
                        |> BTree.fromList
                        |> Expect.equal (Node 'c' (Node 'a' Empty (singleton 'b')) Empty)
            , test "of fromList.5" <|
                \() ->
                    ['a', 'b', 'b']
                        |> BTree.fromList
                        |> Expect.equal (Node 'a' Empty (Node 'b' Empty (singleton 'b')))
            ]
        , describe "BTree.fromIntList"
            [ test "of fromIntList.0" <|
                \() ->
                    []
                        |> BTree.fromIntList
                        |> Expect.equal Empty
            , test "of fromIntList.1" <|
                \() ->
                    [1]
                        |> BTree.fromIntList
                        |> Expect.equal (singleton <| Safe 1)
            , test "of fromIntList.2" <|
                \() ->
                    [1, 2]
                        |> BTree.fromIntList
                        |> Expect.equal (Node (Safe 1) Empty (singleton <| Safe 2))
            , test "of fromIntList.3" <|
                \() ->
                    [maxSafeInt, maxSafeInt + 1]
                        |> BTree.fromIntList
                        |> Expect.equal (Node (Safe maxSafeInt) Empty (singleton <| Unsafe))
            ]
        , describe "BTree.fromListBy"
            [ test "of fromListBy.0" <|
                \() ->
                    []
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal Empty
            , test "of fromListBy.1" <|
                \() ->
                    [A]
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal (singleton A)
            , test "of fromListBy.2" <|
                \() ->
                    [A, B, C]
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton C)))
            , test "of fromListBy.3" <|
                \() ->
                    [C, B, A]
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node C (Node B (singleton A) Empty) Empty)
            , test "of fromListBy.4" <|
                \() ->
                    [C, A, B]
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node C (Node A Empty (singleton B)) Empty)
            , test "of fromListBy.5" <|
                \() ->
                    [A, B, B]
                        |> BTree.fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton B)))
            ]
        , describe "BTree.insert"
            [ test "of insert.0" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (BTree.insert newValue target)
            , test "of insert.1" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'c'
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insert newValue target)
            , test "of insert.2" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'a'
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insert newValue target)
            , test "of insert.3" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'b'
                        target = singleton currentValue
                    in
                        Expect.equal (Node 'b' Empty (singleton 'b')) (BTree.insert newValue target)
            ]
        , describe "BTree.insertBy"
            [ test "of insertBy.0" <|
                \() ->
                    let
                        target = Empty
                        newValue = A
                    in
                        Expect.equal (singleton newValue) (BTree.insertBy (MusicNote.sorter) newValue target)
            , test "of insertBy.1" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = C
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertBy (MusicNote.sorter) newValue target)
            , test "of insertBy.2" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = A
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertBy (MusicNote.sorter) newValue target)
            , test "of insertBy.3" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = B
                        target = singleton currentValue
                    in
                        Expect.equal (Node B Empty (singleton B)) (BTree.insertBy (MusicNote.sorter) newValue target)
            ]
         , describe "BTree.deDuplicate"
            [ test "of deDuplicate.0" <|
                \() ->
                    Expect.equal (Empty) (BTree.deDuplicate Empty)
            , test "of deDuplicate.1" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.deDuplicate (singleton 1))
            , test "of deDuplicate.2" <|
                \() ->
                    Expect.equal (fromList [4, 1, 3, 5]) (BTree.deDuplicate (fromList [4, 1, 3, 5, 1]))
            ]
         , describe "BTree.deDuplicateBy"
            [ test "of deDuplicateBy.0" <|
                \() ->
                    Expect.equal (Empty) (BTree.deDuplicateBy (MusicNote.sorter) Empty)
            , test "of deDuplicateBy.1" <|
                \() ->
                    Expect.equal (singleton A) (BTree.deDuplicateBy (MusicNote.sorter) (singleton A))
            , test "of deDuplicateBy.2" <|
                \() ->
                    Expect.equal (fromListBy (MusicNote.sorter) [D, A, E, B]) (BTree.deDuplicateBy (MusicNote.sorter) (fromListBy (MusicNote.sorter) [D, A, E, A, B]))
            ]
         , describe "BTree.isAllNothing"
            [ test "of isAllNothing.0" <|
                \() ->
                    Expect.equal True (BTree.isAllNothing Empty)
            , test "of isAllNothing.1" <|
                \() ->
                    Expect.equal True (BTree.isAllNothing (singleton (Nothing)))
            , test "of isAllNothing.2" <|
                \() ->
                    Expect.equal False (BTree.isAllNothing (Node Nothing Empty (singleton (Just 1))))
            ]
         , describe "BTree.isEmpty"
            [ test "of isEmpty.0" <|
                \() ->
                    Expect.equal True (BTree.isEmpty Empty)
            , test "of isEmpty.1" <|
                \() ->
                    Expect.equal False (BTree.isEmpty (singleton (Nothing)))
            , test "of isEmpty.2" <|
                \() ->
                    Expect.equal False (BTree.isEmpty (Node Nothing Empty (singleton (Just 1))))
            ]
         , describe "BTree.toNothingNodes"
            [ test "of toNothingNodes.0" <|
                \() ->
                    Expect.equal Empty (BTree.toNothingNodes Empty)
            , test "of toNothingNodes.1" <|
                \() ->
                    Expect.equal (singleton NothingNode) (BTree.toNothingNodes (singleton 3))
            , test "of toNothingNodes.2" <|
                \() ->
                    Expect.equal (Node NothingNode (singleton NothingNode) (singleton NothingNode)) (BTree.toNothingNodes (Node 1 (singleton 2) (singleton 3)))
            ]
        ]

