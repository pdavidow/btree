-- elm-test

module Tests exposing (..)

import BTree exposing (..)
import BTree exposing (NodeTag(..))
import TreeDiagram as TD exposing (node)
import BTreeUniformType exposing (toTaggedBTree, incrementNodes, decrementNodes, raiseNodes)
import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeVariedType exposing (incrementNodes, decrementNodes, raiseNodes)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String

all : Test
all =
    describe "The BTree module"
        [ describe "insert"
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
            , test "no insert equal value" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'b'
                        target = singleton currentValue
                    in
                        Expect.equal (target) (insert newValue target)
            ]
        , describe "fromList"
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
                        |> Expect.equal (fromList ['a', 'b'])
            ]
        , describe "depth"
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
        , describe "map"
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
        , describe "sum"
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
        , describe "sumString"
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
        , describe "flatten"
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
        , describe "isElement"
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
        , describe "fold"
            [ test "of empty" <|
                \() ->
                    let
                        func = (*)
                        seed = 3
                        tree = Empty
                    in
                        Expect.equal (seed) (fold func seed tree)

            , test "of singleton" <|
                \() ->
                    let
                        func = (*)
                        seed = 3
                        v = 5
                        tree = singleton v
                    in
                        Expect.equal (func seed v) (fold func seed tree)
            , test "of 3 value nodes" <|
                \() ->
                    let
                        func = (*)
                        seed = 3
                        list = [4, 5, 6]
                        tree = fromList list
                    in
                        Expect.equal (List.foldl func seed list) (fold func seed tree) -- same with List.foldr
            , test "of 'Sum all of the elements of a tree'" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (sum tree) (sumUsingFold tree)
            , test "of 'Flatten a tree into a list'" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal (List.sort (flatten tree)) (List.sort (flattenUsingFold tree))
            , test "of 'Check to see if an element is in a given tree', empty tree" <|
                \() ->
                    let
                        a = 5
                        tree = Empty
                    in
                        Expect.equal (isElement a tree) (isElementUsingFold a tree)
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
         , describe "toTreeDiagramTree" -- not much of a test because constructors are not exposed
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
         , describe "toTaggedBTree"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (toTaggedBTree (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 1)) (toTaggedBTree (BTreeInt (singleton 1)))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a") Empty (singleton (StringNode "b"))) (toTaggedBTree (BTreeString (fromList ["a", "b"])))
            ]
         , describe "BTree.sort"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTree.sort (Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (1)) (BTree.sort (singleton (1)))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromList [1,2,3,4,5]) (BTree.sort (fromList [4,1,3,5,2]))
            ]
         , describe "BTreeUniformType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.incrementNodes 1 (BTreeInt Empty))
            , test "of int singleton" <|
                \() ->
                    Expect.equal (BTreeInt (singleton 11)) (BTreeUniformType.incrementNodes 1 (BTreeInt (singleton 10)))
            , test "of 2 string values" <|
                \() ->
                    Expect.equal (BTreeString (Node "a +3" Empty (singleton "b +3"))) (BTreeUniformType.incrementNodes 3 (BTreeString (fromList ["a", "b"])))
            , test "of 2 bool values, change" <|
                \() ->
                    Expect.equal (BTreeBool (Node False Empty (singleton True))) (BTreeUniformType.incrementNodes 3 (BTreeBool (Node True Empty (singleton False))))
            , test "of 2 bool values,  no change" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.incrementNodes 8 (BTreeBool (Node True Empty (singleton False))))
            ]
         , describe "BTreeUniformType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.decrementNodes 1 (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeInt (singleton 9)) (BTreeUniformType.decrementNodes 1 (BTreeInt (singleton 10)))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (BTreeString (Node "a -3" Empty (singleton "b -3"))) (BTreeUniformType.decrementNodes 3 (BTreeString (fromList ["a", "b"])))
            , test "of 2 bool values, change" <|
                \() ->
                    Expect.equal (BTreeBool (Node False Empty (singleton True))) (BTreeUniformType.decrementNodes 3 (BTreeBool (Node True Empty (singleton False))))
            , test "of 2 bool values,  no change" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.decrementNodes 8 (BTreeBool (Node True Empty (singleton False))))
            ]
         , describe "BTreeUniformType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.raiseNodes 1 (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeInt (singleton 8)) (BTreeUniformType.raiseNodes 3 (BTreeInt (singleton 2)))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (BTreeString (Node "a ^3" Empty (singleton "b ^3"))) (BTreeUniformType.raiseNodes 3 (BTreeString (fromList ["a", "b"])))
            , test "of 2 bool values, change" <|
                \() ->
                    Expect.equal (BTreeBool (Node False Empty (singleton True))) (BTreeUniformType.raiseNodes 3 (BTreeBool (Node True Empty (singleton False))))
            , test "of 2 bool values,  no change" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.raiseNodes 8 (BTreeBool (Node True Empty (singleton False))))
            ]
         , describe "BTreeVariedType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTreeVariedType.incrementNodes 1 (Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 11)) (BTreeVariedType.incrementNodes 1 (singleton (IntNode 10)))
            , test "of 3 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a +3") (singleton (IntNode 4)) (singleton (BoolNode False))) (BTreeVariedType.incrementNodes 3 (Node (StringNode "a") (singleton (IntNode 1)) (singleton (BoolNode True))))
            ]
         , describe "BTreeVariedType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTreeVariedType.decrementNodes 1 (Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 9)) (BTreeVariedType.decrementNodes 1 (singleton (IntNode 10)))
            , test "of 3 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a -4") (singleton (IntNode -3)) (singleton (BoolNode True))) (BTreeVariedType.decrementNodes 4 (Node (StringNode "a") (singleton (IntNode 1)) (singleton (BoolNode True))))
            ]
         , describe "BTreeVariedType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (BTreeVariedType.raiseNodes 1 (Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 8)) (BTreeVariedType.raiseNodes 3 (singleton (IntNode 2)))
            , test "of 3 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a ^2") (singleton (IntNode 25)) (singleton (BoolNode True))) (BTreeVariedType.raiseNodes 2 (Node (StringNode "a") (singleton (IntNode 5)) (singleton (BoolNode True))))
            ]
         , describe "BTreeUniformType.toStringLength"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.toStringLength (BTreeString Empty))
            , test "of singleton BTreeString" <|
                \() ->
                    Expect.equal (BTreeInt (singleton 3)) (BTreeUniformType.toStringLength(BTreeString (singleton "abc")))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal (BTreeInt (Node 2 Empty (singleton 5))) (BTreeUniformType.toStringLength (BTreeString (fromList ["ab", "cdefg"])))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.toStringLength (BTreeString Empty))
            , test "of singleton BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt (singleton 123)) (BTreeUniformType.toStringLength(BTreeInt (singleton 123)))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt (Node 12 Empty (singleton 34567))) (BTreeUniformType.toStringLength (BTreeInt (fromList [12, 34567])))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool Empty) (BTreeUniformType.toStringLength (BTreeBool Empty))
            , test "of singleton BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool (singleton True)) (BTreeUniformType.toStringLength(BTreeBool (singleton True)))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.toStringLength (BTreeBool (Node True Empty (singleton False))))
            ]
         , describe "BTreeUniformType.toIsIntPrime"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (BTreeString Empty) (BTreeUniformType.toIsIntPrime (BTreeString Empty))
            , test "of singleton BTreeString" <|
                \() ->
                    Expect.equal (BTreeString (singleton "abc")) (BTreeUniformType.toIsIntPrime(BTreeString (singleton "abc")))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal (BTreeString (fromList ["ab", "cdefg"])) (BTreeUniformType.toIsIntPrime (BTreeString (fromList ["ab", "cdefg"])))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (BTreeBool Empty) (BTreeUniformType.toIsIntPrime (BTreeInt Empty))
            , test "of singleton BTreeInt" <|
                \() ->
                    Expect.equal (BTreeBool (singleton True)) (BTreeUniformType.toIsIntPrime(BTreeInt (singleton 13)))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal (BTreeBool (Node False Empty (singleton True))) (BTreeUniformType.toIsIntPrime (BTreeInt (fromList [12, 13])))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool Empty) (BTreeUniformType.toIsIntPrime (BTreeBool Empty))
            , test "of singleton BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool (singleton True)) (BTreeUniformType.toIsIntPrime(BTreeBool (singleton True)))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.toIsIntPrime (BTreeBool (Node True Empty (singleton False))))
            ]
        ]

