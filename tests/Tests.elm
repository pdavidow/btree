-- elm-test

module Tests exposing (..)

import BTree exposing (..)
import BTree exposing (NodeTag(..))
import TreeDiagram as TD exposing (node)
import BTreeUniformType exposing (toTagged, incrementNodes, decrementNodes, raiseNodes)
import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import MusicNote exposing (MusicNote(..), (:+:), (:-:), displayString, sortOrder)

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
            , test "insert duplicate" <|
                 \() ->
                    let
                        currentValue = 'b'
                        newValue = 'b'
                        target = singleton currentValue
                    in
                        Expect.equal (Node 'b' Empty (singleton 'b')) (insert newValue target)
            ]
        , describe "insertBy"
            [ test "insertBy into empty tree" <|
                \() ->
                    let
                        target = Empty
                        newValue = A
                    in
                        Expect.equal (singleton newValue) (insertBy (MusicNote.sortOrder) newValue target)
            , test "insert larger value on right" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = C
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (insertBy (MusicNote.sortOrder) newValue target)
            , test "insert smaller value on left" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = A
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (insertBy (MusicNote.sortOrder) newValue target)
            , test "insert duplicate" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = B
                        target = singleton currentValue
                    in
                        Expect.equal (Node B Empty (singleton B)) (insertBy (MusicNote.sortOrder) newValue target)
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
                        |> Expect.equal (Node 'a' Empty (Node 'b' Empty (singleton 'b')))
            ]
        , describe "fromListBy"
            [ test "from empty list" <|
                \() ->
                    []
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal Empty
            , test "from single element list" <|
                \() ->
                    [A]
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal (singleton A)
            , test "from ordered-ascending list" <|
                \() ->
                    [A, B, C]
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton C)))
            , test "from ordered-descending list" <|
                \() ->
                    [C, B, A]
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal (Node C (Node B (singleton A) Empty) Empty)
            , test "from unordered list" <|
                \() ->
                    [C, A, B]
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal (Node C (Node A Empty (singleton B)) Empty)
            , test "from list with duplications" <|
                \() ->
                    [A, B, B]
                        |> fromListBy (MusicNote.sortOrder)
                        |> Expect.equal (Node A Empty (Node B Empty (singleton B)))
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
         , describe "toTagged"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (toTagged (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 1)) (toTagged (BTreeInt (singleton 1)))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a") Empty (singleton (StringNode "b"))) (toTagged (BTreeString (fromList ["a", "b"])))
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
                    Expect.equal (Empty) (BTree.sortBy (MusicNote.sortOrder) Empty)
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton A) (BTree.sortBy (MusicNote.sortOrder) (singleton A))
            , test "of 5 values" <|
                \() ->
                    Expect.equal (fromListBy (MusicNote.sortOrder) [A, B, D, E, G]) (BTree.sortBy (MusicNote.sortOrder) (fromListBy (MusicNote.sortOrder) [D, A, E, G, B]))
            ]
         , describe "BTreeUniformType.incrementNodes"
            [ test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.incrementNodes 1 (BTreeInt Empty))
            , test "of 2 BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt (Node 4 Empty (singleton 5))) (BTreeUniformType.incrementNodes 3 (BTreeInt (fromList [1, 2])))
            , test "of empty BTreeString" <|
                \() ->
                    Expect.equal (BTreeString Empty) (BTreeUniformType.incrementNodes 1 (BTreeString Empty))
            , test "of 2 BTreeString" <|
                \() ->
                    Expect.equal (BTreeString (Node "a +3" Empty (singleton "b +3"))) (BTreeUniformType.incrementNodes 3 (BTreeString (fromList ["a", "b"])))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool Empty) (BTreeUniformType.incrementNodes 1 (BTreeBool Empty))
            , test "of 2 BTreeBool, change" <|
                \() ->
                    Expect.equal (BTreeBool (Node False Empty (singleton True))) (BTreeUniformType.incrementNodes 3 (BTreeBool (Node True Empty (singleton False))))
            , test "of 2 BTreeBool,  no change" <|
                \() ->
                    Expect.equal (BTreeBool (Node True Empty (singleton False))) (BTreeUniformType.incrementNodes 8 (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNote Empty) (BTreeUniformType.incrementNodes 1 (BTreeMusicNote Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNote (Node (Just G_sharp) (singleton (Nothing)) Empty))) (BTreeUniformType.incrementNodes 1 (BTreeMusicNote (Node (Just G) (singleton (Just G_sharp)) Empty)))
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
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNote Empty) (BTreeUniformType.decrementNodes 1 (BTreeMusicNote Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNote (Node (Just A) (singleton (Nothing)) Empty))) (BTreeUniformType.decrementNodes 1 (BTreeMusicNote (Node (Just A_sharp) (singleton (Just A)) Empty)))
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
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNote Empty) (BTreeUniformType.decrementNodes 1 (BTreeMusicNote Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNote (Node (Just A_sharp) (singleton (Just A)) Empty))) (BTreeUniformType.raiseNodes 1 (BTreeMusicNote (Node (Just A_sharp) (singleton (Just A)) Empty)))
            ]
         , describe "BTreeVariedType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.incrementNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 11))) (BTreeVariedType.incrementNodes 1 (BTreeVaried (singleton (IntNode 10))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "abcde +3") (singleton (IntNode 14)) (Node (MusicNoteNode (Just G)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.incrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.decrementNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 9))) (BTreeVariedType.decrementNodes 1 (BTreeVaried (singleton (IntNode 10))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "abcde -3") (singleton (IntNode 8)) (Node (MusicNoteNode (Just C_sharp)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.decrementNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.raiseNodes 1 (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 8))) (BTreeVariedType.raiseNodes 3 (BTreeVaried (singleton (IntNode 2))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (StringNode "abcde ^3") (singleton (IntNode 8)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode False)) Empty))) (BTreeVariedType.raiseNodes 3 (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 2)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeUniformType.toStringLength"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeInt Empty)) (BTreeUniformType.toStringLength (BTreeString Empty))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeInt (Node 2 Empty (singleton 5)))) (BTreeUniformType.toStringLength (BTreeString (fromList ["ab", "cdefg"])))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeInt Empty))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeInt (fromList [12, 34567])))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeBool Empty))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeMusicNote Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeMusicNote (Node (Just A) Empty (singleton (Just B)))))
            ]
         , describe "BTreeUniformType.toIsIntPrime"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeString Empty))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeString (fromList ["ab", "cdefg"])))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (Just (BTreeBool Empty)) (BTreeUniformType.toIsIntPrime (BTreeInt Empty))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal (Just (BTreeBool (Node False Empty (singleton True)))) (BTreeUniformType.toIsIntPrime (BTreeInt (fromList [12, 13])))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeBool Empty))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeMusicNote Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeMusicNote (Node (Just A) Empty (singleton (Just B)))))
            ]
         , describe "BTreeVariedType.toStringLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toStringLength (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (IntNode 3))) (BTreeVariedType.toStringLength (BTreeVaried (singleton (StringNode "abc"))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node (IntNode 5) (singleton NothingNode) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toStringLength (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 1)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeVariedType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toIsIntPrime (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried (singleton (BoolNode False))) (BTreeVariedType.toIsIntPrime (BTreeVaried (singleton (IntNode 1))))
            , test "of 4 values" <|
                \() ->
                    Expect.equal (BTreeVaried (Node NothingNode (singleton (BoolNode True)) (Node NothingNode (singleton NothingNode) Empty))) (BTreeVariedType.toIsIntPrime (BTreeVaried (Node (StringNode "abcde") (singleton (IntNode 11)) (Node (MusicNoteNode (Just E)) (singleton (BoolNode True)) Empty))))
            ]
         , describe "BTreeUniformType.sort"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeString Empty)) (BTreeUniformType.sort (BTreeString Empty))
            , test "of singleton BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeString (singleton "a"))) (BTreeUniformType.sort(BTreeString (singleton "a")))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeString (Node "a" Empty (singleton "b")))) (BTreeUniformType.sort (BTreeString (Node "b" Empty (singleton "a"))))
            , test "of 3 values with duplicate, BTreeString" <|
                \() ->
                    Expect.equal (Just (BTreeString (Node "a" Empty (Node "b" Empty (singleton "b"))))) (BTreeUniformType.sort (BTreeString (Node "b" Empty (Node "a" Empty (singleton "b")))))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (Just (BTreeInt Empty)) (BTreeUniformType.sort (BTreeInt Empty))
            , test "of singleton BTreeInt" <|
                \() ->
                    Expect.equal (Just (BTreeInt (singleton 1))) (BTreeUniformType.sort(BTreeInt (singleton 1)))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal (Just (BTreeInt (Node 1 Empty (singleton 2)))) (BTreeUniformType.sort (BTreeInt (Node 2 Empty (singleton 1))))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal (Just (BTreeBool Empty)) (BTreeUniformType.sort (BTreeBool Empty))
            , test "of singleton BTreeBool" <|
                \() ->
                    Expect.equal (Just (BTreeBool (singleton True))) (BTreeUniformType.sort(BTreeBool (singleton True)))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal (Just (BTreeBool (Node False Empty (singleton True)))) (BTreeUniformType.sort (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal (Just (BTreeMusicNote Empty)) (BTreeUniformType.sort (BTreeMusicNote Empty))
            , test "of singleton BTreeMusicNote" <|
                \() ->
                    Expect.equal (Just (BTreeMusicNote (singleton (Just A)))) (BTreeUniformType.sort(BTreeMusicNote (singleton (Just A))))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal (Just (BTreeMusicNote (Node (Just A) Empty (singleton (Just E))))) (BTreeUniformType.sort (BTreeMusicNote (Node (Just E) Empty (singleton (Just A)))))
            ]
         , describe "BTreeUniformType.sumInt"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeString Empty))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeString (Node "b" Empty (singleton "a"))))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (Just 0) (BTreeUniformType.sumInt (BTreeInt Empty))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal (Just 3) (BTreeUniformType.sumInt (BTreeInt (Node 2 Empty (singleton 1))))

            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeBool Empty))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeMusicNote Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeMusicNote (Node (Just A) Empty (singleton (Just D)))))
            ]
         , describe "BTreeUniformType.sumString"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (Just "") (BTreeUniformType.sumString (BTreeString Empty))
            , test "of 2 values BTreeString" <|
                \() ->
                    Expect.equal (Just "ab") (BTreeUniformType.sumString (BTreeString (Node "b" Empty (singleton "a"))))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeInt Empty))
            , test "of 2 values BTreeInt" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeInt (Node 2 Empty (singleton 1))))

            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeBool Empty))
            , test "of 2 values BTreeBool" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeBool (Node True Empty (singleton False))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeMusicNote Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeMusicNote (Node (Just A) Empty (singleton (Just D)))))
            ]
         , describe "BTreeUniformType.removeDuplicates"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal (BTreeString Empty) (BTreeUniformType.removeDuplicates (BTreeString Empty))
            , test "of 3 values BTreeString" <|
                \() ->
                    Expect.equal (BTreeString (Node "a" Empty (singleton "b"))) (BTreeUniformType.removeDuplicates (BTreeString (Node "a" (singleton "b") (singleton "a"))))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt Empty) (BTreeUniformType.removeDuplicates (BTreeInt Empty))
            , test "of 3 values BTreeInt" <|
                \() ->
                    Expect.equal (BTreeInt (Node 1 Empty (singleton 2))) (BTreeUniformType.removeDuplicates (BTreeInt (Node 1 (singleton 2) (singleton 1))))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool Empty) (BTreeUniformType.removeDuplicates (BTreeBool Empty))
            , test "of 3 values BTreeBool" <|
                \() ->
                    Expect.equal (BTreeBool (Node True (singleton False) Empty)) (BTreeUniformType.removeDuplicates (BTreeBool (Node True (singleton False) (singleton True))))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNote Empty) (BTreeUniformType.removeDuplicates (BTreeMusicNote Empty))
            , test "of 3 values BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNote (Node (Just F) (singleton (Just E)) Empty)) (BTreeUniformType.removeDuplicates (BTreeMusicNote (Node (Just F) (singleton (Just E)) (singleton (Just F)))))
            ]
         , describe "MusicNote.(:+:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just G_sharp) ((Just F) :+: 3)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just F) :+: 4)
            ]
         , describe "MusicNote.(:-:)"
            [ test "within range" <|
                \() ->
                    Expect.equal (Just A) ((Just B) :-: 2)
            , test "outside range" <|
                \() ->
                    Expect.equal (Nothing) ((Just B) :-: 3)
            ]
         , describe "MusicNote.displayString"
            [ test "plain" <|
                \() ->
                    Expect.equal ("D") (MusicNote.displayString D)
            , test "sharp" <|
                \() ->
                    Expect.equal ("D#") (MusicNote.displayString D_sharp)
            ]
        ]
