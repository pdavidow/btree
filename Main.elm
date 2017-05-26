{--
elm-make Main.elm --output elm.js
--}

-- Based on https://github.com/vipentti/elm-mdl-dashboard/blob/master/src/View.elm

module Main exposing (..)

import Html exposing (Html, div, text, hr, input, h3, h4, h5, p, b)
import Html.Events exposing (onInput)
import Html.Attributes as A exposing (class, style, type_, value)

import Material.Grid as Grid exposing (..)
import Material.Options as Options exposing (Style, css, nop)
import Material.Layout as Layout
import Material.Button as Button exposing (..)
import Material.Elevation as Elevation
import Material.Color as Color
import Material.Textfield as Textfield
import Material.List as Lists
import Material.Chip as Chip
import Material.Scheme
import Material

import Random
import Pivot exposing (withRollback)
import Maybe.Extra exposing (unwrap)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeUniformType exposing (..)
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (NodeTag(..))
import BTree exposing (..)
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)
import Constants exposing (nothingString)
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
    , mdl : Material.Model
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (fromList [3, 2, 1])
    , stringTree = BTreeString (fromList ["a", "bb", "ccc"])
    , boolTree = BTreeBool (Node True Empty (singleton False))
    , intStringBoolTree = BTreeVaried (Node (IntNode 123) (singleton (StringNode "abc")) (singleton (BoolNode True)))
    , intTreeCache = BTreeInt Empty
    , stringTreeCache = BTreeString Empty
    , intStringBoolTreeCache = BTreeVaried Empty
    , delta = 1
    , exponent = 2
    , maxRandomInt = 99
    , minListLength = 1
    , maxListLength = 6
    , mdl = Material.model
    }


init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)


type Msg =
      Increment
    | Decrement
    | Raise
    | SortIntTree
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
    | Mdl (Material.Msg Msg)


view : Model -> Html Msg
view model =
    Material.Scheme.top <|
        Layout.render Mdl
                model.mdl
                [ Layout.fixedHeader
                , Layout.fixedDrawer
                , Options.css "display" "flex !important"
                , Options.css "flex-direction" "row"
                , Options.css "align-items" "center"
                ]
                { header = [ viewHeader model ]
                , drawer = []
                , tabs = ( [], [] )
                , main =
                    [ viewBody model
                    ]
                }


inputs : Model -> List (Html Msg)
inputs model =
    [ b [] [text "Delta: "], input [ A.type_ "number", A.min "1", value (toString model.delta), A.style [("width", "3%")], onInput Delta ] []
    , b [] [text "Exp: "], input [ A.type_ "number", A.min "1", value (toString model.exponent), A.style [("width", "3%")], onInput Exponent ] []
    ]


actionButtons : Model -> List (Html Msg)
actionButtons model =
    [ Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick Increment
        ]
        [ text "+ Delta"]
    , Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick Decrement
        ]
        [ text "- Delta"]
    , Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick Raise
        ]
        [ text "^ Exp"]
    , Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick SortIntTree
        ]
        [ text "Sort Int-Tree"]
    , Button.render Mdl [0] model.mdl
        [ Button.colored
        , Options.onMouseDown StartShowIsIntPrime
        , Options.onMouseUp StopShowIsIntPrime
        ]
        [ text "Prime?"]
    , Button.render Mdl [0] model.mdl
        [ Button.colored
        , Options.onMouseDown StartShowStringLength
        , Options.onMouseUp StopShowStringLength
        ]
        [ text "String Length"]
    , Button.render Mdl [0] model.mdl
        [ Button.accent
        , Options.onClick RequestRandomIntList
        ]
        [ text "Random Int-Tree"]
    , Button.render Mdl [0] model.mdl
        [ Button.accent
        , Options.onClick RequestRandomDelta
        ]
        [ text "Random Delta"]
    , Button.render Mdl [0] model.mdl
        [ Button.raised
        , Options.onClick Reset
        ]
        [ text "Reset"]
    ]


viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        [ Color.background <| Color.color Color.Grey Color.S100
        , Color.text <| Color.color Color.Grey Color.S900
        ]
        [ Layout.title [] [ text "Binary-Tree Playground" ]
        , Layout.spacer
        , grid [ ]
            [ cell
                [ size All 12
                , Elevation.e2
                , Options.css "align-items" "center"
                , Options.cs "mdl-grid"
                ]
                ( List.concat
                    [ inputs model
                    , actionButtons model
                    ]
                )
            ]
        ]


viewStatus: Model -> List (Html.Html msg)
viewStatus model =
    [ Chip.span []
        [ Chip.content []
            [ text ("Depth Int-Tree: " ++ toString (BTreeUniformType.depth model.intTree)) ]
        ]
    , Chip.span []
        [ Chip.content []
            [ text ("Depth String-Tree: " ++ toString (BTreeUniformType.depth model.stringTree)) ]
        ]
    , Chip.span []
        [ Chip.content []
            ( let
                string = unwrap
                    nothingString
                    toString
                    (BTreeUniformType.sumInt model.intTree)
              in
                [ text ("Sum Int-Tree: " ++ string) ]
            )
        ]
    , Chip.span []
        [ Chip.content []
            ( let
                string = unwrap
                    nothingString
                    identity
                    (BTreeUniformType.sumString model.stringTree)
              in
                [ text ("Sum String-Tree: " ++ string) ]
            )
        ]
    ]


viewTrees: Model -> List (Html.Html msg)
viewTrees model =
    [ bTreeUniformTypeDiagram model.intTree
    , bTreeUniformTypeDiagram model.stringTree
    , bTreeUniformTypeDiagram model.boolTree
    , bTreeVariedTypeDiagram model.intStringBoolTree
    ]


viewBody : Model -> Html Msg
viewBody model =
    grid [ ]
        [ cell
            [ size All 12
            , Elevation.e2
            , Options.css "align-items" "center"
            , Options.cs "mdl-grid"
            ]
            (viewStatus model)
        , cell
            [ size All 12
            , Elevation.e2
            , Options.css "align-items" "center"
            , Options.cs "mdl-grid"
            ]
            (viewTrees model)
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

        SortIntTree ->
            ({model
                | intTree = withRollback BTreeUniformType.sort model.intTree
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

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model


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
