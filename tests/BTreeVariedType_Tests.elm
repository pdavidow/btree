module BTreeVariedType_Tests exposing (..)

import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, deDuplicate, hasAnyIntNodes)

import BTree exposing (..) -- todo specify
import NodeTag exposing (NodeTag(..))
import MusicNote exposing (MusicNote(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
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


----------------------------------------------------------------------------

bTreeVariedType : Test
bTreeVariedType =
    describe "BTreeVariedType module"
         [ describe "BTreeVariedType.toLength"
            [ test "of empty" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried Empty
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried Empty
                        )
            ,  test "of non-empty.IntNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 2
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt -12
                        )
            ,  test "of non-empty.IntNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 5
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt 34567
                        )
            ,  test "of non-empty.IntNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| maxSafeInt + 1
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 2
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| StringNode "ab"
                        )
            ,  test "of non-empty.StringNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 5
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| StringNode "cdefg"
                        )
            ,  test "of non-empty.BoolNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.MusicNoteNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.NothingNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toLength <| BTreeVaried <| singleton <| NothingNode
                        )
            ]
         , describe "BTreeVariedType.toIsIntPrime"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.toIsIntPrime (BTreeVaried Empty))
            ,  test "of non-empty.IntNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Nothing
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| maxSafeInt + 1
                        )
            ,  test "of non-empty.IntNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| negate <| maxSafeInt
                        )
            ,  test "of non-empty.IntNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 13
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.BoolNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.MusicNoteNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.NothingNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.toIsIntPrime <| BTreeVaried <| singleton <| NothingNode
                        )
            ]
         , describe "BTreeVariedType.incrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.incrementNodes 1 (BTreeVaried Empty))
            ,  test "of non-empty.IntNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 4
                        )
                        ( BTreeVariedType.incrementNodes -3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 1
                        )
                        ( BTreeVariedType.incrementNodes 0 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 4
                        )
                        ( BTreeVariedType.incrementNodes 1 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 3
                        )
            ,  test "of non-empty.IntNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.incrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.incrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| negate <| maxSafeInt + 2
                        )
            ,  test "of non-empty.IntNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe <| negate <| maxSafeInt - 3
                        )
                        ( BTreeVariedType.incrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| negate <| maxSafeInt
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a3"
                        )
                        ( BTreeVariedType.incrementNodes -3 <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.StringNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a0"
                        )
                        ( BTreeVariedType.incrementNodes 0 <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.StringNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a3"
                        )
                        ( BTreeVariedType.incrementNodes 3 <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.BoolNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.incrementNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.incrementNodes 0 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.incrementNodes 3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.incrementNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.BoolNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.incrementNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.incrementNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.MusicNoteNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeVariedType.incrementNodes -1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G
                        )
                        ( BTreeVariedType.incrementNodes 0 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G_sharp
                        )
                        ( BTreeVariedType.incrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G
                        )
            ,  test "of non-empty.MusicNoteNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.incrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on G_sharp
                        )
            ,  test "of non-empty.MusicNoteNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.incrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.incrementNodes -1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.incrementNodes 0 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.incrementNodes 1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ]
         , describe "BTreeVariedType.decrementNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.decrementNodes 1 (BTreeVaried Empty))
            ,  test "of non-empty.IntNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe -2
                        )
                        ( BTreeVariedType.decrementNodes -3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 1
                        )
                        ( BTreeVariedType.decrementNodes 0 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 1
                        )
            ,  test "of non-empty.IntNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 4
                        )
                        ( BTreeVariedType.decrementNodes 1 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 5
                        )
            ,  test "of non-empty.IntNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| maxSafeInt + 2
                        )
            ,  test "of non-empty.IntNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe <| maxSafeInt - 3
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt maxSafeInt
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode ""
                        )
                        ( BTreeVariedType.decrementNodes -1 <| BTreeVaried <| singleton <| StringNode ""
                        )
            ,  test "of non-empty.StringNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a"
                        )
                        ( BTreeVariedType.decrementNodes 0 <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.StringNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode ""
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| StringNode "abc"
                        )
            ,  test "of non-empty.StringNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a"
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| StringNode "abcd"
                        )
            ,  test "of non-empty.StringNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "ab"
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| StringNode "abcde"
                        )
            ,  test "of non-empty.BoolNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.decrementNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.decrementNodes 0 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.decrementNodes 3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.decrementNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.BoolNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.decrementNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.decrementNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.MusicNoteNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.decrementNodes -1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A_sharp
                        )
                        ( BTreeVariedType.decrementNodes 0 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.decrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A_sharp
                        )
            ,  test "of non-empty.MusicNoteNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.decrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.decrementNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.decrementNodes -1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.decrementNodes 0 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.decrementNodes 1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ]
         , describe "BTreeVariedType.raiseNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.raiseNodes 1 (BTreeVaried Empty))
            ,  test "of non-empty.IntNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 8
                        )
                        ( BTreeVariedType.raiseNodes -3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 1
                        )
                        ( BTreeVariedType.raiseNodes 0 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe 8
                        )
                        ( BTreeVariedType.raiseNodes 3 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| 2
                        )
            ,  test "of non-empty.IntNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe <| negate <| maxSafeInt - 2
                        )
                        ( BTreeVariedType.raiseNodes 1 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| negate <| maxSafeInt - 2
                        )
            ,  test "of non-empty.IntNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Safe <| maxSafeInt
                        )
                        ( BTreeVariedType.raiseNodes 1 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt <| maxSafeInt
                        )
            ,  test "of non-empty.IntNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| IntNode <| Unsafe
                        )
                        ( BTreeVariedType.raiseNodes 2 <| BTreeVaried <| singleton <| IntNode <| toMaybeSafeInt maxSafeInt
                        )
            ,  test "of non-empty.StringNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode ""
                        )
                        ( BTreeVariedType.raiseNodes -1 <| BTreeVaried <| singleton <| StringNode ""
                        )
            ,  test "of non-empty.StringNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "a"
                        )
                        ( BTreeVariedType.raiseNodes 0 <| BTreeVaried <| singleton <| StringNode "a"
                        )
            ,  test "of non-empty.StringNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "abc"
                        )
                        ( BTreeVariedType.raiseNodes 3 <| BTreeVaried <| singleton <| StringNode "abc"
                        )
            ,  test "of non-empty.StringNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| StringNode "abcd"
                        )
                        ( BTreeVariedType.raiseNodes 3 <| BTreeVaried <| singleton <| StringNode "abcd"
                        )
            ,  test "of non-empty.BoolNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.raiseNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.raiseNodes 0 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.raiseNodes 3 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.raiseNodes -3 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.BoolNode.5" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just True
                        )
                        ( BTreeVariedType.raiseNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just True
                        )
            ,  test "of non-empty.BoolNode.6" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| BoolNode <| Just False
                        )
                        ( BTreeVariedType.raiseNodes 8 <| BTreeVaried <| singleton <| BoolNode <| Just False
                        )
            ,  test "of non-empty.MusicNoteNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.raiseNodes -1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.raiseNodes 0 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
                        ( BTreeVariedType.raiseNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| MusicNotePlayer.on A
                        )
            ,  test "of non-empty.MusicNoteNode.4" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
                        ( BTreeVariedType.raiseNodes 1 <| BTreeVaried <| singleton <| MusicNoteNode <| musicNotePlayerOnNothing
                        )
            ,  test "of non-empty.NothingNode.1" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.raiseNodes -1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.2" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.raiseNodes 0 <| BTreeVaried <| singleton <| NothingNode
                        )
            ,  test "of non-empty.NothingNode.3" <|
                \() ->
                    Expect.equal
                        ( BTreeVaried <| singleton <| NothingNode
                        )
                        ( BTreeVariedType.raiseNodes 1 <| BTreeVaried <| singleton <| NothingNode
                        )
            ]
         , describe "BTreeVariedType.deDuplicate"
            [ test "of empty" <|
                \() ->
                    Expect.equal (BTreeVaried Empty) (BTreeVariedType.deDuplicate (BTreeVaried Empty))
            , test "of singleton" <|
                \() ->
                    Expect.equal (BTreeVaried <| singleton (IntNode <| Safe 2)) (BTreeVariedType.deDuplicate (BTreeVaried (singleton (IntNode <| Safe 2))))
            , test "of StringNode A, MusicNoteNode... A" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (StringNode "A") (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (StringNode "A") (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty))
            , test "of IntNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (IntNode <| Safe 2) Empty (singleton <| IntNode Unsafe)) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (IntNode <| Safe 2) (singleton <| IntNode <| Safe 2) (Node (IntNode Unsafe) (singleton <| IntNode Unsafe) Empty)))
            , test "of StringNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (StringNode "B") (singleton (StringNode "A")) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (StringNode "B") (singleton (StringNode "B")) (singleton (StringNode "A"))))
            , test "of BoolNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (BoolNode <| Just True) (singleton <| BoolNode <| Just False) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (BoolNode <| Just True) (singleton <| BoolNode <| Just True) (singleton <| BoolNode <| Just False)))
            , test "of MusicNoteNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| Node (MusicNoteNode (MusicNotePlayer.on B)) (singleton (MusicNoteNode (MusicNotePlayer.on A))) Empty) (BTreeVariedType.deDuplicate (BTreeVaried <| Node (MusicNoteNode (MusicNotePlayer.on B)) (singleton (MusicNoteNode (MusicNotePlayer.on B))) (singleton (MusicNoteNode (MusicNotePlayer.on A)))))
            , test "of NothingNode" <|
                \() ->
                     Expect.equal (BTreeVaried <| singleton NothingNode) (BTreeVariedType.deDuplicate (BTreeVaried <| Node NothingNode (singleton NothingNode) (singleton NothingNode)))
            ]
         , describe "BTreeVariedType.hasAnyIntNodes"
            [ test "of empty" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried Empty))
            , test "of singleton IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| singleton <| IntNode <| Safe 2))
            , test "of 4 values, including IntNode" <|
                \() ->
                    Expect.equal True (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| Node (StringNode "abcde") (singleton <| IntNode <| Safe 2) (Node (MusicNoteNode <| MusicNotePlayer.on E) (singleton <| BoolNode <| Just True) Empty)))
            , test "of 4 values, not including IntNode" <|
                \() ->
                    Expect.equal False (BTreeVariedType.hasAnyIntNodes (BTreeVaried <| Node (StringNode "abcde") (singleton <| BoolNode <| Just False) (Node (MusicNoteNode <| MusicNotePlayer.on E) (singleton <| BoolNode <| Just True) Empty)))
            ]
        ]
