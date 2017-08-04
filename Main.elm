module Main exposing (..)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, label, programWithFlags)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onMouseLeave, onInput)
import Html.Attributes as A exposing (class, checked, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Maybe.Extra exposing (unwrap)
import List.Extra exposing (last)
import Random
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)
import Lazy exposing (lazy)
import BigInt exposing (fromInt)

import BTreeUniformType exposing (BTreeUniformType(..), toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes)
import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, hasAnyIntNodes)
import BTree exposing (BTree(..), fromListBy, fromListAsIs, singleton, toTreeDiagramTree)
import NodeTag exposing (NodeTag(..))
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram, intNodeEvenColor, intNodeOddColor, unsafeColor)
import UniversalConstants exposing (nothingString)
import MusicNote exposing (MusicNote(..), mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter)
import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote)
import Ports exposing (port_startPlayNote, port_donePlayNote, port_donePlayNotes)
import Lib exposing (IntFlex(..), lazyUnwrap)
import MaybeSafe exposing (MaybeSafe(..), maxSafeInt, toMaybeSafeInt)
------------------------------------------------


type IntView
    = Int
    | BigInt
    | Both


type Msg
    = Increment
    | Decrement
    | Raise
    | SortUniformTrees
    | RemoveDuplicates
    | Delta String
    | Exponent String
    | RequestRandomIntList
    | ReceiveRandomIntList (List Int)
    | RequestRandomDelta
    | ReceiveRandomDelta Int
    | StartShowLength
    | StopShowLength
    | StartShowIsIntPrime
    | StopShowIsIntPrime
    | PlayNotes
    | StartPlayNote (String)
    | DonePlayNote (String)
    | DonePlayNotes (Bool)
    | SwitchToIntView (IntView)
    | Reset


type alias Model =
    { intTree : BTreeUniformType
    , bigIntTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , initialMusicNoteTree : BTreeUniformType
    , musicNoteTree : BTreeUniformType
    , variedTree : BTreeVariedType
    , intTreeCache : BTreeUniformType
    , bigIntTreeCache : BTreeUniformType
    , stringTreeCache : BTreeUniformType
    , boolTreeCache : BTreeUniformType
    , musicNoteTreeCache : BTreeUniformType
    , variedTreeCache : BTreeVariedType
    , delta : Int
    , exponent : Int
    , isPlayNotes : Bool
    , isTreeCaching : Bool
    , intView : IntView
    , uuidSeed : Seed
    }


initialModel: Model
initialModel =
    { intTree = BTreeInt <| Node (toMaybeSafeInt <| maxSafeInt) (singleton <| toMaybeSafeInt 4) (Node (toMaybeSafeInt -9) Empty (singleton <| toMaybeSafeInt 4))
    , bigIntTree = BTreeBigInt <| Node (BigInt.fromInt <| maxSafeInt) (singleton <| BigInt.fromInt 4) (Node (BigInt.fromInt -9) Empty (singleton <| BigInt.fromInt 4))
    , stringTree = BTreeString <| Node "maxSafeInt" (singleton "four") (Node "-nine" Empty (singleton "four"))
    , boolTree = BTreeBool <| Node (Just True) (singleton <| Just True) (singleton <| Just False)
    , initialMusicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , musicNoteTree = BTreeMusicNotePlayer Empty -- placeholder
    , variedTree = BTreeVaried <| Node (BigIntNode <| BigInt.fromInt maxSafeInt) (Node (StringNode "A") (singleton <| MusicNoteNode <| MusicNotePlayer.on A) (singleton <| IntNode <| toMaybeSafeInt 123)) ((Node (BoolNode <| Just True)) (singleton <| MusicNoteNode <| MusicNotePlayer.on A) (singleton <| BoolNode <| Just True))
    , intTreeCache = BTreeInt Empty
    , bigIntTreeCache = BTreeBigInt Empty
    , stringTreeCache = BTreeString Empty
    , boolTreeCache = BTreeBool Empty
    , musicNoteTreeCache = BTreeMusicNotePlayer Empty
    , variedTreeCache = BTreeVaried Empty
    , delta = 1
    , exponent = 2
    , isPlayNotes = False
    , isTreeCaching = False
    , intView = Int
    , uuidSeed = initialSeed 0 -- placeholder
    }


generateIds : Int -> Seed -> ( List Uuid, Seed )
generateIds count startSeed =
    let
        generate = \seed -> step uuidGenerator seed

        fn : Maybe a -> ( Uuid, Seed ) -> ( Uuid, Seed )
        fn = \a ( id, seed ) -> generate seed

        tuples =
            List.repeat (count - 1) Nothing
                |> List.scanl fn (generate startSeed)

        ids = List.map Tuple.first tuples

        lazyDefault = Lazy.lazy (\() -> ( Tuple.first (generate startSeed), startSeed ))

        currentSeed =
            tuples
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
            , T.f2
            , T.ph3
            , T.pv2
            , T.b
            , T.pl2
            , T.pr2
            , T.z_max
            , T.tc
            ]
        ]
        [ span
            [ classes
                [ T.black
                , T.bg_light_green
                , T.hover_light_green
                , T.hover_bg_black
                ]
            ]
            [ text "BinaryTree" ]
        , span
            [ classes
                [ T.light_green
                , T.bg_black
                , T.hover_black
                , T.hover_bg_light_green
                , ml2
                ]
            ]
            [ text "Playground" ]
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
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onClick RemoveDuplicates, disabled model.isPlayNotes]
            [text "Dedup"]
        ]
    , span
        [classes [T.ml2, T.mr2]]
        [ button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onMouseDown StartShowIsIntPrime, onMouseUp StopShowIsIntPrime, onMouseLeave StopShowIsIntPrime]
            [text "Prime?"]
        , button
            [classes [T.hover_bg_light_green, T.mt1, T.mb1], onMouseDown StartShowLength, onMouseUp StopShowLength, onMouseLeave StopShowLength]
            [text "Length"]
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
    [ span
        []
        (viewInputs model)
    , span
        [classes [T.pl3]]
        (viewIntTreeChoice model)
    ]


viewInputs : Model -> List (Html Msg)
viewInputs model =
    [ span
        []
        [ text "Delta: "
        , input
            [ classes [T.f4, T.w3]
            , A.type_ "number"
            , A.min "1"
            , value (toString model.delta)
            , onInput Delta
            ]
            []
        ]
    , span
        [classes [T.pl3]]
        [ text "Exp: "
        , input
            [ classes [T.f4, T.w3]
            , A.type_ "number"
            , A.min "1"
            , value (toString model.exponent)
            , onInput Exponent
            ]
            []
        ]
    ]


radio : String -> String -> msg -> Html msg
radio value currentSelection msg =
    label
        [ classes [T.pa2] ]
        [ input
            [ type_ "radio"
            , checked <| currentSelection == value
            , onClick msg
            ]
            []
        , text value
        ]


viewIntTreeChoice : Model -> List (Html Msg)
viewIntTreeChoice model =
    let
        currentSelection = toString model.intView
    in
        [ span
            [ classes [T.pt1, T.pb1, T.mt2, T.mb2, T.f6, T.ba, T.br2] ]
            [ radio "Int" currentSelection (SwitchToIntView Int)
            , radio "BigInt" currentSelection (SwitchToIntView BigInt)
            , radio "Both" currentSelection (SwitchToIntView Both)
            ]
        ]


viewTrees : Model -> Html Msg
viewTrees model =
    let
        intTreesOfInterest = case model.intView of
            Int -> [model.intTree]
            BigInt -> [model.bigIntTree]
            Both -> [model.intTree, model.bigIntTree]

        intTreeCards = List.map viewUniformTreeCard intTreesOfInterest

        cards = List.concat
            [   [ viewUniformTreeCard model.musicNoteTree
                ]
            ,   intTreeCards
            ,   [ viewUniformTreeCard model.stringTree
                , viewUniformTreeCard model.boolTree
                , viewVariedTreeCard model.variedTree
                ]
            ]
    in
        section
            [ classes
                [ T.cf
                , T.pv6
                , T.flex_auto
                , T.bg_washed_green
               ]
            ]
            cards


viewUniformTreeCard : BTreeUniformType -> Html msg
viewUniformTreeCard bTreeUniformType =
    let
        title = bTreeUniformTitle bTreeUniformType
        status = bTreeUniformStatus bTreeUniformType
        mbLegend = bTreeUniformLegend bTreeUniformType
        mbBgColor = Nothing
        diagram = bTreeUniformTypeDiagram bTreeUniformType
    in
        viewTreeCard title status mbLegend mbBgColor diagram


viewVariedTreeCard : BTreeVariedType -> Html msg
viewVariedTreeCard bTreeVariedType =
    let
        title = "BTreeVaried"
        status = bTreeVariedStatus bTreeVariedType
        mbLegend = bTreeVariedLegend bTreeVariedType
        mbBgColor = Just T.bg_black_05
        diagram = bTreeVariedTypeDiagram bTreeVariedType
    in
        viewTreeCard title status mbLegend mbBgColor diagram


depthStatus : Int -> String
depthStatus depth =
    "depth " ++ toString depth


bTreeUniformTitle : BTreeUniformType -> String
bTreeUniformTitle bTreeUniformType =
    bTreeUniformType
        |> toString
        |> String.split " "
        |> List.head
        |> Maybe.withDefault ""


treeStatus : Int -> Maybe IntFlex -> Html msg
treeStatus depth mbIxSum =
    let
        sumDisplay =
            let
                okSum = \string ->
                    span
                        []
                        [ text string]

                result = \ixSum ->
                    case ixSum of
                        IntVal mbsInt ->
                            case mbsInt of
                                Unsafe ->
                                    span
                                        [ classes [unsafeColor] ]
                                        [ text "unsafe" ]
                                Safe sum ->
                                    okSum <| Basics.toString sum
                        BigIntVal sum ->
                            okSum <| BigInt.toString sum
            in
                Maybe.Extra.unwrap
                    [span [][]]
                    (\ixSum ->
                        [ span
                            []
                            [ text "; sum " ]
                        , result ixSum
                        ]
                    )
                    mbIxSum
    in
        article
            [ classes
                [ T.f5
                , T.fw4
                , T.mt0
                , T.black
                ]
            ]
            (
            [ span
                []
                [ text <| depthStatus depth ]
            ]
            ++ sumDisplay
            )



bTreeUniformStatus : BTreeUniformType -> Html msg
bTreeUniformStatus bTreeUniformType =
    let
        depth = BTreeUniformType.depth bTreeUniformType
        mbIntFlex = BTreeUniformType.sumInt bTreeUniformType
    in
        treeStatus depth mbIntFlex


bTreeVariedStatus : BTreeVariedType -> Html msg
bTreeVariedStatus (BTreeVaried bTree) =
    let
        depth = BTree.depth bTree
        mbMbsSum = Nothing
    in
        treeStatus depth mbMbsSum


bTreeUniformLegend : BTreeUniformType -> Maybe (Html msg)
bTreeUniformLegend bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just bTreeIntCardLegend

        BTreeBigInt bTree ->
            Just bTreeBigIntCardLegend

        BTreeString bTree ->
            Nothing

        BTreeBool bTree ->
            Nothing

        BTreeMusicNotePlayer bTree ->
            Nothing

        BTreeNothing bTree ->
            Nothing


bTreeBigIntCardLegend : Html msg
bTreeBigIntCardLegend =
    bTreeIntCardLegend


bTreeIntCardLegend : Html msg
bTreeIntCardLegend =
    article
        [ classes
            [ T.i
            , T.b
            , T.tc
            , T.center
            , T.f5
            , T.pa1
            ]
        ]
        [ span
            [ classes
                [T.black
                ]
            ]
            [ text "Legend: " ]
        , span
            [ classes
                [intNodeEvenColor
                ]
            ]
            [ text "Even " ]
        , span
            [ classes
                [intNodeOddColor
                ]
            ]
            [ text "Odd" ]
        ]


bTreeVariedLegend : BTreeVariedType -> Maybe (Html msg)
bTreeVariedLegend bTreeVariedType =
    if BTreeVariedType.hasAnyIntNodes bTreeVariedType
        then Just bTreeIntCardLegend
        else Nothing


viewTreeCard : String -> Html msg -> Maybe (Html msg) -> Maybe String -> Html msg -> Html msg
viewTreeCard title status mbLegend mbBgColor diagram =
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
            ]  ++ (Maybe.Extra.unwrap [] List.singleton mbBgColor)
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
                        , T.black
                        ]
                    ]
                    [ text title ]
                , status
                , article
                    [ classes
                        [ T.mt0
                        , T.pl2
                        ]
                    ]
                    [ diagram ]
                , article
                    [ classes
                        [ T.center
                        ]
                    ]
                    [ Maybe.withDefault (span[][]) mbLegend ]
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

        RemoveDuplicates ->
            ( model
                |> deDuplicate
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
                maxRandomInt = 999
                minListLength = 3
                maxListLength = 9

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
                | intTree = BTreeInt <| BTree.fromListAsIs <| List.map toMaybeSafeInt list
                , bigIntTree = BTreeBigInt <| BTree.fromListAsIs <| List.map BigInt.fromInt list
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
            (   { model
                | isTreeCaching = True
                }
                    |> cacheAllTrees
                    |> morphUniformTrees BTreeUniformType.toIsIntPrime
                    |> morphVariedTrees BTreeVariedType.toIsIntPrime
            , Cmd.none
            )

        StopShowIsIntPrime ->
            let
                newModel = if model.isTreeCaching
                    then
                        { model
                        | isTreeCaching = False
                        }
                            |> unCacheAllTrees
                    else
                        model
            in
                ( newModel
                , Cmd.none
                )

        StartShowLength ->
            (   { model
                | isTreeCaching = True
                }
                    |> cacheAllTrees
                    |> morphUniformTrees BTreeUniformType.toLength
                    |> morphVariedTrees BTreeVariedType.toLength
            , Cmd.none
            )

        StopShowLength ->
            let
                newModel = if model.isTreeCaching
                    then
                        { model
                        | isTreeCaching = False
                        }
                            |> unCacheAllTrees
                    else
                        model
            in
                ( newModel
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

        SwitchToIntView intView ->
            (   { model
                | intView = intView
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
        , bigIntTreeCache = model.bigIntTree
        , stringTreeCache = model.stringTree
        , boolTreeCache = model.boolTree
        , musicNoteTreeCache = model.musicNoteTree
        , variedTreeCache = model.variedTree
    }


unCacheAllTrees : Model -> Model
unCacheAllTrees model =
    {model
        | intTree = model.intTreeCache
        , bigIntTree = model.bigIntTreeCache
        , stringTree = model.stringTreeCache
        , boolTree= model.boolTreeCache
        , musicNoteTree = model.musicNoteTreeCache
        , variedTree = model.variedTreeCache
    }


changeUniformTrees : (BTreeUniformType -> BTreeUniformType) -> Model -> Model
changeUniformTrees fn model =
    {model
        | intTree = fn model.intTree
        , bigIntTree = fn model.bigIntTree
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
    changeUniformTrees BTreeUniformType.sort model


deDuplicate : Model -> Model
deDuplicate model =
    model
        |> deDuplicateUniformTrees
        |> deDuplicateVariedTrees


deDuplicateUniformTrees : Model -> Model
deDuplicateUniformTrees model =
    let
        fn = BTreeUniformType.deDuplicate
    in
        changeUniformTrees fn model


deDuplicateVariedTrees : Model -> Model
deDuplicateVariedTrees model =
    let
        fn = BTreeVariedType.deDuplicate
    in
        changeVariedTrees fn model


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
