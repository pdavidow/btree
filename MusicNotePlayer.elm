module MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter, isPlayable)

import Uuid exposing (Uuid)
import Maybe.Extra exposing (isJust)

import MusicNote exposing (MusicNote)


type MusicNotePlayer = MusicNotePlayer
    { mbNote : Maybe MusicNote
    , isPlaying : Bool
    , mbId : Maybe Uuid
    }


on : Maybe MusicNote -> MusicNotePlayer
on mbNote =
    idedOn Nothing mbNote


idedOn : Maybe Uuid -> Maybe MusicNote -> MusicNotePlayer
idedOn mbId mbNote =
   MusicNotePlayer
       { mbNote = mbNote
       , isPlaying = False
       , mbId = mbId
       }


sorter : MusicNotePlayer -> String
sorter (MusicNotePlayer params) =
    MusicNote.mbSorter params.mbNote


isPlayable : MusicNotePlayer -> Bool
isPlayable (MusicNotePlayer params) =
    Maybe.Extra.isJust params.mbNote