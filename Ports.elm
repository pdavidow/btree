port module Ports exposing (..)

import Time exposing (Time)
import AudioNote exposing (AudioNote_JS)


port port_playNote : AudioNote_JS -> Cmd msg
port port_startPlayNote : (String -> msg) -> Sub msg
port port_donePlayNote : (String -> msg) -> Sub msg
port port_donePlayNotes : (Bool -> msg) -> Sub msg


