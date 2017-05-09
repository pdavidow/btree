-- elm-make Main.elm --output elm.js

module Main exposing (..)

import Html exposing (Html, button, div, text, hr, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style, type_, value)


import BTree exposing (..)
------------------------------------------------


type alias Model =
    { tree : BTree Int
    , exponent : Int
    , delta : Int
    }


initialModel: Model
initialModel =
    { tree = fromList [1, 2, 3]
    , delta = 1
    , exponent = 2
    }


type Msg = Increment | Decrement | Raise | Delta String | Exponent String | Reset


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Increment ] [ text "+" ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Raise ] [ text "^exp" ]
    , text "Delta: ", input [ type_ "number", value (toString model.delta), onInput Delta ] []
    , text "Exponent: ", input [ type_ "number", value (toString model.exponent), onInput Exponent ] []
    , button [ onClick Reset ] [ text "reset" ]
    , div [] [ text (toString model) ]
    , hr [] []
    , div [] [ text ("Depth: " ++ toString (depth model.tree)) ]
    , div [] [ text ("Sum: " ++ toString (sum model.tree)) ]
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            modelWithMappedTree (\n -> n + model.delta) model

        Decrement ->
            modelWithMappedTree (\n -> n - model.delta) model

        Raise ->
            modelWithMappedTree (\n -> n ^ model.exponent) model

        Delta s ->
            {model | delta = intFromInput s}

        Exponent s ->
            {model | exponent = intFromInput s}

        Reset ->
            initialModel


modelWithMappedTree : (Int -> Int) -> Model -> Model
modelWithMappedTree func model =
    {model | tree = map func model.tree}


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)


main =
    Html.beginnerProgram
         { model = initialModel
         , view = view
         , update = update
         }
