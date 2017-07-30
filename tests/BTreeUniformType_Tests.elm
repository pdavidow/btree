module BTreeUniformType_Tests exposing (..)

import BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, depth, sumInt, sort, deDuplicate, isAllNothing)

import BTree exposing (..) -- todo specify
import NodeTag exposing (NodeTag(..))
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import BTreeVariedType exposing (BTreeVariedType(..))
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt, toMaybeSafeInt)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


musicNotePlayerOnNothing : MusicNotePlayer
musicNotePlayerOnNothing =
   MusicNotePlayer
       { mbNote = Nothing
       , isPlaying = False
       , mbId = Nothing
       }


nothingSingelton : BTreeUniformType
nothingSingelton =
    BTreeUniformType.toNothing <| BTreeInt <| singleton <| toMaybeSafeInt <| 1


nothing3Nodes : BTreeUniformType
nothing3Nodes =
    BTreeUniformType.toNothing <| BTreeInt <| fromIntList [1, 2, 3]


----------------------------------------------------------------------------
-- NOTE:
-- Use singletons to keep things simple.
-- Using fromList can cause re-rodering,
-- and laying out tree structure (with Node) is cumbersome to read.

bTreeUniformType : Test
bTreeUniformType =
    describe "BTreeUniformType module"
         [ describe "BTreeUniformType.toNothing"
            [ test "of toNothing.0" <|
                \() ->
                    Expect.equal (BTreeNothing Empty) (toNothing (BTreeInt Empty))
            , test "of toNothing.1" <|
                \() ->
                    1
                        |> Safe
                        |> BTree.singleton
                        |> BTreeInt
                        |> BTreeUniformType.toNothing
                        |> BTreeUniformType.toTaggedNodes -- called because should not expose OnlyNothing just for sake of test.
                        |> Expect.equal (singleton NothingNode)

            , test "of toNothing.2" <|
                \() ->
                    fromList ["a", "b"]
                        |> BTreeString
                        |> BTreeUniformType.toNothing
                        |> BTreeUniformType.toTaggedNodes -- called because should not expose OnlyNothing just for sake of test.
                        |> Expect.equal (Node NothingNode Empty (singleton NothingNode))
            ]
         , describe "BTreeUniformType.toTaggedNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (List.repeat 5 Empty)
                        (
                            [ BTreeUniformType.toTaggedNodes <| BTreeInt <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeString <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeBool <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.toTaggedNodes <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| IntNode <| Safe 1
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| StringNode <| "a"
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeString <| singleton <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| BoolNode <| Just True
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.toTaggedNodes <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( singleton <| NothingNode
                        )
                        ( BTreeUniformType.toTaggedNodes <| nothingSingelton
                        )
            ]
         , describe "BTreeUniformType.toLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| BTreeInt <| Empty
                            , Just <| BTreeInt <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toLength <| BTreeInt <| Empty
                            , BTreeUniformType.toLength <| BTreeString <| Empty
                            , BTreeUniformType.toLength <| BTreeBool <| Empty
                            , BTreeUniformType.toLength <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.toLength <| BTreeNothing <| Empty
                            ]
                        )
            ,  test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| toMaybeSafeInt <| -12
                        )
            ,  test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| toMaybeSafeInt <| 34567
                        )
            ,  test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.toLength <| BTreeInt <| singleton <| toMaybeSafeInt <| maxSafeInt + 1
                        )
            ,  test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| Safe 2
                        )
                        ( BTreeUniformType.toLength <| BTreeString <| singleton <| "ab"
                        )
            ,  test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeInt <| singleton <| Safe 5
                        )
                        ( BTreeUniformType.toLength <| BTreeString <| singleton <| "cdefg"
                        )
            ,  test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| BTreeBool <| singleton <| Just True
                        )
            ,  test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toLength <| nothingSingelton
                        )
            ]
         , describe "BTreeUniformType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| BTreeBool <| Empty
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.toIsIntPrime <| BTreeInt <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeString <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeBool <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.toIsIntPrime <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| toMaybeSafeInt <| maxSafeInt + 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeInt <| singleton <| toMaybeSafeInt <| 13
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeString <| singleton <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.toIsIntPrime <| nothingSingelton
                        )
            ]
        , describe "BTreeUniformType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.incrementNodes 1 <| BTreeInt <| Empty
                            , BTreeUniformType.incrementNodes 1 <| BTreeString <| Empty
                            , BTreeUniformType.incrementNodes 1 <| BTreeBool <| Empty
                            , BTreeUniformType.incrementNodes 1 <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.incrementNodes 1 <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 4
                        )
                        ( BTreeUniformType.incrementNodes -3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 1
                        )
                        ( BTreeUniformType.incrementNodes 0 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 4
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| maxSafeInt - 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe <| negate <| maxSafeInt - 3
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "a3"
                        )
                        ( BTreeUniformType.incrementNodes -3 <| BTreeString <| singleton <| "a"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "a0"
                        )
                        ( BTreeUniformType.incrementNodes 0 <| BTreeString <| singleton <| "a"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "a3"
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeString <| singleton <| "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.incrementNodes -3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.incrementNodes 0 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.incrementNodes 3 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.incrementNodes 8 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.incrementNodes 8 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.incrementNodes -1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G
                        )
                        ( BTreeUniformType.incrementNodes 0 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.incrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.incrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.incrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.incrementNodes -1 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.incrementNodes 0 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.incrementNodes 1 <| nothingSingelton
                        )
            ]
        , describe "BTreeUniformType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.decrementNodes 1 <| BTreeInt <| Empty
                            , BTreeUniformType.decrementNodes 1 <| BTreeString <| Empty
                            , BTreeUniformType.decrementNodes 1 <| BTreeBool <| Empty
                            , BTreeUniformType.decrementNodes 1 <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.decrementNodes 1 <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe -2
                        )
                        ( BTreeUniformType.decrementNodes -3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 1
                        )
                        ( BTreeUniformType.decrementNodes 0 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe -2
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 1
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| maxSafeInt + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe <| negate <| maxSafeInt
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "ab"
                        )
                        ( BTreeUniformType.decrementNodes -3 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "abcde"
                        )
                        ( BTreeUniformType.decrementNodes 0 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "ab"
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| ""
                        )
                        ( BTreeUniformType.decrementNodes -3 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "AB"
                        )
                        ( BTreeUniformType.decrementNodes 0 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| ""
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.decrementNodes -3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.decrementNodes 0 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.decrementNodes 3 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.decrementNodes 8 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.decrementNodes 8 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.decrementNodes -1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.decrementNodes 0 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.decrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.decrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.decrementNodes 1 <| BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.decrementNodes -1 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.decrementNodes 0 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.decrementNodes 1 <| nothingSingelton
                        )
            ]
        , describe "BTreeUniformType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt <| Empty
                            , BTreeString <| Empty
                            , BTreeBool <| Empty
                            , BTreeMusicNotePlayer <| Empty
                            , BTreeNothing <| Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.raiseNodes 2 <| BTreeInt <| Empty
                            , BTreeUniformType.raiseNodes 2 <| BTreeString <| Empty
                            , BTreeUniformType.raiseNodes 2 <| BTreeBool <| Empty
                            , BTreeUniformType.raiseNodes 2 <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.raiseNodes 2 <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 8
                        )
                        ( BTreeUniformType.raiseNodes -3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 1
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeInt <| singleton <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 8
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| 2
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| maxSafeInt + 2
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Unsafe
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt + 2
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( BTreeInt <| singleton <| Safe 1
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeInt <| singleton <| toMaybeSafeInt <| negate <| maxSafeInt - 3
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "abcde"
                        )
                        ( BTreeUniformType.raiseNodes -3 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "abcde"
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.3" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "abcde"
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeString <| singleton <| "abcde"
                        )
            , test "of non-empty.BTreeString.4" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "AB"
                        )
                        ( BTreeUniformType.raiseNodes -3 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeString.5" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "AB"
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeString.6" <|
                \() ->
                    Expect.equal
                        ( BTreeString <| singleton <| "AB"
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeString <| singleton <| "AB"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.raiseNodes -3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.2" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.3" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.4" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.raiseNodes 3 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeBool.5" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just True
                        )
                        ( BTreeUniformType.raiseNodes 8 <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeBool.6" <|
                \() ->
                    Expect.equal
                        ( BTreeBool <| singleton <| Just False
                        )
                        ( BTreeUniformType.raiseNodes 8 <| BTreeBool <| singleton <| Just False
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.raiseNodes -2 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.2" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.raiseNodes 0 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.3" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
                        ( BTreeUniformType.raiseNodes 2 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeMusicNotePlayer.4" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeUniformType.raiseNodes 2 <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on G_sharp
                        )
            , test "of non-empty.BTreeMusicNotePlayer.5" <|
                \() ->
                    Expect.equal
                        ( BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
                        ( BTreeUniformType.raiseNodes 2 <| BTreeMusicNotePlayer <| singleton <| musicNotePlayerOnNothing
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.raiseNodes -2 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.2" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.raiseNodes 0 <| nothingSingelton
                        )
            , test "of non-empty.BTreeNothing.3" <|
                \() ->
                    Expect.equal
                        ( nothingSingelton
                        )
                        ( BTreeUniformType.raiseNodes 2 <| nothingSingelton
                        )
            ]
         , describe "BTreeUniformType.depth"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ 0
                            , 0
                            , 0
                            , 0
                            , 0
                            ]
                        )
                        (
                            [ BTreeUniformType.depth <| BTreeInt <| Empty
                            , BTreeUniformType.depth <| BTreeString <| Empty
                            , BTreeUniformType.depth <| BTreeBool <| Empty
                            , BTreeUniformType.depth <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.depth <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( 3
                        )
                        ( BTreeUniformType.depth <| BTreeInt <| BTree.fromIntList [40, 50, 60]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( 4
                        )
                        ( BTreeUniformType.depth <| BTreeString <| BTree.fromList ["a", "b", "c", "d"]
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniformType.depth <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( 2
                        )
                        ( BTreeUniformType.depth <| BTreeMusicNotePlayer <| BTree.fromListBy toString [MusicNotePlayer.on A, MusicNotePlayer.on A]
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( 1
                        )
                        ( BTreeUniformType.depth <| nothingSingelton
                        )
            ]
         , describe "BTreeUniformType.sumInt"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| Safe 0
                            , Nothing
                            , Nothing
                            , Nothing
                            , Nothing
                            ]
                        )
                        (
                            [ BTreeUniformType.sumInt <| BTreeInt <| Empty
                            , BTreeUniformType.sumInt <| BTreeString <| Empty
                            , BTreeUniformType.sumInt <| BTreeBool <| Empty
                            , BTreeUniformType.sumInt <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.sumInt <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe -10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [40, -50]
                        )
            , test "of non-empty.BTreeInt.2" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| maxSafeInt - 10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt - 40, 30]
                        )
            , test "of non-empty.BTreeInt.3" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| negate <| maxSafeInt - 10
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [negate <| maxSafeInt - 40, -30]
                        )
            , test "of non-empty.BTreeInt.4" <|
                \() ->
                    Expect.equal
                        ( Just <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt - 40, 30, 20]
                        )
            , test "of non-empty.BTreeInt.5" <|
                \() ->
                    Expect.equal
                        ( Just <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [-100, maxSafeInt + 1]
                        )
            , test "of non-empty.BTreeInt.6" <|
                \() ->
                    Expect.equal
                        ( Just <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt - 40, 50, -20]
                        )
            , test "of non-empty.BTreeInt.6.1" <|
                \() ->
                    Expect.equal
                        ( Just <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt, 50, -40, -20]
                        )
            , test "of non-empty.BTreeInt.6.1.1" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [-9, 4, 4, maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.6.1.2" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt, -9, 4, 4]
                        )
            , test "of non-empty.BTreeInt.6.1.3" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [-1, maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.6.1.4" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe <| maxSafeInt - 1
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt, -1]
                        )
            , test "of non-empty.BTreeInt.6.2" <|
                \() ->
                    Expect.equal
                        ( Just <| Unsafe
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| Node (toMaybeSafeInt maxSafeInt) (singleton <| toMaybeSafeInt 40) (Node (toMaybeSafeInt -90) Empty (singleton <| toMaybeSafeInt 40))
                        )
            , test "of non-empty.BTreeInt.7" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe 0
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt, negate maxSafeInt]
                        )
            , test "of non-empty.BTreeInt.8" <|
                \() ->
                    Expect.equal
                        ( Just <| Safe maxSafeInt
                        )
                        ( BTreeUniformType.sumInt <| BTreeInt <| BTree.fromIntList [maxSafeInt]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeString <| singleton "a"
                        )
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeBool <| singleton <| Just True
                        )
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| BTreeMusicNotePlayer <| singleton <| MusicNotePlayer.on A
                        )
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal
                        ( Nothing
                        )
                        ( BTreeUniformType.sumInt <| nothingSingelton
                        )
            ]
         , describe "BTreeUniformType.sort"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ Just <| BTreeInt Empty
                            , Just <| BTreeString Empty
                            , Just <| BTreeBool Empty
                            , Just <| BTreeMusicNotePlayer Empty
                            , Just <| BTreeNothing Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.sort <| BTreeInt <| Empty
                            , BTreeUniformType.sort <| BTreeString <| Empty
                            , BTreeUniformType.sort <| BTreeBool <| Empty
                            , BTreeUniformType.sort <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.sort <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal (Just <| BTreeInt <| Node (Safe 1) Empty (singleton <| Safe 2)) (BTreeUniformType.sort <| BTreeInt <| Node (Safe 2) Empty (singleton <| Safe 1))
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal (Just <| BTreeString <| Node "a" Empty (singleton "b")) (BTreeUniformType.sort <| BTreeString <| Node "b" Empty (singleton "a"))
            , test "of non-empty.BTreeString.2" <|
                \() ->
                    Expect.equal (Just <| BTreeString <| Node "a" Empty (Node "b" Empty (singleton "b"))) (BTreeUniformType.sort <| BTreeString <| Node "b" Empty (Node "a" Empty (singleton "b")))
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal (Just <| BTreeBool <| Node (Just False) Empty (singleton <| Just True)) (BTreeUniformType.sort <| BTreeBool <| Node (Just True) Empty (singleton <| Just False))
            , test "of non-empty.BTreeMusicNote.1" <|
                \() ->
                    Expect.equal (Just <| BTreeMusicNotePlayer <| Node (MusicNotePlayer.on A) Empty (singleton (MusicNotePlayer.on E))) (BTreeUniformType.sort <| BTreeMusicNotePlayer <| Node (MusicNotePlayer.on E) Empty (singleton (MusicNotePlayer.on A)))
            , test "of non-empty.BTreeNothing.1" <|
                \() ->
                    Expect.equal (Just nothing3Nodes) (BTreeUniformType.sort nothing3Nodes)
            ]
         , describe "BTreeUniformType.deDuplicate"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ BTreeInt Empty
                            , BTreeString Empty
                            , BTreeBool Empty
                            , BTreeMusicNotePlayer Empty
                            , BTreeNothing Empty
                            ]
                        )
                        (
                            [ BTreeUniformType.deDuplicate <| BTreeInt <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeString <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeBool <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.deDuplicate <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeString.1" <|
                \() ->
                    Expect.equal (BTreeString (Node "a" Empty (singleton "b"))) (BTreeUniformType.deDuplicate (BTreeString (Node "a" (singleton "b") (singleton "a"))))
            , test "of non-empty.BTreeInt.1" <|
                \() ->
                    Expect.equal (BTreeInt (Node (Safe 1) Empty (singleton <| Safe 2))) (BTreeUniformType.deDuplicate (BTreeInt (Node (Safe 1) (singleton <| Safe 2) (singleton <| Safe 1))))
            , test "of non-empty.BTreeBool.1" <|
                \() ->
                    Expect.equal (BTreeBool (Node (Just True) (singleton <| Just False) Empty)) (BTreeUniformType.deDuplicate (BTreeBool (Node (Just True) (singleton <| Just False) (singleton <| Just True))))
            , test "of non-empty.BTreeMusicNotePlayer.1" <|
                \() ->
                    Expect.equal (BTreeMusicNotePlayer (Node (MusicNotePlayer.on F) (singleton (MusicNotePlayer.on E)) Empty)) (BTreeUniformType.deDuplicate (BTreeMusicNotePlayer (Node (MusicNotePlayer.on F) (singleton (MusicNotePlayer.on E)) (singleton (MusicNotePlayer.on F)))))
            ]
         , describe "BTreeUniformType.isAllNothing"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        (
                            [ True
                            , True
                            , True
                            , True
                            , True
                            ]
                        )
                        (
                            [ BTreeUniformType.isAllNothing <| BTreeInt <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeString <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeBool <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeMusicNotePlayer <| Empty
                            , BTreeUniformType.isAllNothing <| BTreeNothing <| Empty
                            ]
                        )
            , test "of non-empty.BTreeInt" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeInt <| singleton <| Safe 1)
            , test "of non-empty.BTreeString" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeString <| singleton "a")
            , test "of non-empty.BTreeBool" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeBool <| singleton <| Just True)
            , test "of non-empty.BTreeMusicNotePlayer" <|
                \() ->
                    Expect.equal False (BTreeUniformType.isAllNothing <| BTreeMusicNotePlayer <| singleton (MusicNotePlayer.on A))
            , test "of non-empty.BTreeNothing" <|
                \() ->
                    Expect.equal True (BTreeUniformType.isAllNothing nothing3Nodes)
            ]
        ]

