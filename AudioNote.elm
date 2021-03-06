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
    , isHarmonize : Bool
    , isLast : Bool
    }


audioNote : Maybe MusicNote -> Maybe Uuid -> Time -> Time -> Bool -> Bool -> Maybe AudioNote
audioNote mbNote mbId startOffsetMsec durationMsec isHarmonize isLast =
    let
        mbFreq = mbNote
            |> Maybe.andThen toFreq

        fn = \(Freq freq) ->
            let
                id = unwrap "" Uuid.toString mbId
                startOffset = inSeconds startOffsetMsec
                duration = inSeconds durationMsec
            in
                 AudioNote
                     freq
                     id
                     startOffset
                     duration
                     isHarmonize
                     isLast
    in
        Maybe.map fn mbFreq


