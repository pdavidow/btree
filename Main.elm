-- elm-make Main.elm --output elm.js

module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

import BTree exposing (..)
------------------------------------------------

tree =
  fromList ['a', 'b', 'c', 'd']


display : String -> a -> Html msg
display name value =
  div [] [ text (name ++ " ==> " ++ toString value) ]


view model =
  div [ style [ ("font-family", "monospace") ] ]
    [ display "depth" (depth tree)
    ]


update msg model =
    ""


main =
 Html.beginnerProgram
     { model = ""
     , view = view
     , update = update
     }