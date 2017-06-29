module MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter)

import Uuid

import MusicNote exposing (MusicNote)


type MusicNotePlayer = MusicNotePlayer
    { mbNote : Maybe MusicNote
    , isPlaying : Bool
    , mbId: Maybe Uuid.Uuid
    }


on : Maybe MusicNote -> MusicNotePlayer
on mbNote =
    idedOn Nothing mbNote


idedOn : Maybe Uuid.Uuid -> Maybe MusicNote -> MusicNotePlayer
idedOn mbId mbNote =
   MusicNotePlayer
       { mbNote = mbNote
       , isPlaying = False
       , mbId = mbId
       }


sorter : MusicNotePlayer -> String
sorter (MusicNotePlayer params) =
    MusicNote.mbSorter params.mbNote