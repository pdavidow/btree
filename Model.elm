module Model exposing (Model)

import Random.Pcg exposing (Seed)
import EveryDict exposing (EveryDict)

import BTreeUniformType exposing (BTreeUniformType)
import BTreeVariedType exposing (BTreeVariedType)
import BTree exposing (Direction, TraversalOrder)
import IntView exposing (IntView)
import TreePlayerParams exposing (PlaySpeed)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle)
------------------------------------------------

type alias Model =
    { intTree : BTreeUniformType
    , bigIntTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , initialMusicNoteTree : BTreeUniformType
    , musicNoteTree : BTreeUniformType
    , variedTree : BTreeVariedType
    , intTreeCache : BTreeUniformType
    , bigIntTreeCache : BTreeUniformType
    , stringTreeCache : BTreeUniformType
    , boolTreeCache : BTreeUniformType
    , musicNoteTreeCache : BTreeUniformType
    , variedTreeCache : BTreeVariedType
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