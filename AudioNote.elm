module AudioNote exposing (AudioNote)

import Time exposing (Time)


type alias AudioNote =
    { freq : Float
    , startOffset : Time -- sec
    , stopOffset : Time -- sec
    , onEnded : Maybe Bool
    }
