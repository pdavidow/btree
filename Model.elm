module Model exposing (Model)

import Random.Pcg exposing (Seed)
import EveryDict exposing (EveryDict)

import BTreeUniformType exposing (BTreeUniform, IntTree, BigIntTree, StringTree, BoolTree, MusicNotePlayerTree, NothingTree)
import BTreeVariedType exposing (BTreeVaried)
import BTree exposing (Direction, TraversalOrder)
import IntView exposing (IntView)
import TreePlayerParams exposing (PlaySpeed)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle)
------------------------------------------------

type alias Model =
    { intTree : IntTree
    , bigIntTree : BigIntTree
    , stringTree : StringTree
    , boolTree : BoolTree
    , initialMusicNoteTree : MusicNotePlayerTree
    , musicNoteTree : MusicNotePlayerTree
    , variedTree : BTreeVaried
    , intTreeCache : IntTree
    , bigIntTreeCache : BigIntTree
    , stringTreeCache : StringTree
    , boolTreeCache : BoolTree
    , musicNoteTreeCache : MusicNotePlayerTree
    , variedTreeCache : BTreeVaried
    , masterPlaySpeed : PlaySpeed
    , masterTraversalOrder : TraversalOrder
    , delta : Int
    , exponent : Int
    , isPlayNotes : Bool
    , isTreeCaching : Bool
    , directionForSort : Direction
    , treeRandomInsertStyle : TreeRandomInsertStyle
    , intView : IntView
    , uuidSeed : Seed
    }