{--
elm-make Main.elm --output elm.js
--}

module Main exposing (..)

import Html exposing (Html, button, div, text, hr, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes as A exposing (style, type_, value)
import Random

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
    , maxRandomInt : Int
    , minListLength : Int
    , maxListLength : Int
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (fromList [3, 2, 1])
    , stringTree = BTreeString (fromList ["a", "bb", "ccc"])
    , intStringTree = Node (StringNode "a") (singleton (IntNode 1)) (Node (StringNode "bb") (singleton (IntNode 2)) (Node (StringNode "ccc") (singleton (IntNode 3)) Empty))
    , delta = 1
    , exponent = 2
    , maxRandomInt = 99
    , minListLength = 1
    , maxListLength = 12
    }


init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)


type Msg =
      Increment
    | Decrement
    | Raise
    | SortIntList
    | Delta String
    | Exponent String
    | RequestRandomIntList
    | ReceiveRandomIntList (List Int)
    | RequestRandomDelta
    | ReceiveRandomDelta Int
    | Reset


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Increment ] [ text "+" ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Raise ] [ text "^exp" ]
    , button [ onClick SortIntList ] [ text "SortIntTree" ]
    , text "Delta: ", input [ type_ "number", A.min "1", value (toString model.delta), onInput Delta ] []
    , text "Exponent: ", input [ type_ "number", A.min "1", value (toString model.exponent), onInput Exponent ] []
    , button [ onClick RequestRandomIntList ] [ text "RandomIntTree" ]
    , button [ onClick RequestRandomDelta ] [ text "RandomDelta" ]
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


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({model
                    | intTree = BTreeUniformType.incrementNodes model.delta model.intTree
                    , stringTree = BTreeUniformType.incrementNodes model.delta model.stringTree
                    , intStringTree = BTreeVariedType.incrementNodes model.delta model.intStringTree
            }, Cmd.none)

        Decrement ->
            ({model
                | intTree = BTreeUniformType.decrementNodes model.delta model.intTree
                , stringTree = BTreeUniformType.decrementNodes model.delta model.stringTree
                , intStringTree = BTreeVariedType.decrementNodes model.delta model.intStringTree
            }, Cmd.none)

        Raise ->
            ({model
                | intTree = BTreeUniformType.raiseNodes model.exponent model.intTree
                , stringTree = BTreeUniformType.raiseNodes model.exponent model.stringTree
                , intStringTree = BTreeVariedType.raiseNodes model.exponent model.intStringTree
            }, Cmd.none)

        SortIntList ->
            ({model
                | intTree = BTreeUniformType.sort model.intTree
            }, Cmd.none)

        Delta s ->
            ({model | delta = intFromInput s
            }, Cmd.none)

        Exponent s ->
            ({model | exponent = intFromInput s
            }, Cmd.none)

        RequestRandomIntList ->
            let
                randomIntList : Int -> Random.Generator (List Int)
                randomIntList length =
                    Random.list length (Random.int 1 model.maxRandomInt)

                generatorListLength : Random.Generator Int
                generatorListLength =
                    Random.int model.minListLength model.maxListLength

                generatorIntList : Random.Generator (List Int)
                generatorIntList =
                    --andThen : (a -> Generator b) -> Generator a -> Generator b
                    Random.andThen randomIntList generatorListLength
            in
                (model, Random.generate ReceiveRandomIntList generatorIntList)

        RequestRandomDelta ->
            (model, Random.generate ReceiveRandomDelta (Random.int 1 100))

        ReceiveRandomIntList list ->
            ({model | intTree = BTreeInt (fromList list)
            }, Cmd.none)

        ReceiveRandomDelta i ->
            ({model | delta = i
            }, Cmd.none)

        Reset ->
            (initialModel, Cmd.none)


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
