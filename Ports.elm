port module Ports exposing (..)

import Time exposing (Time)
import AudioNote exposing (AudioNote)


port port_playNote : AudioNote -> Cmd msg
port port_disconnectAll : () -> Cmd msg
port port_startPlayNote : (String -> msg) -> Sub msg
port port_donePlayNote : (String -> msg) -> Sub msg
port port_donePlayNotes : (() -> msg) -> Sub msg


