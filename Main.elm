-- elm-make Main.elm --output elm.js

module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

import BTree exposing (..)
------------------------------------------------


emptyTree =
  fromList []


deepTree =
  fromList [1,2,3,4.2]


niceTree =
  fromList [2,1,3.8]


display : String -> a -> Html msg
display name value =
  div [] [ text (name ++ " ==> " ++ toString value) ]


view model =
  div [ style [ ("font-family", "monospace") ] ]
    [ display "depth deepTree" (depth deepTree)
    , display "depth niceTree" (depth niceTree)
    , display "incremented" (map (\n -> n + 1) niceTree)
    , display "sum emptyTree" (sum emptyTree)
    , display "sum deepTree" (sum deepTree)
    , display "sum niceTree" (sum niceTree)
    , display "flatten emptyTree" (flatten emptyTree)
    , display "flatten deepTree" (flatten deepTree)
    , display "flatten niceTree" (flatten niceTree)
    , display "isElement 1 emptyTree" (isElement 1 emptyTree)
    , display "isElement 1 niceTree" (isElement 1 niceTree)
    , display "isElement 11 niceTree" (isElement 11 niceTree)
    ]


update msg model =
    ""


main =
 Html.beginnerProgram
     { model = "initialModel"
     , view = view
     , update = update
     }