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
import Pivot exposing (withRollback) -- todo unused?
import Maybe.Extra exposing (unwrap)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeUniformType exposing (..)
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (NodeTag(..))
import BTree exposing (..)
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)
import Constants exposing (nothingString)
import MusicNote exposing (MusicNote(..))
------------------------------------------------


type alias Model =
    { intTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , musicNoteTree : BTreeUniformType
    , variedTree : BTreeVariedType
    , intTreeCache : BTreeUniformType
    , stringTreeCache : BTreeUniformType
    , boolTreeCache : BTreeUniformType
    , musicNoteTreeCache : BTreeUniformType
    , variedTreeCache : BTreeVariedType
    , delta : Int
    , exponent : Int
    , maxRandomInt : Int
    , minListLength : Int
    , maxListLength : Int
    , mdl : Material.Model
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (Node 5 (singleton 4) (Node 3 Empty (singleton 4)))
    , stringTree = BTreeString (Node "Q" (singleton "E") (Node "CC" Empty (singleton "eee")))
    , boolTree = BTreeBool (Node True (singleton True) (singleton False))
    , musicNoteTree = BTreeMusicNote (Node (Just F) (singleton (Just E)) (Node (Just C_sharp) Empty (singleton (Just E))))
    , variedTree = BTreeVaried (Node (IntNode 123) (singleton (StringNode "abc")) ((Node (BoolNode True)) (singleton (MusicNoteNode C_sharp)) Empty))
    , intTreeCache = BTreeInt Empty
    , stringTreeCache = BTreeString Empty
    , boolTreeCache = BTreeBool Empty
    , musicNoteTreeCache = BTreeMusicNote Empty
    , variedTreeCache = BTreeVaried Empty
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
    | SortUniformTrees
    | RemoveDuplicatesInUniformTrees
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
        , Options.onClick SortUniformTrees
        ]
        [ text "Sort Uni"]
    , Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick RemoveDuplicatesInUniformTrees
        ]
        [ text "NoDup Uni"]
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
        [ Layout.title [] [ text "BTREE" ]
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
    , bTreeUniformTypeDiagram model.musicNoteTree
    , bTreeVariedTypeDiagram model.variedTree
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


positiveDelta : Model -> Int
positiveDelta model =
    abs model.delta


positiveExponent : Model -> Int
positiveExponent model =
    abs model.exponent


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            let
                delta = positiveDelta model
            in
                ({model
                    | intTree = BTreeUniformType.incrementNodes delta model.intTree
                    , stringTree = BTreeUniformType.incrementNodes delta model.stringTree
                    , boolTree = BTreeUniformType.incrementNodes delta model.boolTree
                    , musicNoteTree = BTreeUniformType.incrementNodes delta model.musicNoteTree
                    , variedTree = BTreeVariedType.incrementNodes delta model.variedTree
                }, Cmd.none)

        Decrement ->
            let
                delta = positiveDelta model
            in
                ({model
                    | intTree = BTreeUniformType.decrementNodes delta model.intTree
                    , stringTree = BTreeUniformType.decrementNodes delta model.stringTree
                    , boolTree = BTreeUniformType.decrementNodes delta model.boolTree
                    , musicNoteTree = BTreeUniformType.decrementNodes delta model.musicNoteTree
                    , variedTree = BTreeVariedType.decrementNodes delta model.variedTree
                }, Cmd.none)

        Raise ->
            let
                exponent = positiveExponent model
            in
                ({model
                    | intTree = BTreeUniformType.raiseNodes exponent model.intTree
                    , stringTree = BTreeUniformType.raiseNodes exponent model.stringTree
                    , boolTree = BTreeUniformType.raiseNodes exponent model.boolTree
                    , musicNoteTree = BTreeUniformType.raiseNodes exponent model.musicNoteTree
                    , variedTree = BTreeVariedType.raiseNodes exponent model.variedTree
                }, Cmd.none)

        SortUniformTrees ->
            ({model
                | intTree = withRollback BTreeUniformType.sort model.intTree
                , stringTree = withRollback BTreeUniformType.sort model.stringTree
                , boolTree = withRollback BTreeUniformType.sort model.boolTree
                , musicNoteTree = withRollback BTreeUniformType.sort model.musicNoteTree
            }, Cmd.none)

        RemoveDuplicatesInUniformTrees ->
            ({model
                | intTree = BTreeUniformType.removeDuplicates model.intTree
                , stringTree = BTreeUniformType.removeDuplicates model.stringTree
                , boolTree = BTreeUniformType.removeDuplicates model.boolTree
                , musicNoteTree = BTreeUniformType.removeDuplicates model.musicNoteTree
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

        StartShowIsIntPrime -> -- todo refactor...
            ({model-- todo refactor
                | intTreeCache = model.intTree
                , stringTreeCache = model.stringTree
                , boolTreeCache = model.boolTree
                , musicNoteTreeCache = model.musicNoteTree
                , variedTreeCache = model.variedTree

                , intTree = Maybe.withDefault (BTreeUniformType.toNothing model.intTree) (BTreeUniformType.toIsIntPrime model.intTree)
                , stringTree = Maybe.withDefault (BTreeUniformType.toNothing model.stringTree) (BTreeUniformType.toIsIntPrime model.stringTree)
                , boolTree= Maybe.withDefault (BTreeUniformType.toNothing model.boolTree) (BTreeUniformType.toIsIntPrime model.boolTree)
                , musicNoteTree = Maybe.withDefault (BTreeUniformType.toNothing model.musicNoteTree) (BTreeUniformType.toIsIntPrime model.musicNoteTree)
                , variedTree = BTreeVariedType.toIsIntPrime model.variedTree
            }, Cmd.none)

        StopShowIsIntPrime ->
            ({model -- todo refactor
                | intTree = model.intTreeCache
                , stringTree = model.stringTreeCache
                , boolTree= model.boolTreeCache
                , musicNoteTree = model.musicNoteTreeCache
                , variedTree = model.variedTreeCache
            }, Cmd.none)

        StartShowStringLength ->
            ({model -- todo refactor
                | intTreeCache = model.intTree
                , stringTreeCache = model.stringTree
                , boolTreeCache = model.boolTree
                , musicNoteTreeCache = model.musicNoteTree
                , variedTreeCache = model.variedTree

                , intTree = Maybe.withDefault (BTreeUniformType.toNothing model.intTree) (BTreeUniformType.toStringLength model.intTree)
                , stringTree = Maybe.withDefault (BTreeUniformType.toNothing model.stringTree) ( BTreeUniformType.toStringLength model.stringTree)
                , boolTree= Maybe.withDefault (BTreeUniformType.toNothing model.boolTree) ( BTreeUniformType.toStringLength model.boolTree)
                , musicNoteTree = Maybe.withDefault (BTreeUniformType.toNothing model.musicNoteTree) ( BTreeUniformType.toStringLength model.musicNoteTree)
                , variedTree = BTreeVariedType.toStringLength model.variedTree
            }, Cmd.none)


        StopShowStringLength ->
            ({model -- todo refactor
                | intTree = model.intTreeCache
                , stringTree = model.stringTreeCache
                , boolTree= model.boolTreeCache
                , musicNoteTree = model.musicNoteTreeCache
                , variedTree = model.variedTreeCache
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
