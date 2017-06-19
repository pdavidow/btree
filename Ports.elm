port module Ports exposing (..)

import Time exposing (Time)
import AudioNote exposing (AudioNote)


port port_playNote : AudioNote -> Cmd msg


port port_announceOnDonePlayNotes
    :  Time -- msec
    -> Cmd msg


port port_donePlayNotes : (Bool -> msg) -> Sub msg


