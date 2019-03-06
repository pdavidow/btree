module Model exposing (Model)

import Random.Pcg exposing (Seed)

import BTreeUniform exposing (BTreeUniform, IntTree, BigIntTree, StringTree, BoolTree, MusicNotePlayerTree, NothingTree)
import BTreeVaried exposing (BTreeVaried)
import BTree exposing (Direction, TraversalOrder)
import IntView exposing (IntView)
import TreePlayerParams exposing (PlaySpeed)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle)

import Ptrian exposing (Ptrian)
------------------------------------------------

type alias Model =
    { intTree : IntTree
    , bigIntTree : BigIntTree
    , stringTree : StringTree
    , boolTree : BoolTree
    , initialMusicNoteTree : MusicNotePlayerTree
    , musicNoteTree : MusicNotePlayerTree
    , variedTree : BTreeVaried

    , intTreeMorph : BTreeUniform
    , bigIntTreeMorph : BTreeUniform
    , stringTreeMorph : BTreeUniform
    , boolTreeMorph : BTreeUniform
    , musicNoteTreeMorph : BTreeUniform
    , variedTreeCache : BTreeVaried

    , masterPlaySpeed : PlaySpeed
    , masterTraversalOrder : TraversalOrder
    , delta : Int
    , exponent : Int
    , isHarmonize : Bool
    , isPlayNotes : Bool
    , isTreeMorphing : Bool
    , directionForSort : Direction
    , treeRandomInsertStyle : TreeRandomInsertStyle
    , intView : IntView
    , uuidSeed : Seed

    , pTriangleDepth : Int
    }