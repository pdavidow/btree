module Tests exposing (..)

import BTree exposing (..)

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
                        |> map (\a -> (a + 1))
                        |> Expect.equal Empty
            , test "of singleton" <|
                \() ->
                    1
                        |> singleton
                        |> map (\a -> (a + 1))
                        |> Expect.equal (singleton 2)
            , test "of 3 levels" <|
                \() ->
                    [1, 2, 3]
                        |> fromList
                        |> map (\a -> (a * a))
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
        ]