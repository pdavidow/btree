module BTree_Tests exposing (..)

import BTree exposing (BTree(..), TraversalOrder(..), Direction(..), singleton, depth, map, flatten, flattenBy, flattenUsingFold, flattenUsingFoldBy, isElement, fold, sumInt, sumMaybeSafeInt, sumBigInt, sumFloat, sumIntUsingFold, sumFloatUsingFold, sumString, isElementUsingFold, toTreeDiagramTree, sort, sortTo, sortByTo, sortWithTo, fromList, fromIntList, fromListBy, fromListWith, fromListAsIsBy, fromListAsIs_left, fromListAsIs_right, fromListAsIs_directed, insert, insertBy, insertWith, insertWith_directed, insertAsIs_left, insertAsIs_right, insertAsIsBy, insertAsIs_directed, deDuplicate, deDuplicateBy, isAllNothing, isEmpty, toNothingNodes)
import NodeTag exposing (NothingNode(..))
import MusicNote exposing (MusicNote(..), sorter)
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt)

import TreeDiagram as TD exposing (node)
import BigInt exposing (fromInt)

import Test exposing (..)
import Expect
  
 
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
                    (Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
                        |> BTree.depth
                        |> Expect.equal 5
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
            [ test "of flatten" <|
                \() ->
                    Expect.equal
                        (["+","*","/","A","**","B","C","D","E"])
                        (BTree.flatten <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            ]
        , describe "BTree.flattenBy"
            [ test "of InOrder" <|
                \() ->
                    Expect.equal
                        (["A","/","B","**","C","*","D","+","E"])
                        (BTree.flattenBy InOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            , test "of PreOrder" <|
                \() ->
                    Expect.equal
                        (["+","*","/","A","**","B","C","D","E"])
                        (BTree.flattenBy PreOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            , test "of PostOrder" <|
                \() ->
                    Expect.equal
                        (["A","B","C","**","/","D","*","E","+"])
                        (BTree.flattenBy PostOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            ]
        , describe "BTree.flattenUsingFoldBy"
            [ test "of InOrder" <|
                \() ->
                    Expect.equal
                        (["A","/","B","**","C","*","D","+","E"])
                        (BTree.flattenUsingFoldBy InOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            , test "of PreOrder" <|
                \() ->
                    Expect.equal
                        (["+","*","/","A","**","B","C","D","E"])
                        (BTree.flattenUsingFoldBy PreOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            , test "of PostOrder" <|
                \() ->
                    Expect.equal
                        (["A","B","C","**","/","D","*","E","+"])
                        (BTree.flattenUsingFoldBy PostOrder <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
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
                    Expect.equal
                        (["+","*","/","A","**","B","C","D","E"])
                        (BTree.flattenUsingFold <| Node "+" (Node "*" (Node "/" (singleton "A") (Node "**" (singleton "B") (singleton "C"))) (singleton "D")) (singleton "E"))
            , test "of flattenUsingFold.2" <|
                \() ->
                    let
                        tree = fromList [4, 7, 5, 6, 1]
                    in
                        Expect.equal
                            (List.sort (flatten tree))
                            (List.sort (BTree.flattenUsingFold tree))
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
                    let
                        expected = Just <|
                            TD.node (Just 1)
                                (   [ TD.node (Just 2)
                                        []
                                    , TD.node (Just 4)
                                        (   [ TD.node (Just 3)
                                                []
                                            ]
                                        )
                                    ]
                                )

                        result = BTree.toTreeDiagramTree <|
                            Node 1
                                (singleton 2)
                                (Node 4
                                    Empty
                                    (singleton 3)
                                )
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTree.sort"
            [ test "of sort.0" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sort Empty)
            , test "of sort.1" <|
                \() ->
                    Expect.equal
                        (singleton 1)
                        (BTree.sort (singleton 1))
            , test "of sort.2" <|
                \() ->
                    let
                        expected =
                            Node "A"
                                (Node "A_sharp"
                                    (Node "E"
                                        (singleton <| "F")
                                        (singleton <| "G")
                                    )
                                    (singleton <| "E")
                                )
                                (singleton <| "C_sharp")


                        result = BTree.sort <|
                            Node "F"
                                (Node "E"
                                    (Node "C_sharp"
                                        (Node "A"
                                            Empty
                                            (singleton <| "A_sharp")
                                        )
                                        Empty
                                    )
                                    (singleton <| "E")
                                )
                                (singleton <| "G")
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTree.sortTo"
            [ test "of sortTo.0a" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortTo Right Empty)
            , test "of sortTo.0b" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortTo Left Empty)
            , test "of sortTo.1a" <|
                \() ->
                    Expect.equal
                        (singleton 1)
                        (BTree.sortTo Right <| singleton 1)
            , test "of sortTo.1b" <|
                \() ->
                    Expect.equal
                        (singleton 1)
                        (BTree.sortTo Left <| singleton 1)
            , test "of sortTo.2a" <|
                \() ->
                    let
                        expected =
                            Node "A"
                                (singleton <| "C_sharp")
                                (Node "A_sharp"
                                    (singleton <| "E")
                                    (Node "E"
                                        (singleton <| "G")
                                        (singleton <| "F")
                                    )
                                )

                        result = BTree.sortTo Right <|
                            Node "F"
                                (Node "E"
                                    (Node "C_sharp"
                                        (Node "A"
                                            Empty
                                            (singleton <| "A_sharp")
                                        )
                                        Empty
                                    )
                                    (singleton <| "E")
                                )
                                (singleton <| "G")
                    in
                        Expect.equal
                            expected
                            result
            , test "of sortTo.2b" <|
                \() ->
                    let
                        expected =
                            Node "A"
                                (Node
                                    "A_sharp"
                                    (Node "E"
                                        (singleton <| "F")
                                        (singleton <| "G")
                                    )
                                    (singleton <| "E")
                                )
                                (singleton <| "C_sharp")


                        result = BTree.sortTo Left <|
                            Node "F"
                                (Node "E"
                                    (Node "C_sharp"
                                        (Node "A"
                                            Empty
                                            (singleton <| "A_sharp")
                                        )
                                        Empty
                                    )
                                    (singleton <| "E")
                                )
                                (singleton <| "G")
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTree.sortByTo"
            [ test "of sortByTo.0a" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortByTo MusicNote.sorter Right Empty)
            , test "of sortByTo.0b" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortByTo MusicNote.sorter Left Empty)
            , test "of sortByTo.1a" <|
                \() ->
                    Expect.equal
                        (singleton A)
                        (BTree.sortByTo MusicNote.sorter Right (singleton A))
            , test "of sortByTo.1b" <|
                \() ->
                    Expect.equal
                        (singleton A)
                        (BTree.sortByTo MusicNote.sorter Left (singleton A))
            , test "of sortByTo.2a" <|
                \() ->
                    let
                        expected =
                            Node A
                                (singleton <| C_sharp)
                                (Node A_sharp
                                    (singleton <| E)
                                    (Node E
                                        (singleton <| G)
                                        (singleton <| F)
                                    )
                                )

                        result = BTree.sortByTo MusicNote.sorter Right <|
                            Node F
                                (Node E
                                    (Node C_sharp
                                        (Node A
                                            Empty
                                            (singleton <| A_sharp)
                                        )
                                        Empty
                                    )
                                    (singleton <| E)
                                )
                                (singleton <| G)
                    in
                        Expect.equal
                            expected
                            result
            , test "of sortByTo.2b" <|
                \() ->
                    let
                        expected =
                            Node A
                                (Node A_sharp
                                    (Node E
                                        (singleton <| F)
                                        (singleton <| G)
                                    )
                                    (singleton <| E)
                                )
                                (singleton <| C_sharp)

                        result = BTree.sortByTo MusicNote.sorter Left <|
                            Node F
                                (Node E
                                    (Node C_sharp
                                        (Node A
                                            Empty
                                            (singleton <| A_sharp)
                                        )
                                        Empty
                                    )
                                    (singleton <| E)
                                )
                                (singleton <| G)
                    in
                        Expect.equal
                            expected
                            result
            ]
         , describe "BTree.sortWithTo"
            [ test "of sortWithTo.0a" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortWithTo BigInt.compare Right Empty)
            , test "of sortWithTo.0b" <|
                \() ->
                    Expect.equal
                        (Empty)
                        (BTree.sortWithTo BigInt.compare Left Empty)
            , test "of sortWithTo.1a" <|
                \() ->
                    Expect.equal
                        (singleton <| BigInt.fromInt 1)
                        (BTree.sortWithTo BigInt.compare Right (singleton <| BigInt.fromInt 1))
            , test "of sortWithTo.1b" <|
                \() ->
                    Expect.equal
                        (singleton <| BigInt.fromInt 1)
                        (BTree.sortWithTo BigInt.compare Left (singleton <| BigInt.fromInt 1))
            , test "of sortWithTo.2a" <|
                \() ->
                    let
                        expected =
                            Node (BigInt.fromInt 1)
                                (singleton <| BigInt.fromInt 5)
                                (Node (BigInt.fromInt 2)
                                    (singleton <| BigInt.fromInt 8)
                                    (Node (BigInt.fromInt 8)
                                        (singleton <| BigInt.fromInt 10)
                                        (singleton <| BigInt.fromInt 9)
                                    )
                                )

                        result = BTree.sortWithTo BigInt.compare Right <|
                            Node (BigInt.fromInt 9)
                                (Node (BigInt.fromInt 8)
                                    (Node (BigInt.fromInt 5)
                                        (Node (BigInt.fromInt 1)
                                            Empty
                                            (singleton <| BigInt.fromInt 2)
                                        )
                                        Empty
                                    )
                                    (singleton <| BigInt.fromInt 8)
                                )
                                (singleton <| BigInt.fromInt 10)
                    in
                        Expect.equal
                            expected
                            result
            , test "of sortWithTo.2b" <|
                \() ->
                    let
                        expected =
                            Node (BigInt.fromInt 1)
                                (Node (BigInt.fromInt 2)
                                    (Node (BigInt.fromInt 8)
                                        (singleton <| BigInt.fromInt 9)
                                        (singleton <| BigInt.fromInt 10)
                                    )
                                    (singleton <| BigInt.fromInt 8)
                                )
                                (singleton <| BigInt.fromInt 5)

                        result = BTree.sortWithTo BigInt.compare Left <|
                            Node (BigInt.fromInt 9)
                                (Node (BigInt.fromInt 8)
                                    (Node (BigInt.fromInt 5)
                                        (Node (BigInt.fromInt 1)
                                            Empty
                                            (singleton <| BigInt.fromInt 2)
                                        )
                                        Empty
                                    )
                                    (singleton <| BigInt.fromInt 8)
                                )
                                (singleton <| BigInt.fromInt 10)
                    in
                        Expect.equal
                            expected
                            result
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
        , describe "BTree.fromListWith"
            [ test "of fromListWith.0" <|
                \() ->
                    []
                        |> BTree.fromListWith (BigInt.compare)
                        |> Expect.equal Empty
            , test "of fromListWith.1" <|
                \() ->
                    [BigInt.fromInt 1, BigInt.fromInt 2]
                        |> BTree.fromListWith (BigInt.compare)
                        |> Expect.equal (Node (BigInt.fromInt 1) Empty (singleton <| BigInt.fromInt 2))
            , test "of fromListWith.2" <|
                \() ->
                    [BigInt.fromInt 2, BigInt.fromInt 1]
                        |> BTree.fromListWith (BigInt.compare)
                        |> Expect.equal (Node (BigInt.fromInt 2) (singleton <| BigInt.fromInt 1) Empty)
            ]
         , describe "BTree.fromListAsIsBy"
            [ test "of fromListAsIsBy.0 Left" <|
                \() ->
                    Expect.equal Empty (BTree.fromListAsIsBy Left [])
            , test "of fromListAsIsBy.0 Right" <|
                \() ->
                    Expect.equal Empty (BTree.fromListAsIsBy Right [])
            , test "of fromListAsIsBy.1 Left" <|
                \() ->
                    Expect.equal
                        (Node 1
                            (Node 2
                                (singleton 4)
                                Empty
                            )
                            (singleton 3)
                         )
                        (BTree.fromListAsIsBy Left [1,2,3,4])
            , test "of fromListAsIsBy.1 Right" <|
                \() ->
                    Expect.equal
                        (Node 1
                            (singleton 3)
                            (Node 2
                                Empty
                                (singleton 4)
                            )
                        )
                        (BTree.fromListAsIsBy Right [1,2,3,4])
            ]
         , describe "BTree.fromListAsIs_left"
            [ test "of fromListAsIs_left.0" <|
                \() ->
                    Expect.equal Empty (BTree.fromListAsIs_left [])
            , test "of fromListAsIs_left.1" <|
                \() ->
                    Expect.equal
                        (Node 1
                            (Node 2
                                (singleton 4)
                                Empty
                            )
                            (singleton 3)
                         )
                        (BTree.fromListAsIs_left [1,2,3,4])
            ]
         , describe "BTree.fromListAsIs_right"
            [ test "of fromListAsIs_right.0" <|
                \() ->
                    Expect.equal Empty (BTree.fromListAsIs_right [])
            , test "of fromListAsIs_right.1" <|
                \() ->
                    Expect.equal
                        (Node 1
                            (singleton 3)
                            (Node 2
                                Empty
                                (singleton 4)
                            )
                        )
                        (BTree.fromListAsIs_right [1,2,3,4])
            ]
         , describe "BTree.fromListAsIs_directed"
            [ test "of fromListAsIs_directed.0" <|
                \() ->
                    Expect.equal Empty (BTree.fromListAsIs_directed [])
            , test "of fromListAsIs_directed.1a" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.fromListAsIs_directed [(1, Left)])
            , test "of fromListAsIs_directed.1b" <|
                \() ->
                    Expect.equal (singleton 1) (BTree.fromListAsIs_directed [(1, Right)])
            , test "of fromListAsIs_directed.2" <|
                \() ->
                    Expect.equal
                        (Node 535
                            (singleton 589)
                            (Node 817
                                (singleton 842)
                                (singleton 554)
                            )
                        )
                        (BTree.fromListAsIs_directed [(535,Right),(817,Right),(589,Left),(554,Right),(842,Right)])
            , test "of fromListAsIs_directed.3" <|
                \() ->
                    Expect.equal
                        (Node 258
                            (Node 305
                                (Node 220
                                    (singleton 156)
                                    Empty
                                )
                                (singleton 486)
                            )
                            (Node 5
                                (singleton 697)
                                (Node 801
                                    (singleton 323)
                                    (singleton 871)
                                )
                            )
                        )
                        (BTree.fromListAsIs_directed [(258,Left),(305,Left),(5,Right),(801,Right),(220,Left),(697,Right),(486,Left),(156,Left),(871,Right),(323,Right)])
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
                        Expect.equal (singleton newValue) (BTree.insertBy MusicNote.sorter newValue target)
            , test "of insertBy.1" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = C
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertBy MusicNote.sorter newValue target)
            , test "of insertBy.2" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = A
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertBy MusicNote.sorter newValue target)
            , test "of insertBy.3" <|
                 \() ->
                    let
                        currentValue = B
                        newValue = B
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertBy MusicNote.sorter newValue target)
            ]
        , describe "BTree.insertWith"
            [ test "of insertWith.0" <|
                \() ->
                    let
                        target = Empty
                        newValue = BigInt.fromInt 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertWith BigInt.compare newValue target)
            , test "of insertWith.1" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertWith BigInt.compare newValue target)
            , test "of insertWith.2" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertWith BigInt.compare newValue target)
            , test "of insertWith.3" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertWith BigInt.compare newValue target)

            ]
        , describe "BTree.insertWith_directed"
            [ test "of insertWith_directed.0a" <|
                \() ->
                    let
                        target = Empty
                        newValue = BigInt.fromInt 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertWith_directed Left BigInt.compare newValue target)
            , test "of insertWith_directed.0b" <|
                \() ->
                    let
                        target = Empty
                        newValue = BigInt.fromInt 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertWith_directed Right BigInt.compare newValue target)
            , test "of insertWith_directed.1a" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertWith_directed Left BigInt.compare newValue target)
            , test "of insertWith_directed.1b" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertWith_directed Right BigInt.compare newValue target)
            , test "of insertWith_directed.2a" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertWith_directed Left BigInt.compare newValue target)
            , test "of insertWith_directed.2b" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertWith_directed Right BigInt.compare newValue target)
            , test "of insertWith_directed.3a" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertWith_directed Left BigInt.compare newValue target)
            , test "of insertWith_directed.3b" <|
                 \() ->
                    let
                        currentValue = BigInt.fromInt 2
                        newValue = BigInt.fromInt 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertWith_directed Right BigInt.compare newValue target)
            ]
        , describe "BTree.insertAsIs_left"
            [ test "of insertAsIs_left.0" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIs_left newValue target)
            , test "of insertAsIs_left.1" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIs_left newValue target)
            , test "of insertAsIs_left.2" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIs_left newValue target)
            , test "of insertAsIs_left.3" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIs_left newValue target)
            , test "of insertAsIs_left.4" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (Node 1
                                (singleton 3)
                                Empty
                            )
                            (singleton 2)
                        )
                        (BTree.insertAsIs_left 3
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
            ]
        , describe "BTree.insertAsIs_right"
            [ test "of insertAsIs_right.0" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIs_right newValue target)
            , test "of insertAsIs_right.1" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIs_right newValue target)
            , test "of insertAsIs_right.2" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIs_right newValue target)
            , test "of insertAsIs_right.3" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIs_right newValue target)
            , test "of insertAsIs_right.4" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (singleton 1)
                            (Node 2
                                Empty
                                (singleton 3)
                            )
                        )
                        (BTree.insertAsIsBy Right 3
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
            ]
        , describe "BTree.insertAsIsBy"
            [ test "of insertAsIsBy.0a" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIsBy Left newValue target)
            , test "of insertAsIsBy.0b" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIsBy Right newValue target)
            , test "of insertAsIsBy.1a" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIsBy Left newValue target)
            , test "of insertAsIsBy.1b" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIsBy Right newValue target)
            , test "of insertAsIsBy.2a" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIsBy Left newValue target)
            , test "of insertAsIsBy.2b" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIsBy Right newValue target)
            , test "of insertAsIsBy.3a" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue newChild Empty) (BTree.insertAsIsBy Left newValue target)
            , test "of insertAsIsBy.3b" <|
                 \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        target = singleton currentValue
                        newChild = singleton newValue
                    in
                        Expect.equal (Node currentValue Empty newChild) (BTree.insertAsIsBy Right newValue target)
            , test "of insertAsIsBy.4a" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (Node 1
                                (singleton 3)
                                Empty
                            )
                            (singleton 2)
                        )
                        (BTree.insertAsIsBy Left 3
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
            , test "of insertAsIsBy.4b" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (singleton 1)
                            (Node 2
                                Empty
                                (singleton 3)
                            )
                        )
                        (BTree.insertAsIsBy Right 3
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
            ]
        , describe "BTree.insertAsIs_directed"
            [ test "of insertAsIs_directed.0a" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                        direction = Left
                        insert = (newValue, direction)
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIs_directed insert target)
            , test "of insertAsIs_directed.0b" <|
                \() ->
                    let
                        target = Empty
                        newValue = 1
                        direction = Right
                        insert = (newValue, direction)
                    in
                        Expect.equal (singleton newValue) (BTree.insertAsIs_directed insert target)
            , test "of insertAsIs_directed.1a" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        direction = Left
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue (singleton newValue) Empty) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.1b" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 3
                        direction = Right
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue Empty (singleton newValue)) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.2a" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        direction = Left
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue (singleton newValue) Empty) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.2b" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 1
                        direction = Right
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue Empty (singleton newValue)) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.3a" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        direction = Left
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue (singleton newValue) Empty) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.3b" <|
                \() ->
                    let
                        currentValue = 2
                        newValue = 2
                        direction = Right
                        insert = (newValue, direction)
                    in
                        Expect.equal (Node currentValue Empty (singleton newValue)) (BTree.insertAsIs_directed insert (singleton currentValue))
            , test "of insertAsIs_directed.4a" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (Node 1
                                (singleton 3)
                                Empty
                            )
                            (singleton 2)
                        )
                        (BTree.insertAsIs_directed (3, Left)
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
            , test "of insertAsIs_directed.4b" <|
                 \() ->
                    Expect.equal
                        (Node 0
                            (singleton 1)
                            (Node 2
                                Empty
                                (singleton 3)
                            )
                        )
                        (BTree.insertAsIs_directed (3, Right)
                            (Node 0
                                (singleton 1)
                                (singleton 2)
                            )
                        )
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
                    let
                        expected =
                            Node 444
                                (singleton 4)
                                (singleton -9)

                        result = BTree.deDuplicate <|
                            Node 444
                                (singleton 4)
                                (Node -9
                                    Empty
                                    (singleton 4)
                                )
                    in
                        Expect.equal
                            expected
                            result
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
                    let
                        expected =
                            Node E
                                (singleton F)
                                Empty

                        result = BTree.deDuplicateBy (MusicNote.sorter) <|
                            Node E
                                (singleton F)
                                (singleton E)
                    in
                        Expect.equal
                            expected
                            result
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
                    Expect.equal (singleton NothingNodeVal) (BTree.toNothingNodes (singleton 3))
            , test "of toNothingNodes.2" <|
                \() ->
                    Expect.equal (Node NothingNodeVal (singleton NothingNodeVal) (singleton NothingNodeVal)) (BTree.toNothingNodes (Node 1 (singleton 2) (singleton 3)))
            ]
        ]