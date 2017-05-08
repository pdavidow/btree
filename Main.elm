-- elm-make Main.elm --output elm.js

module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

import BTree exposing (..)
------------------------------------------------


type alias Model = BTree Int
type Msg = Increment | Decrement | Square | Reset


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Increment ] [ text "+" ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Square ] [ text "^2" ]
    , button [ onClick Reset ] [ text "Reset" ]
    , div [] [ text (toString model) ]
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            initialModel
        Increment ->
            map (\n -> n + 1) model
        Decrement ->
            map (\n -> n - 1) model
        Square ->
            map (\n -> n ^ 2) model


initialModel: Model
initialModel =
    fromList [1, 2, 3]


main =
    Html.beginnerProgram
         { model = initialModel
         , view = view
         , update = update
         }
