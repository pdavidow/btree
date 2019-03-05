module MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter, isPlayable, toFreq, toFreqString)

import Uuid exposing (Uuid)
import Maybe.Extra exposing (isJust, unwrap)

import MusicNote exposing (Freq(..), MusicNote, MidiNumber)
import UniversalConstants exposing (nothingString)

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


sorter : MusicNotePlayer -> Int
sorter (MusicNotePlayer params) =
    MusicNote.mbSorter params.mbNote


isPlayable : MusicNotePlayer -> Bool
isPlayable (MusicNotePlayer params) =
    Maybe.Extra.isJust params.mbNote


toFreq : MusicNotePlayer -> Maybe Freq    
toFreq (MusicNotePlayer params) =
    params.mbNote 
        |> Maybe.andThen MusicNote.toFreq


toFreqString : MusicNotePlayer -> String
toFreqString x =
    unwrap nothingString (\(Freq n) -> Basics.toString n ++ " hz") <| toFreq x 