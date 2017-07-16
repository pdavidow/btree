module Main exposing (..)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, programWithFlags)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onInput)
import Html.Attributes as A exposing (class, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Pivot exposing (withRollback)
import Maybe.Extra exposing (unwrap)
import List.Extra exposing (last)
import Random
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)
import Lazy exposing (lazy)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTreeVariedType exposing (BTreeVariedType(..), incrementNodes, decrementNodes, raiseNodes)
import BTree exposing (BTree(..), NodeTag(..), fromList, singleton, toTreeDiagramTree)
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
    , isPlayNotes : Bool
    , uuidSeed : Seed
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt (Node 5 (singleton 4) (Node 3 Empty (singleton 4)))
    , stringTree = BTreeString (Node "Q 123" (singleton "E") (Node "Q 123" Empty (singleton "ee")))
    , boolTree = BTreeBool (Node True (singleton True) (singleton False))
    , initialMusicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , musicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , variedTree = BTreeVaried (Node (IntNode 123) (singleton (StringNode "abc")) ((Node (BoolNode True)) (singleton (MusicNoteNode (MusicNotePlayer.on C_sharp))) Empty))
    , intTreeCache = BTreeInt Empty
    , stringTreeCache = BTreeString Empty
    , boolTreeCache = BTreeBool Empty
    , musicNoteTreeCache = BTreeMusicNotePlayer Empty
    , variedTreeCache = BTreeVaried Empty
    , delta = 1
    , exponent = 2
    , isPlayNotes = False
    , uuidSeed = initialSeed 0 -- placeholder
    }


generateIds : Int -> Seed -> ( List Uuid, Seed )
generateIds count startSeed =
    let
        generate = \seed -> step uuidGenerator seed

        fn : Maybe a -> ( Uuid, Seed ) -> ( Uuid, Seed )
        fn = \a ( id, seed ) -> generate seed

        tuples = List.repeat (count - 1) Nothing
            |> List.scanl fn (generate startSeed)

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
        notes = [F, E, C_sharp, E]
        ( ids, endSeed ) = generateIds (List.length notes) startSeed

        tree = List.map2 (\id note -> MusicNotePlayer.idedOn (Just id) note) ids notes
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
    div [ classes
            []
        ]
        [ tachyons.css
        , viewHeader model
        , viewMain model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    header
        [ classes
           [ T.bg_green
           , T.fixed
           , T.w_100
           , T.h3
           , T.ph3
           , T.pv2
           , T.z_max
           ]
        ]
        [ span
            [ classes
                [ T.f2
                , T.b
                , T.pl2
                , T.pr2
                , T.hover_yellow
                , T.hover_bg_black
                ]
            ]
            [ text "BinaryTree" ]
        , span
            [ classes
                [ T.f2
                , T.i
                , T.courier
                , T.pl2
                , T.pr2
                , T.yellow
                , T.hover_black
                , T.hover_bg_yellow
                ]
            ]
            [ text "playground" ]
        , span
            [ classes
                [ T.fr
                , T.pr2
                , T.pt2
                , T.f4
                , T.grow_large
                ]
            ]
            [ a
                [ href "https://github.com/pdavidow/btree", target "_blank" ]
                [ text "Github" ]
            ]
        ]


viewMain : Model -> Html Msg
viewMain model =
    main_
        [ classes
            [ T.pv5
            , T.w_100
            ]
        ]
        [ viewDashboard model
        , viewTrees model
        ]


viewDashboard : Model -> Html Msg
viewDashboard model =
    section
        [ classes
            [ T.fixed
            , T.w_100
            , T.f3
            , T.pa3
            , T.z_max
           ]
        ]
        [ section
            [ classes
                [ T.pa1
                , T.bg_washed_yellow
                ]
            ]
            ( viewDashboardTop model )
        , section
            [ classes
                [ T.pa1
                , T.bg_washed_red
                ]
            ]
            ( viewDashboardBottom model )
        ]


viewDashboardTop : Model -> List (Html Msg)
viewDashboardTop model =
    [ span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick PlayNotes, disabled (not (isEnablePlayNotesButton model))]
            [text "Play"]
        ]
    , span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick Increment, disabled model.isPlayNotes]
            [text "+ Delta"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick Decrement, disabled model.isPlayNotes]
            [text "- Delta"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick Raise, disabled model.isPlayNotes]
            [text "^ Exp"]
        ]
    , span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick SortUniformTrees, disabled model.isPlayNotes]
            [text "Sort"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick RemoveDuplicatesInUniformTrees, disabled model.isPlayNotes]
            [text "Dedup uni"]
        ]
    , span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onMouseDown StartShowIsIntPrime, onMouseUp StopShowIsIntPrime]
            [text "Prime?"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onMouseDown StartShowStringLength, onMouseUp StopShowStringLength]
            [text "String Length"]
        ]
    , span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick RequestRandomIntList]
            [text "Random Int-Tree"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick RequestRandomDelta]
            [text "Random Delta"]
        ]
    , button
        [classes [T.fr, T.hover_bg_light_yellow, T.mt1, T.mb1, T.mr2], onClick Reset, disabled model.isPlayNotes]
        [text "Reset"]
    ]


isEnablePlayNotesButton : Model -> Bool
isEnablePlayNotesButton model =
    not (model.isPlayNotes) && not (BTreeUniformType.isAllNothing model.musicNoteTree)


viewDashboardBottom : Model -> List (Html Msg)
viewDashboardBottom model =
    viewInputs model


viewInputs : Model -> List (Html Msg)
viewInputs model =
    [ span
        []
        [ (text "Delta: ")
        , input
            [classes [T.f4, T.w3], A.type_ "number", A.min "1", value (toString model.delta), onInput Delta]
            []
        ]
    , span
        [classes [T.pl3]]
        [ (text "Exp: ")
        , input
            [classes [T.f4, T.w3], A.type_ "number", A.min "1", value (toString model.exponent), onInput Exponent]
            []
        ]
    ]


viewTrees : Model -> Html Msg
viewTrees model =
    -- http://tachyons.io/components/layout/five-column-collapse-one/index.html
    section
        [ classes
            [ T.cf
            , T.pv6
            , T.flex_auto
            , T.bg_washed_green
           ]
        ]
        [ viewUniformTreeCard model.musicNoteTree
        , viewUniformTreeCard model.intTree
        , viewUniformTreeCard model.stringTree
        , viewUniformTreeCard model.boolTree
        , viewVariedTreeCard model.variedTree
        ]


viewUniformTreeCard : BTreeUniformType -> Html msg
viewUniformTreeCard bTreeUniformType =
    let
        title = bTreeUniformTitle bTreeUniformType
        status = bTreeUniformStatus bTreeUniformType
        diagram = bTreeUniformTypeDiagram bTreeUniformType
    in
        viewTreeCard title status Nothing diagram


viewVariedTreeCard : BTreeVariedType -> Html msg
viewVariedTreeCard bTreeVariedType =
    let
        (BTreeVaried bTree) = bTreeVariedType

        title = "BTreeVaried"
        status = depthStatus (BTree.depth bTree)
        diagram = bTreeVariedTypeDiagram bTreeVariedType
    in
        viewTreeCard title status (Just (T.bg_black_05)) diagram


depthStatus : Int -> String
depthStatus depth =
    "depth " ++ toString depth


bTreeUniformTitle : BTreeUniformType -> String
bTreeUniformTitle bTreeUniformType =
    bTreeUniformType
        |> toString
        |> String.split " "
        |> List.head
        |> Maybe.Extra.unwrap "" identity


bTreeUniformStatus : BTreeUniformType -> String
bTreeUniformStatus bTreeUniformType =
    let
        depth = BTreeUniformType.depth bTreeUniformType
        status = depthStatus depth
    in
        case bTreeUniformType of
            BTreeInt bTree ->
                let
                    sum = BTree.sumInt bTree
                in
                    status ++ ("; sum " ++ toString sum)

            BTreeString bTree ->
                status

            BTreeBool bTree ->
                status

            BTreeMusicNotePlayer bTree ->
                status

            BTreeNothing bTree ->
                status


viewTreeCard : String -> String -> Maybe String -> Html msg -> Html msg
viewTreeCard title status mbBgColor diagram =
    let
        articleTachyons =
            [ T.fl
            , T.w_100
            , T.w_20_ns
            , T.br2
            , T.ba
            , T.b__black_10
            , T.mw6
            , T.center
            , T.overflow_x_scroll
            ]  ++ (unwrap [] List.singleton mbBgColor)
    in
        article
            [ classes articleTachyons ]
            [ div
                [ classes
                    [ T.tc
                    ]
                ]
                [ Html.h1
                    [ classes
                        [ T.f4
                        , T.mb2
                        , T.pt1
                        ]
                    ]
                    [ text title ]
                , Html.h2
                    [ classes
                        [ T.f5
                        , T.fw4
                        , T.mt0
                        ]
                    ]
                    [ text status ]
                , div
                    [ classes
                        [ T.mt0
                        ]
                    ]
                    [ diagram ]
                ]
            ]


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
                maxRandomInt = 99
                minListLength = 1
                maxListLength = 6

                randomIntList : Int -> Random.Generator (List Int)
                randomIntList length =
                    Random.list length (Random.int 1 maxRandomInt)

                generatorListLength : Random.Generator Int
                generatorListLength =
                    Random.int minListLength maxListLength

                generatorIntList : Random.Generator (List Int)
                generatorIntList =
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
                | isPlayNotes = True
                }
            , treeMusicPlay model.musicNoteTree
            )

        StartPlayNote id ->
            let
                mbUuid = Uuid.fromString id

                updatedTree = case mbUuid of
                    Just uuid ->
                       startPlayNote uuid model.musicNoteTree

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
                       donePlayNote uuid model.musicNoteTree

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
                | isPlayNotes = not isDone
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


positiveDelta : Model -> Int
positiveDelta model =
    abs model.delta


positiveExponent : Model -> Int
positiveExponent model =
    abs model.exponent


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
changeUniformTrees fn model =
    {model
        | intTree = fn model.intTree
        , stringTree = fn model.stringTree
        , boolTree = fn model.boolTree
        , musicNoteTree = fn model.musicNoteTree
    }


changeVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
changeVariedTrees fn model =
    {model
        | variedTree = fn model.variedTree
    }


shiftUniformTrees : Int -> (Int -> BTreeUniformType -> BTreeUniformType) -> Model -> Model
shiftUniformTrees operand fn model =
    let
        shift = fn operand
    in
        changeUniformTrees shift model


shiftVariedTrees : Int -> (Int -> BTreeVariedType -> BTreeVariedType) -> Model -> Model
shiftVariedTrees operand fn model =
    let
        shift = fn operand
    in
        changeVariedTrees shift model


sortUniformTrees : Model -> Model
sortUniformTrees model =
    let
        fn = withRollback BTreeUniformType.sort
    in
        changeUniformTrees fn model


removeDuplicatesUniformTrees : Model -> Model
removeDuplicatesUniformTrees model =
    let
        fn = BTreeUniformType.removeDuplicates
    in
        changeUniformTrees fn model


morphUniformTrees : (BTreeUniformType -> Maybe BTreeUniformType) -> Model -> Model
morphUniformTrees fn model =
    let
        defaultMorph = \tree -> defaultMorphUniformTree fn tree
    in
        changeUniformTrees defaultMorph model


morphVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
morphVariedTrees fn model =
    changeVariedTrees fn model


defaultMorphUniformTree : (BTreeUniformType -> Maybe BTreeUniformType) -> BTreeUniformType -> BTreeUniformType
defaultMorphUniformTree fn tree =
    Maybe.withDefault (BTreeUniformType.toNothing tree) (fn tree)


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
