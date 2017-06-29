module BTreeUniformType_Tests exposing (..)

import BTreeUniformType exposing (toNothing, toTaggedNodes, incrementNodes, decrementNodes, raiseNodes, isAllNothing)
import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (..)
import MusicNote exposing (MusicNote(..), sorter)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


bTreeUniformType : Test
bTreeUniformType =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.toNothing"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeNothing Empty) (toNothing (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    singleton 1
                        |> BTreeInt
                        |> toNothing
                        |> toTaggedNodes -- called because should not expose OnlyNothing just for sake of test.
                        |> Expect.equal (singleton NothingNode)

            , test "of 2 values" <|
                \() ->
                    fromList ["a", "b"]
                        |> BTreeString
                        |> toNothing
                        |> toTaggedNodes -- called because should not expose OnlyNothing just for sake of test.
                        |> Expect.equal (Node NothingNode Empty (singleton NothingNode))
            ]
         , describe "BTreeUniformType.toTaggedNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (Empty) (toTaggedNodes (BTreeInt Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (singleton (IntNode 1)) (toTaggedNodes (BTreeInt (singleton 1)))
            , test "of 2 values" <|
                \() ->
                    Expect.equal (Node (StringNode "a") Empty (singleton (StringNode "b"))) (toTaggedNodes (BTreeString (fromList ["a", "b"])))
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
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeMusicNotePlayer Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toStringLength (BTreeMusicNotePlayer (Node (Just A) Empty (singleton (Just B)))))
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
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeMusicNotePlayer Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.toIsIntPrime (BTreeMusicNotePlayer (Node (Just A) Empty (singleton (Just B)))))
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
                    Expect.equal (BTreeMusicNotePlayer Empty) (BTreeUniformType.incrementNodes 1 (BTreeMusicNotePlayer Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNotePlayer (Node (Just G_sharp) (singleton (Nothing)) Empty))) (BTreeUniformType.incrementNodes 1 (BTreeMusicNotePlayer (Node (Just G) (singleton (Just G_sharp)) Empty)))
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
                    Expect.equal (BTreeMusicNotePlayer Empty) (BTreeUniformType.decrementNodes 1 (BTreeMusicNotePlayer Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNotePlayer (Node (Just A) (singleton (Nothing)) Empty))) (BTreeUniformType.decrementNodes 1 (BTreeMusicNotePlayer (Node (Just A_sharp) (singleton (Just A)) Empty)))
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
                    Expect.equal (BTreeMusicNotePlayer Empty) (BTreeUniformType.decrementNodes 1 (BTreeMusicNotePlayer Empty))
            , test "of 2 BTreeMusicNote" <|
                \() ->
                    Expect.equal ((BTreeMusicNotePlayer (Node (Just A_sharp) (singleton (Just A)) Empty))) (BTreeUniformType.raiseNodes 1 (BTreeMusicNotePlayer (Node (Just A_sharp) (singleton (Just A)) Empty)))
            ]
         , describe "BTreeUniformType.depth"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal 0 (BTreeUniformType.depth (BTreeInt Empty))
            , test "of 2 deep" <|
                \() ->
                    Expect.equal 2 (BTreeUniformType.depth (BTreeString (Node "1" (singleton "2") (singleton "3"))))
            , test "of 3 deep" <|
                \() ->
                    Expect.equal 3 (BTreeUniformType.depth (BTreeInt (Node 1 Empty (Node 2 Empty (singleton 2)))))
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
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeMusicNotePlayer Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumInt (BTreeMusicNotePlayer (Node (Just A) Empty (singleton (Just D)))))
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
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeMusicNotePlayer Empty))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal Nothing (BTreeUniformType.sumString (BTreeMusicNotePlayer (Node (Just A) Empty (singleton (Just D)))))
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
                    Expect.equal (Just (BTreeMusicNotePlayer Empty)) (BTreeUniformType.sort (BTreeMusicNotePlayer Empty))
            , test "of singleton BTreeMusicNote" <|
                \() ->
                    Expect.equal (Just (BTreeMusicNotePlayer (singleton (Just A)))) (BTreeUniformType.sort(BTreeMusicNotePlayer (singleton (Just A))))
            , test "of 2 values BTreeMusicNote" <|
                \() ->
                    Expect.equal (Just (BTreeMusicNotePlayer (Node (Just A) Empty (singleton (Just E))))) (BTreeUniformType.sort (BTreeMusicNotePlayer (Node (Just E) Empty (singleton (Just A)))))
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
                    Expect.equal (BTreeMusicNotePlayer Empty) (BTreeUniformType.removeDuplicates (BTreeMusicNotePlayer Empty))
            , test "of 3 values BTreeMusicNote" <|
                \() ->
                    Expect.equal (BTreeMusicNotePlayer (Node (Just F) (singleton (Just E)) Empty)) (BTreeUniformType.removeDuplicates (BTreeMusicNotePlayer (Node (Just F) (singleton (Just E)) (singleton (Just F)))))
            ]
         , describe "BTreeUniformType.isAllNothing"
            [ test "of empty BTreeString" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (BTreeString Empty))
            , test "of 1 value BTreeString" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing (BTreeString (singleton "a")))
            , test "of empty BTreeInt" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (BTreeInt Empty))
            , test "of 1 value BTreeInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing (BTreeInt (singleton 1)))
            , test "of empty BTreeBool" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (BTreeBool Empty))
            , test "of 1 value BTreeBool" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing (BTreeBool (singleton True)))
            , test "of empty BTreeMusicNote" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (BTreeMusicNotePlayer Empty))
            , test "of 1 value BTreeMusicNote" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing (BTreeMusicNotePlayer (singleton (Just A))))
            , test "of empty BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (BTreeNothing Empty))
            , test "of 1 value BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing (toNothing (BTreeInt (singleton 1))))
            ]
        ]

