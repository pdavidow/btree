module Main exposing (..)

-- Based on https://github.com/vipentti/elm-mdl-dashboard/blob/master/src/View.elm

import Html exposing (Html, div, text, hr, input, h3, h4, h5, p, b, programWithFlags)
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

import Pivot exposing (withRollback)
import Maybe.Extra exposing (unwrap)
import List.Extra exposing (last)
import Random
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid exposing (Uuid)
import Lazy exposing (lazy)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeUniformType exposing (..)
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (NodeTag(..))
import BTree exposing (..) -- todo nope onlyt what is needed
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)
import UniversalConstants exposing (nothingString)
import MusicNote exposing (MusicNote(..), mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter)
import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote)
import Ports exposing (port_startPlayNote, port_donePlayNote, port_donePlayNotes)
import CustomFunctions exposing (lazyUnwrap)
------------------------------------------------


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
    | PlayNotes
    | StartPlayNote (String)
    | DonePlayNote (String)
    | DonePlayNotes (Bool)
    | Reset
    | Mdl (Material.Msg Msg)


type alias Model =
    { intTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , initialMusicNoteTree : BTreeUniformType
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
    , isEnablePlayNotesButton : Bool
    , uuidSeed : Seed
    , mdl : Material.Model
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (Node 5 (singleton 4) (Node 3 Empty (singleton 4)))
    , stringTree = BTreeString (Node "Q 123" (singleton "E") (Node "Q 123" Empty (singleton "ee")))
    , boolTree = BTreeBool (Node True (singleton True) (singleton False))
    , initialMusicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , musicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , variedTree = BTreeVaried (Node (IntNode 123) (singleton (StringNode "abc")) ((Node (BoolNode True)) (singleton (MusicNoteNode (MusicNotePlayer.on (Just C_sharp)))) Empty))
    , intTreeCache = BTreeInt Empty
    , stringTreeCache = BTreeString Empty
    , boolTreeCache = BTreeBool Empty
    , musicNoteTreeCache = BTreeMusicNotePlayer Empty
    , variedTreeCache = BTreeVaried Empty
    , delta = 1
    , exponent = 2
    , maxRandomInt = 99
    , minListLength = 1
    , maxListLength = 6
    , isEnablePlayNotesButton = True
    , uuidSeed = initialSeed 0 -- placeholder
    , mdl = Material.model
    }


generateIds : Int -> Seed -> ( List Uuid, Seed )
generateIds count startSeed =
    let
        generate = \seed -> step Uuid.uuidGenerator seed

        func : Maybe a -> ( Uuid, Seed ) -> ( Uuid, Seed )
        func = \a ( id, seed ) -> generate seed

        tuples = List.repeat (count - 1) Nothing
            |> List.scanl func (generate startSeed)

        ids = List.map Tuple.first tuples

        lazyDefault = Lazy.lazy (\() -> ( Tuple.first (generate startSeed), startSeed ))

        currentSeed = tuples
            |> List.Extra.last
            |> lazyUnwrap lazyDefault identity
            |> Tuple.second

    in
        ( ids, currentSeed )


idedMusicNoteTree : Seed -> (BTreeUniformType, Seed)
idedMusicNoteTree startSeed =
    let
        notes = [E, F, G]
        ( ids, endSeed ) = generateIds (List.length notes) startSeed

        tree = List.map2 (\id note -> MusicNotePlayer.idedOn (Just id) (Just note)) ids notes
            |> BTree.fromListBy MusicNotePlayer.sorter
            |> BTreeMusicNotePlayer
    in
        ( tree, endSeed )


init : Int -> ( Model, Cmd Msg )
init jsSeed =
    let
        ( musicNoteTree, uuidSeed ) = idedMusicNoteTree (initialSeed jsSeed)
    in
        (   {initialModel
            | initialMusicNoteTree = musicNoteTree
            , musicNoteTree = musicNoteTree
            , uuidSeed = uuidSeed
            }
        ,
        Cmd.none
        )


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
    [ Button.render Mdl [9] model.mdl
        [ Button.flat
        , Button.disabled
            |> Options.when (not (isEnablePlayNotesButton model))
        , Options.onClick PlayNotes
        ]
        [ text "Play Notes"]
    , Button.render Mdl [0] model.mdl
        [ Button.flat
        , Options.onClick Increment
        ]
        [ text "+ Delta"]
    , Button.render Mdl [1] model.mdl
        [ Button.flat
        , Options.onClick Decrement
        ]
        [ text "- Delta"]
    , Button.render Mdl [2] model.mdl
        [ Button.flat
        , Options.onClick Raise
        ]
        [ text "^ Exp"]
    , Button.render Mdl [3] model.mdl
        [ Button.flat
        , Options.onClick SortUniformTrees
        ]
        [ text "Sort Uni"]
    , Button.render Mdl [4] model.mdl
        [ Button.flat
        , Options.onClick RemoveDuplicatesInUniformTrees
        ]
        [ text "NoDup Uni"]
    , Button.render Mdl [5] model.mdl
        [ Button.colored
        , Options.onMouseDown StartShowIsIntPrime
        , Options.onMouseUp StopShowIsIntPrime
        ]
        [ text "Prime?"]
    , Button.render Mdl [6] model.mdl
        [ Button.colored
        , Options.onMouseDown StartShowStringLength
        , Options.onMouseUp StopShowStringLength
        ]
        [ text "String Length"]
    , Button.render Mdl [7] model.mdl
        [ Button.accent
        , Options.onClick RequestRandomIntList
        ]
        [ text "Random Int-Tree"]
    , Button.render Mdl [8] model.mdl
        [ Button.accent
        , Options.onClick RequestRandomDelta
        ]
        [ text "Random Delta"]
    , Button.render Mdl [10] model.mdl
        [ Button.raised
        , Options.onClick Reset
        ]
        [ text "Reset"]
    ]


isEnablePlayNotesButton : Model -> Bool
isEnablePlayNotesButton model =
    (model.isEnablePlayNotesButton) && not (BTreeUniformType.isAllNothing model.musicNoteTree)


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
    [ bTreeUniformTypeDiagram model.musicNoteTree
    , bTreeUniformTypeDiagram model.intTree
    , bTreeUniformTypeDiagram model.stringTree
    , bTreeUniformTypeDiagram model.boolTree
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
                operand = positiveDelta model
            in
                ( model
                    |> shiftUniformTrees operand BTreeUniformType.incrementNodes
                    |> shiftVariedTrees operand BTreeVariedType.incrementNodes
                , Cmd.none
                )

        Decrement ->
            let
                operand = positiveDelta model
            in
                ( model
                    |> shiftUniformTrees operand BTreeUniformType.decrementNodes
                    |> shiftVariedTrees operand BTreeVariedType.decrementNodes
                , Cmd.none
                )

        Raise ->
            let
                operand = positiveExponent model
            in
                ( model
                    |> shiftUniformTrees operand BTreeUniformType.raiseNodes
                    |> shiftVariedTrees operand BTreeVariedType.raiseNodes
                , Cmd.none
                )

        SortUniformTrees ->
            ( model
                |> sortUniformTrees
            , Cmd.none
            )

        RemoveDuplicatesInUniformTrees ->
            ( model
                |> removeDuplicatesUniformTrees
            , Cmd.none
            )

        Delta s ->
            (   { model
                | delta = intFromInput s
                }
            , Cmd.none
            )

        Exponent s ->
            (   { model
                | exponent = intFromInput s
                }
            , Cmd.none
            )

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
                ( model
                , Random.generate ReceiveRandomIntList generatorIntList
                )

        RequestRandomDelta ->
            ( model
            , Random.generate ReceiveRandomDelta (Random.int 1 100)
            )

        ReceiveRandomIntList list ->
            (   { model
                | intTree = BTreeInt (fromList list)
                }
            , Cmd.none
            )

        ReceiveRandomDelta i ->
            (   { model
                | delta = i
                }
            , Cmd.none
            )

        StartShowIsIntPrime ->
            ( model
                |> cacheAllTrees
                |> morphUniformTrees BTreeUniformType.toIsIntPrime
                |> morphVariedTrees BTreeVariedType.toIsIntPrime
            , Cmd.none
            )

        StopShowIsIntPrime ->
            ( model
                |> unCacheAllTrees
            , Cmd.none
            )

        StartShowStringLength ->
            ( model
                |> cacheAllTrees
                |> morphUniformTrees BTreeUniformType.toStringLength
                |> morphVariedTrees BTreeVariedType.toStringLength
            , Cmd.none
            )

        StopShowStringLength ->
            ( model
                |> unCacheAllTrees
            , Cmd.none
            )

        PlayNotes ->
            (   { model
                | isEnablePlayNotesButton = False
                }
            , treeMusicPlay model.musicNoteTree
            )

        StartPlayNote id ->
            let
                mbUuid = Uuid.fromString id

                updatedTree = case mbUuid of
                    Just uuid ->
                       startPlayNote (Debug.log "StartPlayNote uuid" uuid) (Debug.log "StartPlayNote mtree" model.musicNoteTree)

                    Nothing ->
                        model.musicNoteTree
            in
            (   { model
                | musicNoteTree = updatedTree
                }
            , Cmd.none
            )

        DonePlayNote id ->
            let
                mbUuid = Uuid.fromString id

                updatedTree = case mbUuid of
                    Just uuid ->
                       donePlayNote (Debug.log "DonePlayNote uuid" uuid) (Debug.log "DonePlayNote mtree" model.musicNoteTree)

                    Nothing ->
                        model.musicNoteTree
            in
            (   { model
                | musicNoteTree = updatedTree
                }
            , Cmd.none
            )

        DonePlayNotes isDone ->
            (   { model
                | isEnablePlayNotesButton = (Debug.log "DonePlayNotes" isDone)
                }
            , Cmd.none
            )

        Reset ->
            let
                tree = model.initialMusicNoteTree
                seed = model.uuidSeed
            in
                (   { initialModel
                    | initialMusicNoteTree = tree
                    , musicNoteTree = tree
                    , uuidSeed = seed
                    }
                , Cmd.none
                )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model


cacheAllTrees : Model -> Model
cacheAllTrees model =
    {model
        | intTreeCache = model.intTree
        , stringTreeCache = model.stringTree
        , boolTreeCache = model.boolTree
        , musicNoteTreeCache = model.musicNoteTree
        , variedTreeCache = model.variedTree
    }


unCacheAllTrees : Model -> Model
unCacheAllTrees model =
    {model
        | intTree = model.intTreeCache
        , stringTree = model.stringTreeCache
        , boolTree= model.boolTreeCache
        , musicNoteTree = model.musicNoteTreeCache
        , variedTree = model.variedTreeCache
    }


changeUniformTrees : (BTreeUniformType -> BTreeUniformType) -> Model -> Model
changeUniformTrees func model =
    {model
        | intTree = func model.intTree
        , stringTree = func model.stringTree
        , boolTree = func model.boolTree
        , musicNoteTree = func model.musicNoteTree
    }


changeVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
changeVariedTrees func model =
    {model
        | variedTree = func model.variedTree
    }


shiftUniformTrees : Int -> (Int -> BTreeUniformType -> BTreeUniformType) -> Model -> Model
shiftUniformTrees operand func model =
    let
        shift = func operand
    in
        changeUniformTrees shift model


shiftVariedTrees : Int -> (Int -> BTreeVariedType -> BTreeVariedType) -> Model -> Model
shiftVariedTrees operand func model =
    let
        shift = func operand
    in
        changeVariedTrees shift model


sortUniformTrees : Model -> Model
sortUniformTrees model =
    let
        func = withRollback BTreeUniformType.sort
    in
        changeUniformTrees func model


removeDuplicatesUniformTrees : Model -> Model
removeDuplicatesUniformTrees model =
    let
        func = BTreeUniformType.removeDuplicates
    in
        changeUniformTrees func model


morphUniformTrees : (BTreeUniformType -> Maybe BTreeUniformType) -> Model -> Model
morphUniformTrees func model =
    let
        defaultMorph = \tree -> defaultMorphUniformTree func tree
    in
        changeUniformTrees defaultMorph model


morphVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
morphVariedTrees func model =
    changeVariedTrees func model


defaultMorphUniformTree : (BTreeUniformType -> Maybe BTreeUniformType) -> BTreeUniformType -> BTreeUniformType
defaultMorphUniformTree func tree =
    Maybe.withDefault (BTreeUniformType.toNothing tree) (func tree)


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ port_startPlayNote StartPlayNote
        , port_donePlayNote DonePlayNote
        , port_donePlayNotes DonePlayNotes
        ]


main =
  Html.programWithFlags -- using programWithFlags to get the seed values from JS
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
