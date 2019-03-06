module Msg exposing (Msg(..))

import BTree exposing (Direction, TraversalOrder)
import NodeTag exposing (NodeVariety, IntNode, BigIntNode, StringNode, BoolNode, MusicNoteNode)
import NodeValueOperation exposing (Operation)
import MusicNote exposing (MusicNote)
import IntView exposing (IntView)
import TreePlayerParams exposing (PlaySpeed)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle)
------------------------------------------------

type Msg
    = NodeValueOperate (Operation)
    | SortUniformTrees
    | RemoveDuplicates
    | Delta String
    | Exponent String
    | RequestRandomTrees
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
    | TogglePlayNotes
    | ChangePlaySpeed (PlaySpeed)
    | ChangeTraversalOrder (TraversalOrder)
    | ChangeSortDirection (Direction)
    | ChangeTreeRandomInsertStyle (TreeRandomInsertStyle)
    | StartPlayNote (String)
    | DonePlayNote (String)
    | DonePlayNotes (())
    | SwitchToIntView (IntView)
    | ToggleHarmonize
    | Reset
    | PTriangleDepth String
