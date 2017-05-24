{--
elm-make Main.elm --output elm.js
--}

-- html layout based on https://github.com/rtfeldman/elm-spa-example/blob/bb1293e78d058b7e2dcf04ca3bf2c9beffeb74ce/src/Page/Home.elm

module Main exposing (..)

import Html exposing (Html, button, div, text, hr, input, h3, h4, h5, p)
import Html.Events exposing (onClick, onInput, onMouseDown, onMouseUp)
import Html.Attributes as A exposing (class, style, type_, value)
import Random

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeUniformType exposing (..)
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (NodeTag(..))
import BTree exposing (..)
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)
------------------------------------------------


type alias Model =
    { intTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , intStringBoolTree : BTreeVariedType
    , intTreeCache : BTreeUniformType
    , stringTreeCache : BTreeUniformType
    , intStringBoolTreeCache : BTreeVariedType
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
    , boolTree = BTreeBool (Node True Empty (singleton False))
    , intStringBoolTree = BTreeVaried (Node (StringNode "a") (singleton (IntNode 1)) (Node (BoolNode False) (singleton (BoolNode True)) (Node (StringNode "ccc") (singleton (IntNode 3)) Empty)))
    , intTreeCache = BTreeInt Empty
    , stringTreeCache = BTreeString Empty
    , intStringBoolTreeCache = BTreeVaried Empty
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
    | StartShowStringLength
    | StopShowStringLength
    | StartShowIsIntPrime
    | StopShowIsIntPrime
    | Reset


view : Model -> Html Msg
view model =
    div [ class "home-page" ]
        [ viewBanner
        , div [ class "container page" ]
            [ div []
                [ button [ onClick Increment ] [ text "Increment by Delta" ]
                , button [ onClick Decrement ] [ text "Decrement by Delta" ]
                , button [ onClick Raise ] [ text "Raise to Exponent" ]
                , button [ onClick SortIntList ] [ text "Sort IntTree" ]
                , button [ onMouseDown StartShowIsIntPrime, onMouseUp StopShowIsIntPrime ] [ text "Is Int Prime?" ]
                , button [ onMouseDown StartShowStringLength, onMouseUp StopShowStringLength ] [ text "String Length" ]
                , button [ onClick RequestRandomIntList ] [ text "Random IntTree" ]
                , button [ onClick RequestRandomDelta ] [ text "Random Delta" ]
                , button [ onClick Reset ] [ text "Reset" ]
                ]
            , hr [] []
            , text "Delta: ", input [ type_ "number", A.min "1", value (toString model.delta), onInput Delta ] []
            , text "Exponent: ", input [ type_ "number", A.min "1", value (toString model.exponent), onInput Exponent ] []
            -- , div [] [ text (toString model) ]
            , hr [] []
            , div [] [ text ("Depth intTree: " ++ toString (BTreeUniformType.depth model.intTree)) ]
            , div [] [ text ("Depth stringTree: " ++ toString (BTreeUniformType.depth model.stringTree)) ]
            , div [] [ text ("SumInt intTree: " ++ toString (BTreeUniformType.sumInt model.intTree)) ]
            , div [] [ text ("SumString stringTree: " ++ toString (BTreeUniformType.sumString model.stringTree)) ]
            , hr [] []
            , h5 [] [text "Int Tree"], bTreeUniformTypeDiagram model.intTree
            , hr [] []
            , h5 [] [text "String Tree"], bTreeUniformTypeDiagram model.stringTree
            , hr [] []
            , h5 [] [text "Bool Tree"], bTreeUniformTypeDiagram model.boolTree
            , hr [] []
            , h5 [] [text "Int/String/Bool Tree"], bTreeVariedTypeDiagram model.intStringBoolTree
            ]
    ]

viewBanner : Html msg
viewBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h3 [ class "logo-font" ] [ text "Binary-Tree Playground" ]
            ]
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({model
                    | intTree = BTreeUniformType.incrementNodes model.delta model.intTree
                    , stringTree = BTreeUniformType.incrementNodes model.delta model.stringTree
                    , boolTree = BTreeUniformType.incrementNodes model.delta model.boolTree
                    , intStringBoolTree = BTreeVariedType.incrementNodes model.delta model.intStringBoolTree
            }, Cmd.none)

        Decrement ->
            ({model
                | intTree = BTreeUniformType.decrementNodes model.delta model.intTree
                , stringTree = BTreeUniformType.decrementNodes model.delta model.stringTree
                , boolTree = BTreeUniformType.decrementNodes model.delta model.boolTree
                , intStringBoolTree = BTreeVariedType.decrementNodes model.delta model.intStringBoolTree
            }, Cmd.none)

        Raise ->
            ({model
                | intTree = BTreeUniformType.raiseNodes model.exponent model.intTree
                , stringTree = BTreeUniformType.raiseNodes model.exponent model.stringTree
                , boolTree = BTreeUniformType.raiseNodes model.exponent model.boolTree
                , intStringBoolTree = BTreeVariedType.raiseNodes model.exponent model.intStringBoolTree
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

        StartShowIsIntPrime ->
            ({model
                | intTreeCache = model.intTree
                , intStringBoolTreeCache = model.intStringBoolTree
                , intTree = BTreeUniformType.toIsIntPrime model.intTree
                , intStringBoolTree = BTreeVariedType.toIsIntPrime model.intStringBoolTree
            }, Cmd.none)

        StopShowIsIntPrime ->
            ({model
                | intTree = model.intTreeCache
                , intStringBoolTree = model.intStringBoolTreeCache
            }, Cmd.none)

        StartShowStringLength ->
            ({model
                | stringTreeCache = model.stringTree
                , intStringBoolTreeCache = model.intStringBoolTree
                , stringTree = BTreeUniformType.toStringLength model.stringTree
                , intStringBoolTree = BTreeVariedType.toStringLength model.intStringBoolTree
            }, Cmd.none)


        StopShowStringLength ->
            ({model
                | stringTree = model.stringTreeCache
                , intStringBoolTree = model.intStringBoolTreeCache
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
