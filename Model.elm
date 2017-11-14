module Model exposing (Model)

import Random.Pcg exposing (Seed)
import EveryDict exposing (EveryDict)
import Debouncer exposing (DebouncerState)

import BTreeUniformType exposing (BTreeUniformType)
import BTreeVariedType exposing (BTreeVariedType)
import BTree exposing (Direction, TraversalOrder)
import IntView exposing (IntView)
import DropdownAction exposing (DropdownAction)
import TreePlayerParams exposing (PlaySpeed)
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
    , delta : Int
    , exponent : Int
    , isPlayNotes : Bool
    , isTreeCaching : Bool
    , directionForSort : Direction
    , directionForRandom : Direction
    , intView : IntView
    , uuidSeed : Seed
    , isShowDropdown : EveryDict DropdownAction Bool
    , isMouseEnteredDropdown : EveryDict DropdownAction Bool
    , menuDropdownDebouncer : Debouncer.DebouncerState
    }