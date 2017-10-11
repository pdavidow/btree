module MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter, isPlayable)

import Uuid exposing (Uuid)
import Maybe.Extra exposing (isJust)

import MusicNote exposing (MusicNote, MidiNumber)


type MusicNotePlayer = MusicNotePlayer
    { mbNote : Maybe MusicNote
    , isPlaying : Bool
    , mbId : Maybe Uuid
    }


on : MusicNote -> MusicNotePlayer
on note =
    idedOn Nothing note


idedOn : Maybe Uuid -> MusicNote -> MusicNotePlayer
idedOn mbId note =
   MusicNotePlayer
       { mbNote = Just note
       , isPlaying = False
       , mbId = mbId
       }


sorter : MusicNotePlayer -> MidiNumber
sorter (MusicNotePlayer params) =
    MusicNote.mbSorter params.mbNote


isPlayable : MusicNotePlayer -> Bool
isPlayable (MusicNotePlayer params) =
    Maybe.Extra.isJust params.mbNote