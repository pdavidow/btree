{--
elm-make Main.elm --output elm.js
--}

module Main exposing (..)

import Html exposing (Html, button, div, text, hr, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes as A exposing (style, type_, value)


import BTreeUniformContent exposing (BTreeUniformContent(..))
import BTreeUniformContent exposing (..)
import BTree exposing (..)
import BTreeView exposing (bTreeUniformContentDiagram)
------------------------------------------------


type alias Model =
    { intTree : BTreeUniformContent
    , stringTree : BTreeUniformContent
    , delta : Int
    , exponent : Int
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (fromList [1, 2, 3])
    , stringTree = BTreeString (fromList ["a", "b", "c"])
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
    , text "Delta: ", input [ type_ "number", A.min "1", value (toString model.delta), onInput Delta ] []
    , text "Exponent: ", input [ type_ "number", A.min "1", value (toString model.exponent), onInput Exponent ] []
    , button [ onClick Reset ] [ text "reset" ]
    , div [] [ text (toString model) ]
    , hr [] []
    , div [] [ text ("Depth intTree: " ++ toString (BTreeUniformContent.depth model.intTree)) ]
    , div [] [ text ("Depth stringTree: " ++ toString (BTreeUniformContent.depth model.stringTree)) ]
    , div [] [ text ("SumInt intTree: " ++ toString (BTreeUniformContent.sumInt model.intTree)) ]
    , div [] [ text ("SumString stringTree: " ++ toString (BTreeUniformContent.sumString model.stringTree)) ]
    , bTreeUniformContentDiagram model.intTree
    , bTreeUniformContentDiagram model.stringTree
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            {model
                | intTree = incrementNodes model.intTree model.delta
                , stringTree = incrementNodes model.stringTree model.delta
            }

        Decrement ->
            {model
                | intTree = decrementNodes model.intTree model.delta
                , stringTree = decrementNodes model.stringTree model.delta
            }

        Raise ->
            {model
                | intTree = raiseNodes model.intTree model.exponent
                , stringTree = raiseNodes model.stringTree model.exponent
            }

        Delta s ->
            {model | delta = intFromInput s}

        Exponent s ->
            {model | exponent = intFromInput s}

        Reset ->
            initialModel


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)


main =
    Html.beginnerProgram
         { model = initialModel
         , view = view
         , update = update
         }
