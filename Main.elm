{--
elm-make Main.elm --output elm.js
--}

module Main exposing (..)

import Html exposing (Html, button, div, text, hr, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes as A exposing (style, type_, value)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeUniformType exposing (..)
import BTreeVariedType exposing (BTreeVariedType, incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (..)
import BTree exposing (NodeTag(..))
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeDiagram)
------------------------------------------------


type alias Model =
    { intTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , intStringTree : BTreeVariedType
    , delta : Int
    , exponent : Int
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (fromList [1, 2, 3])
    , stringTree = BTreeString (fromList ["a", "bb", "ccc"])
    , intStringTree = Node (StringNode "a") (singleton (IntNode 1)) (Node (StringNode "bb") (singleton (IntNode 2)) (Node (StringNode "ccc") (singleton (IntNode 3)) Empty))
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
    , div [] [ text ("Depth intTree: " ++ toString (BTreeUniformType.depth model.intTree)) ]
    , div [] [ text ("Depth stringTree: " ++ toString (BTreeUniformType.depth model.stringTree)) ]
    , div [] [ text ("SumInt intTree: " ++ toString (BTreeUniformType.sumInt model.intTree)) ]
    , div [] [ text ("SumString stringTree: " ++ toString (BTreeUniformType.sumString model.stringTree)) ]
    , bTreeUniformTypeDiagram model.intTree
    , bTreeUniformTypeDiagram model.stringTree
    , bTreeDiagram model.intStringTree
    ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            {model
                | intTree = BTreeUniformType.incrementNodes model.delta model.intTree
                , stringTree = BTreeUniformType.incrementNodes model.delta model.stringTree
                , intStringTree = BTreeVariedType.incrementNodes model.delta model.intStringTree
            }

        Decrement ->
            {model
                | intTree = BTreeUniformType.decrementNodes model.delta model.intTree
                , stringTree = BTreeUniformType.decrementNodes model.delta model.stringTree
                , intStringTree = BTreeVariedType.decrementNodes model.delta model.intStringTree
            }

        Raise ->
            {model
                | intTree = BTreeUniformType.raiseNodes model.exponent model.intTree
                , stringTree = BTreeUniformType.raiseNodes model.exponent model.stringTree
                , intStringTree = BTreeVariedType.raiseNodes model.exponent model.intStringTree
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
