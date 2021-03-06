module Dashboard exposing (viewDashboardWithTreesUnderneath)

import Html exposing (Html, Attribute , div, span, header, main_, section, article, a, button, option, select, text, input, h1, h2, label, programWithFlags)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onMouseEnter, onMouseLeave, onMouseOver, onMouseOut, onInput)
import Html.Attributes as A exposing (attribute, property, class, checked, selected, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Dict exposing (Dict, fromList)
import Json.Decode as Decode exposing (Decoder)

import Model exposing (Model)
import Msg exposing (Msg(..))
import IntView exposing (IntView(..))
import BTreeUniform exposing (BTreeUniform(..), isAllNothing, displayString)
import NodeValueOperation exposing (Operation(..))
import BTree exposing (Direction(..), TraversalOrder(..), traversalOrderOptions, directionOptions)
import TreeCard exposing (viewTrees)
import TreePlayerParams exposing (PlaySpeed(..), playSpeedOptions)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle(..), treeRandomInsertStyleOptions)
------------------------------------------------

onTraversalOrderChange : Attribute Msg
onTraversalOrderChange =
    Html.Events.targetValue
        |> Decode.andThen traversalOrderDecoder
        |> Decode.map ChangeTraversalOrder
        |> Html.Events.on "change"


traversalOrderDecoder : String -> Decoder TraversalOrder
traversalOrderDecoder value =
    case String.toLower value of
        "inorder" -> Decode.succeed InOrder
        "preorder" -> Decode.succeed PreOrder
        "postorder" -> Decode.succeed PostOrder
        _ -> Decode.fail "Invalid TraversalOrder"


onPlaySpeedChange : Attribute Msg
onPlaySpeedChange =
    Html.Events.targetValue
        |> Decode.andThen playSpeedDecoder
        |> Decode.map ChangePlaySpeed
        |> Html.Events.on "change"


playSpeedDecoder : String -> Decoder PlaySpeed
playSpeedDecoder value =
    case String.toLower value of
        "fast" -> Decode.succeed Fast
        "medium" -> Decode.succeed Medium
        "slow" -> Decode.succeed Slow
        _ -> Decode.fail "Invalid PlaySpeed"


onSortDirectionChange : Attribute Msg
onSortDirectionChange =
    Html.Events.targetValue
        |> Decode.andThen directionDecoder
        |> Decode.map ChangeSortDirection
        |> Html.Events.on "change"


directionDecoder : String -> Decoder Direction
directionDecoder value =
    case String.toLower value of
        "right" -> Decode.succeed BTree.Right
        "left" -> Decode.succeed BTree.Left
        _ -> Decode.fail "Invalid Direction"


onTreeRandomInsertStyleChange : Attribute Msg
onTreeRandomInsertStyleChange =
    Html.Events.targetValue
        |> Decode.andThen treeRandomInsertStyleDecoder
        |> Decode.map ChangeTreeRandomInsertStyle
        |> Html.Events.on "change"


type alias InsertStyle_MenuOption =
    { display : String
    , style : TreeRandomInsertStyle
    }


insertStyle_MenuOptions : List InsertStyle_MenuOption
insertStyle_MenuOptions =
    [ InsertStyle_MenuOption "Insert Random L/R" TreeRandomInsertStyle.Random
    , InsertStyle_MenuOption "Insert Right" TreeRandomInsertStyle.Right
    , InsertStyle_MenuOption "Insert Left" TreeRandomInsertStyle.Left
    ]


insertStyleDisplayFor : TreeRandomInsertStyle -> String
insertStyleDisplayFor style =
    insertStyle_MenuOptions
        |> List.filter (\menuOption -> menuOption.style == style)
        |> List.head -- only one element anyway
        |> Maybe.withDefault (InsertStyle_MenuOption "should never get here" TreeRandomInsertStyle.Random)
        |> .display


insertStylesDict : Dict String TreeRandomInsertStyle
insertStylesDict =
    let
        fn = \obj -> (obj.display, obj.style)
    in
        Dict.fromList <| List.map fn insertStyle_MenuOptions


treeRandomInsertStyleDecoder : String -> Decoder TreeRandomInsertStyle
treeRandomInsertStyleDecoder value =
    Dict.get value insertStylesDict
        |> Maybe.map Decode.succeed
        |> Maybe.withDefault (Decode.fail "Invalid TreeRandomInsertStyle")


viewDashboardWithTreesUnderneath : Model -> Html Msg
viewDashboardWithTreesUnderneath model =
    let
        playButtonDisplay = if model.isPlayNotes then "Stop" else "Play"
    in
        section
            [ classes
                [ T.fixed
                , T.w_100
                , T.f3
                , T.z_max
               ]
            ]
            [ section
                [ classes
                    [ T.pa1
                    , T.bg_washed_yellow
                    ]
                ]
                [ span
                    [classes [T.mh2]]
                    [ div
                        [ classes
                            [ T.relative
                            , T.dib
                            ]
                        ]
                        [ button
                            [ classes [ T.hover_bg_light_green ]
                            , onClick TogglePlayNotes
                            , disabled <| isAllNothing <| UniformMusicNotePlayer model.musicNoteTree
                            ]
                            [ text playButtonDisplay ]
                        , select
                            [ onTraversalOrderChange
                            , disabled model.isPlayNotes
                            ]
                            ( List.map
                                ( \order ->
                                    let
                                        isSelected = (model.masterTraversalOrder == order)
                                    in
                                        option
                                            [selected isSelected]
                                            [text <| toString order]
                                )
                                traversalOrderOptions
                            )
                        , select
                            [ onPlaySpeedChange
                            , disabled model.isPlayNotes
                            ]
                            ( List.map
                                ( \speed ->
                                    let
                                        isSelected = (model.masterPlaySpeed == speed)
                                    in
                                        option
                                            [selected isSelected]
                                            [text <| toString speed]
                                )
                                playSpeedOptions
                            )
                        ]
                    ]
            , span
                [classes [T.mh2]]
                [ button
                    [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <|Increment model.delta, disabled model.isPlayNotes]
                    [text "+ Delta"]
                , button
                    [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <| Decrement model.delta, disabled model.isPlayNotes]
                    [text "- Delta"]
                , button
                    [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <| Raise model.exponent, disabled model.isPlayNotes]
                    [text "^ Exp"]
                ]
            , span
                [classes [T.mh2]]
                [ div
                    [ classes
                        [ T.relative
                        , T.dib
                        ]
                    ]
                    [ button
                        [ classes
                            [ T.hover_bg_light_green ]
                        , disabled model.isPlayNotes
                        , onClick SortUniformTrees
                        ]
                        [ text "Sort" ]
                    , select
                        [ onSortDirectionChange
                        , disabled model.isPlayNotes
                        ]
                        ( List.map
                            ( \direction ->
                                let
                                    isSelected = (model.directionForSort == direction)
                                in
                                    option
                                        [selected isSelected]
                                        [text <| toString direction]
                            )
                            directionOptions
                        )
                    ]
                ]
            , span
                [classes [T.mh2]]
                [ button
                    [classes [T.hover_bg_light_green, T.mv1], onClick RemoveDuplicates, disabled model.isPlayNotes]
                    [text "Dedup"]
                ]
            , span
                [classes [T.mh2]]
                [ button
                    [classes [T.hover_bg_light_green, T.mv1], onMouseDown StartShowIsIntPrime, onMouseUp StopShowIsIntPrime, onMouseLeave StopShowIsIntPrime]
                    [text "Prime?"]
                , button
                    [classes [T.hover_bg_light_green, T.mv1], onMouseDown StartShowLength, onMouseUp StopShowLength, onMouseLeave StopShowLength]
                    [text "Length"]
                ]
            , span
                [ classes [T.mh2] ]
                [ div
                    [ classes
                        [ T.relative
                        , T.dib
                        ]
                    ]
                    [ button
                        [ classes [ T.hover_bg_light_green ]
                        , onClick RequestRandomTrees
                        ]
                        [ text "Random Trees" ]
                    , select
                        [ onTreeRandomInsertStyleChange
                        , disabled model.isPlayNotes
                        ]
                        ( List.map
                            ( \style ->
                                option
                                    [selected <| model.treeRandomInsertStyle == style]
                                    [text <| insertStyleDisplayFor style]
                            )
                            treeRandomInsertStyleOptions
                        )
                    ]
                , button
                    [classes [T.hover_bg_light_green, T.mv1], onClick RequestRandomScalars]
                    [text "Random Scalars"]
                ]
            , span
                [classes [T.pl4]]
                (viewInputs model)
            , span
                [classes [T.pl4]]
                (viewIntTreeChoice model)
            , span
                [classes [T.pl4]]
                (viewHarmonyChoice model)                
            , button
                [classes [T.fr, T.hover_bg_light_yellow, T.mv1, T.mr2], onClick Reset]
                [text "Reset"]
            ]
        , viewTrees model
        ]


isEnablePlayNotesWidgetry : Model -> Bool
isEnablePlayNotesWidgetry model =
    not (model.isPlayNotes) && not (BTreeUniform.isAllNothing <| UniformMusicNotePlayer <| model.musicNoteTree)


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


radioIntView : IntView -> Model -> Html Msg
radioIntView intView model =
    let
        labelFor intView = case intView of
             IntView -> "Int"
             BigIntView -> "BigInt"
             BothView -> "Both"
    in
        label
            [ classes [T.pa2] ]
            [ input
                [ type_ "radio"
                , checked <| model.intView == intView
                , onClick (SwitchToIntView intView)
                ]
                []
            , text <| labelFor intView
            ]


viewIntTreeChoice : Model -> List (Html Msg)
viewIntTreeChoice model =
    [ span
        [ classes [T.ph2, T.pv2, T.mt2, T.mb2, T.f6, T.ba, T.br2] ]
        [ radioIntView IntView model
        , radioIntView BigIntView model
        , radioIntView BothView model
        ]
    ]


viewHarmonyChoice : Model -> List (Html Msg)
viewHarmonyChoice model =
    [ span
        [ classes [T.ph2, T.pv2, T.mt2, T.mb2, T.f6, T.ba, T.br2] ]
        [ label
            [ classes [T.pa2] ]
            [ input
                [ type_ "checkbox"
                , checked <| model.isHarmonize
                , onClick ToggleHarmonize
                , disabled model.isPlayNotes 
                ]
                []
            , text "Harmony"
            ]
        ]
    ]