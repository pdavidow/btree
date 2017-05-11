{--
elm-make Main.elm --output elm.js
--}

module Main exposing (..)

import Html exposing (Html, div)
import TreeDiagram exposing (node, Tree)
import BTreeView exposing (treeDiagram)
------------------------------------------------


type alias Model = TreeDiagram.Tree (Maybe a)


initialModel: Model
initialModel = TreeDiagram.node Nothing []


view : Model -> Html
view model =
  div [] [ treeDiagram model]


main =
    Html.beginnerProgram
         { model = initialModel
         , view = view
         , update = initialModel
         }
