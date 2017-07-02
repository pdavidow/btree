module AudioNote exposing (AudioNote(..), AudioNote_JS, toJS)

import Time exposing (Time, inSeconds)
import Maybe.Extra exposing (unwrap)
import Uuid exposing (Uuid)

import MusicNote exposing (MusicNote, Freq(..), toFreq)


type AudioNote = AudioNote
    { mbNote : Maybe MusicNote
    , mbId : Maybe Uuid
    , startOffset : Time -- msec
    , duration : Time -- msec
    , isLast : Bool
    }


type alias AudioNote_JS =
    { freq : Float
    , id : String
    , startOffset : Float -- sec
    , duration : Float -- sec
    , isLast : Bool
    }


toJS : AudioNote -> AudioNote_JS
toJS (AudioNote params) =
    let
        (Freq freq) = unwrap (Freq 0.0) toFreq params.mbNote
        id = unwrap "" Uuid.toString params.mbId
        startOffset = inSeconds params.startOffset
        duration = inSeconds params.duration
        isLast = params.isLast
    in
        AudioNote_JS
            freq
            id
            startOffset
            duration
            isLast
