module AudioNote exposing (AudioNote, audioNote)

import Time exposing (Time, inSeconds)
import Maybe.Extra exposing (unwrap)
import Uuid exposing (Uuid)

import MusicNote exposing (MusicNote, Freq(..), toFreq)


type alias AudioNote =
    { freq : Float
    , id : String
    , startOffset : Float -- sec
    , duration : Float -- sec
    , isLast : Bool
    }


audioNote : Maybe MusicNote -> Maybe Uuid -> Time -> Time -> Bool -> AudioNote
audioNote mbNote mbId startOffsetMsec durationMsec isLast =
    let
        (Freq freq) = unwrap (Freq 0.0) toFreq mbNote
        id = unwrap "" Uuid.toString mbId
        startOffset = inSeconds startOffsetMsec
        duration = inSeconds durationMsec
    in
        AudioNote freq id startOffset duration isLast
