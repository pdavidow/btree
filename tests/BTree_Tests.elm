module BTree_Tests exposing (..)

import BTree exposing (BTree, BTree(..), NodeTag, NodeTag(..), singleton, depth, map, sum, flatten, isElement, fold, sumUsingFold, sumInt, sumString, flattenUsingFold, isElementUsingFold, toTreeDiagramTree, sort, sortBy, fromList, fromListBy, insert, insertBy, removeDuplicates, removeDuplicatesBy, isAllNothing, isEmpty)

import BTree exposing (NodeTag(..))
import TreeDiagram as TD exposing (node)
import MusicNote exposing (MusicNote(..), sorter)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


bTree : Test
bTree =
    describe "BTree module"
        [ describe "BTree.singleton"
            [ test "singleton" <|
                \() ->
                    Expect.equal (Node 1 Empty Empty) (singleton 1)
            ]
        , describe "BTree.depth"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> depth
                        |> Expect.equal 0
            , test "of singleton" <|
                \() ->
                    'a'
                        |> singleton
                        |> depth
                        |> Expect.equal 1
            , test "of 3 levels" <|
                \() ->
                    ['a', 'b', 'c']
                        |> fromList
                        |> depth
                        |> Expect.equal 3
            ]
        , describe "BTree.map"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> map (\n -> n + 1)
                        |> Expect.equal Empty
            , test "of singleton" <|
                \() ->
                    3
                        |> singleton
                        |> map (\n -> n - 1)
                        |> Expect.equal (singleton 2)
            , test "of 3 levels" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> map (\n -> n ^ 2)
                        |> Expect.equal (fromList [1, 4, 9])
            ]
        , describe "BTree.sum"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> sum
                        |> Expect.equal 0
            , test "of singleton" <|
                \() ->
                    1
                        |> singleton
                        |> sum
                        |> Expect.equal 1
            , test "of 3 levels" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> sum
                        |> Expect.equal 6
            ]
        , describe "BTree.flatten"
            [ test "of empty" <|
                \() ->
                    let
                        list = []
                        tree = fromList list
                    in
                        Expect.equal (list) (flatten tree)
            , test "of single node" <|
                \() ->
                    let
                        list = [1]
                        tree = fromList list
                    in
                        Expect.equal (list) (flatten tree)
            , test "of 3 levels, ascending order" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (list) (flatten tree)
            , test "of 3 levels, descending order" <|
                \() ->
                    let
                        list = [3, 2, 1]
                        tree = fromList list
                    in
                        Expect.equal (list) (flatten tree)
            , test "of 3 levels, no order" <|
                \() ->
                    let
                        list = [3, 1, 2]
                        tree = fromList list
                    in
                        Expect.equal (list) (flatten tree)
            ]
        , describe "BTree.isElement"
            [ test "of empty" <|
                \() ->
                    Expect.equal (False) (isElement 1 Empty)
            , test "of singleton, found" <|
                \() ->
                    Expect.equal (True) (isElement 1 (singleton 1))
            , test "of singleton, not found" <|
                \() ->
                    Expect.equal (False) (isElement 2 (singleton 1))
            , test "of 3 levels, found at level 1" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (isElement 1 tree)
            , test "of 3 levels, found at level 2" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (isElement 2 tree)
            , test "of 3 levels, found at level 3" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (True) (isElement 3 tree)
            , test "of 3 levels, not found" <|
                \() ->
                    let
                        list = [1, 2, 3]
                        tree = fromList list
                    in
                        Expect.equal (False) (isElement 4 tree)
            ]
        , describe "BTree.fold"
            [ test "of empty" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        tree = Empty
                    in
                        Expect.equal (seed) (fold fn seed tree)

            , test "of singleton" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        v = 5
                        tree = singleton v
                    in
                        Expect.equal (fn seed v) (fold fn seed tree)
            , test "of 3 value nodes" <|
                \() ->
                    let
                        fn = (*)
                        seed = 3
                        list = [4, 5, 6]
                        tree = fromList list
                    in
                        Expect.equal (List.foldl fn seed list) (fold fn seed tree) -- same with List.foldr
            , test "of 'Sum all of the elements of a tree'" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (sum tree) (sumUsingFold tree)
        , describe "BTree.sumUsingFold"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> sumUsingFold
                        |> Expect.equal 0
            , test "of singleton" <|
                \() ->
                    1
                        |> singleton
                        |> sumUsingFold
                        |> Expect.equal 1
            , test "of 3 levels" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> sumUsingFold
                        |> Expect.equal 6
            ]
        , describe "BTree.sumInt"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> sumInt
                        |> Expect.equal 0
            , test "of singleton" <|
                \() ->
                    1
                        |> singleton
                        |> sumInt
                        |> Expect.equal 1
            , test "of 3 levels" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> sumInt
                        |> Expect.equal 6
            ]
        , describe "BTree.sumString"
            [ test "of empty" <|
                \() ->
                    Empty
                        |> sumString
                        |> Expect.equal ""
            , test "of singleton" <|
                \() ->
                    "abc"
                        |> singleton
                        |> sumString
                        |> Expect.equal "abc"
            , test "of 3 levels" <|
                \() ->
                    ["abc", "def", "ghi"]
                        |> fromList
                        |> sumString
                        |> Expect.equal "ghidefabc"
            ]
        , describe "BTree.flattenUsingFold"
            [ test "of 'Flatten a tree into a list'" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (List.sort (flatten tree)) (List.sort (flattenUsingFold tree))
            ]
        , describe "BTree.isElementUsingFold"
            [ test "of 'Check to see if an element is in a given tree', empty tree" <|
                \() ->
                    let
                        a = 5
                        tree = Empty
                    in
                        Expect.equal (isElement a tree) (isElementUsingFold a tree)
            ]
            , test "of 'Check to see if an element is in a given tree', yes found" <|
                \() ->
                    let
                        a = 5
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (isElement a tree) (isElementUsingFold a tree)
            , test "of 'Check to see if an element is in a given tree', not found" <|
                \() ->
                    let
                        a = 50
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (isElement a tree) (isElementUsingFold a tree)
            ]
         , describe "BTree.toTreeDiagramTree" -- not much of a test because constructors are not exposed
            [ test "of empty" <|
                \() ->
                    Expect.equal (TD.node Nothing []) (toTreeDiagramTree Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (TD.node (Just 1) [(TD.node Nothing []), (TD.node Nothing [])]) (toTreeDiagramTree (singleton 1))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (TD.node (Just 1) [(TD.node Nothing []), (TD.node (Just 2) [(TD.node Nothing []), (TD.node Nothing [])])]) (toTreeDiagramTree (fromList [1,2]))
            ]
         , describe "BTree.sort"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTree.sort Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.sort (singleton 1))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromList [1,2,3,4,5]) (BTree.sort (fromList [4,1,3,5,2]))
            ]
         , describe "BTree.sortBy"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTree.sortBy (MusicNote.sorter) Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton A) (BTree.sortBy (MusicNote.sorter) (singleton A))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromListBy (MusicNote.sorter) [A, B, D, E, G]) (BTree.sortBy (MusicNote.sorter) (fromListBy (MusicNote.sorter) [D, A, E, G, B]))
            ]
        , describe "BTree.fromList"
            [ test "from empty list" <|
                \() ->
                    []
                        |> fromList
                        |> Expect.equal Empty
            , test "from single element list" <|
                \() ->
                    ['a']
                        |> fromList
                        |> Expect.equal (singleton 'a')
            , test "from ordered-ascending list" <|
                \() ->
                    ['a', 'b', 'c']
                        |> fromList
                        |> Expect.equal (Node 'a' Empty (Node 'b' Empty (singleton 'c')))
            , test "from ordered-descending list" <|
                \() ->
                    ['c', 'b', 'a']
                        |> fromList
                        |> Expect.equal (Node 'c' (Node 'b' (singleton 'a') Empty) Empty)
            , test "from unordered list" <|
                \() ->
                    ['c', 'a', 'b']
                        |> fromList
                        |> Expect.equal (Node 'c' (Node 'a' Empty (singleton 'b')) Empty)
            , test "from list with duplications" <|
                \() ->
                    ['a', 'b', 'b']
                        |> fromList
                        |> Expect.equal (Node 'a' Empty (Node 'b' Empty (singleton 'b')))
            ]
        , describe "BTree.fromListBy"
            [ test "from empty list" <|
                \() ->
                    []
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal Empty
            , test "from single element list" <|
                \() ->
                    [A]
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal (singleton A)
            , test "from ordered-ascending list" <|
                \() ->
                    [A, B, C]
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton C)))
            , test "from ordered-descending list" <|
                \() ->
                    [C, B, A]
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node C (Node B (singleton A) Empty) Empty)
            , test "from unordered list" <|
                \() ->
                    [C, A, B]
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node C (Node A Empty (singleton B)) Empty)
            , test "from list with duplications" <|
                \() ->
                    [A, B, B]
                        |> fromListBy (MusicNote.sorter)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton B)))
            ]
        , describe "BTree.insert"
            [ test "insert into empty tree" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (insert newValue target)
            , test "insert larger value on right" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'c'
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (insert newValue target)
            , test "insert smaller value on left" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'a'
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (insert newValue target)
            , test "insert duplicate" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'b'
                        target = singleton currentValue
                    in
                        Expect.equal (Node 'b' Empty (singleton 'b')) (insert newValue target)
            ]
        , describe "BTree.insertBy"
            [ test "insertBy into empty tree" <|
                \() ->
                    let
                        target = Empty
                        newValue = A
                    in
                        Expect.equal (singleton newValue) (insertBy (MusicNote.sorter) newValue target)
            , test "insert larger value on right" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = C
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (insertBy (MusicNote.sorter) newValue target)
            , test "insert smaller value on left" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = A
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (insertBy (MusicNote.sorter) newValue target)
            , test "insert duplicate" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = B
                        target = singleton currentValue
                    in
                        Expect.equal (Node B Empty (singleton B)) (insertBy (MusicNote.sorter) newValue target)
            ]
         , describe "BTree.removeDuplicates"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTree.removeDuplicates Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.removeDuplicates (singleton 1))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromList [4, 1, 3, 5]) (BTree.removeDuplicates (fromList [4, 1, 3, 5, 1]))
            ]
         , describe "BTree.removeDuplicatesBy"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTree.removeDuplicatesBy (MusicNote.sorter) Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton A) (BTree.removeDuplicatesBy (MusicNote.sorter) (singleton A))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromListBy (MusicNote.sorter) [D, A, E, B]) (BTree.removeDuplicatesBy (MusicNote.sorter) (fromListBy (MusicNote.sorter) [D, A, E, A, B]))
            ]
         , describe "BTree.isAllNothing"
            [ test "of empty" <|
                \() ->
                    Expect.equal True (BTree.isAllNothing Empty)
            , test "of all nothing" <|
                \() ->
                    Expect.equal True (BTree.isAllNothing (singleton (Nothing)))
            , test "of something" <|
                \() ->
                    Expect.equal False (BTree.isAllNothing (Node Nothing Empty (singleton (Just 1))))
            ]
         , describe "BTree.isEmpty"
            [ test "of empty" <|
                \() ->
                    Expect.equal True (BTree.isEmpty Empty)
            , test "of all nothing" <|
                \() ->
                    Expect.equal False (BTree.isEmpty (singleton (Nothing)))
            , test "of something" <|
                \() ->
                    Expect.equal False (BTree.isEmpty (Node Nothing Empty (singleton (Just 1))))
            ]
        ]

