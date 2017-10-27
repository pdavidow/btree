module Msg exposing (Msg(..))

import Debouncer exposing (DebouncerState)

import BTree exposing (Direction, TraversalOrder)
import NodeTag exposing (NodeVariety, IntNode, BigIntNode, StringNode, BoolNode, MusicNoteNode)
import NodeValueOperation exposing (Operation)
import MusicNote exposing (MusicNote)
import IntView exposing (IntView)
import DropdownAction exposing (DropdownAction)
------------------------------------------------

type Msg
    = NodeValueOperate (Operation)
    | SortUniformTrees (Direction)
    | RemoveDuplicates
    | Delta String
    | Exponent String
    | RequestRandomTrees (Direction)
    | RequestRandomTreesWithRandomInsertDirection
    | ReceiveRandomTreeMusicNotes (List MusicNote)
    | ReceiveRandomIntNodes (List IntNode)
    | ReceiveRandomBigIntNodes (List BigIntNode)
    | ReceiveRandomStringNodes (List StringNode)
    | ReceiveRandomBoolNodes (List BoolNode)
    | ReceiveRandomNodeVarieties (List NodeVariety)
    | ReceiveRandomTuplesOfMusicNote_Direction (List (MusicNote, Direction))
    | ReceiveRandomTuplesOfIntNode_Direction (List (IntNode, Direction))
    | ReceiveRandomTuplesOfBigIntNode_Direction (List (BigIntNode, Direction))
    | ReceiveRandomTuplesOfStringNode_Direction (List (StringNode, Direction))
    | ReceiveRandomTuplesOfBoolNode_Direction (List (BoolNode, Direction))
    | ReceiveRandomTuplesOfNodeVariety_Direction (List (NodeVariety, Direction))
    | RequestRandomScalars
    | ReceiveRandomDelta (Int)
    | ReceiveRandomExponent (Int)
    | StartShowLength
    | StopShowLength
    | StartShowIsIntPrime
    | StopShowIsIntPrime
    | PlayNotes (TraversalOrder)
    | StartPlayNote (String)
    | DonePlayNote (String)
    | DonePlayNotes (())
    | StopPlayNotes
    | SwitchToIntView (IntView)

    | MouseEnteredButton (DropdownAction)
    | MouseLeftButton (DropdownAction)
    | MouseEnteredDropdown (DropdownAction)
    | CheckIfMouseEnteredDropdown (DropdownAction)
    | MouseLeftDropdown (DropdownAction)

    | DebouncerSelfMsg (Debouncer.SelfMsg Msg)
    | Reset
