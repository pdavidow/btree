module Dashboard exposing (viewDashboardWithTreesUnderneath)

import Html exposing (Html, Attribute , div, span, header, main_, section, article, a, button, option, select, text, input, h1, h2, label, programWithFlags)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onMouseEnter, onMouseLeave, onMouseOver, onMouseOut, onInput)
import Html.Attributes as A exposing (attribute, property, class, checked, selected, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import EveryDict exposing (EveryDict, fromList, get, update)
import Json.Decode as Decode exposing (Decoder)

import Model exposing (Model)
import Msg exposing (Msg(..))
import IntView exposing (IntView(..))
import DropdownAction exposing (DropdownAction(..))
import BTreeUniformType exposing (BTreeUniformType(..), toLength, toIsIntPrime, nodeValOperate, setTreePlayerParams, displayString, musicNotePlayerParams)
import NodeValueOperation exposing (Operation(..))
import BTree exposing (Direction(..), TraversalOrder(..))
import TreeCard exposing (viewTrees)
import TreePlayerParams exposing (PlaySpeed(..), playSpeedOptions)
------------------------------------------------

viewDashboardWithTreesUnderneath : Model -> Html Msg
viewDashboardWithTreesUnderneath model =
    let
        isPlayDisabled = not <| isEnablePlayNotesWidgetry model

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
                _ -> Decode.fail "Invalid speed"
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
                            [ classes
                                ([ T.hover_bg_light_green
                                ] ++ (if Maybe.withDefault False (EveryDict.get Play model.isShowDropdown) then [T.bg_light_green] else []))
                            , disabled isPlayDisabled
                            , onMouseEnter <| MouseEnteredButton Play
                            , onMouseLeave <| MouseLeftButton Play
                            ]
                            [ text "Play" ]
                        , div
                            [ classes
                                 [ T.absolute
                                 , (if Maybe.withDefault False (EveryDict.get Play model.isShowDropdown) then T.db else T.dn)
                                 , T.ba
                                 , T.w5
                                 ]
                            , onMouseEnter <| MouseEnteredDropdown Play
                            , onMouseLeave <| MouseLeftDropdown Play
                            ]
                            [ button
                                [ classes
                                    [ T.db
                                    , T.hover_bg_light_green
                                    , T.pa2
                                    , T.tl
                                    , T.w_100
                                    ]
                                , disabled isPlayDisabled
                                , onClick <| PlayNotes PreOrder
                                ]
                                [text "Pre-Order"]
                            , button
                                [ classes
                                    [ T.db
                                    , T.hover_bg_light_green
                                    , T.pa2
                                    , T.w_100
                                    , T.tl
                                    ]
                                , disabled isPlayDisabled
                                , onClick <| PlayNotes InOrder
                                ]
                                [text "In-Order"]
                            , button
                                [ classes
                                    [ T.db
                                    , T.hover_bg_light_green
                                    , T.pa2
                                    , T.tl
                                    , T.w_100
                                    ]
                                , disabled isPlayDisabled
                                , onClick <| PlayNotes PostOrder
                                ]
                                [text "Post-Order"]
                            ]
                        , button
                            [ classes
                                [ T.hover_bg_light_green]
                            , disabled <| not model.isPlayNotes
                            , onClick StopPlayNotes
                            ]
                            [ text "Stop Play" ]
                        , select
                            [ onPlaySpeedChange, disabled model.isPlayNotes ]
                            ( List.map
                                ( \playSpeed ->
                                    let
                                        isSelected = (model.masterPlaySpeed == playSpeed)
                                    in
                                        option
                                            [selected isSelected]
                                            [text <| toString playSpeed]
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
                            ([ T.hover_bg_light_green
                            ] ++ (if Maybe.withDefault False (EveryDict.get Sort model.isShowDropdown) then [T.bg_light_green] else []))
                        , disabled model.isPlayNotes
                            , onMouseEnter <| MouseEnteredButton Sort
                            , onMouseLeave <| MouseLeftButton Sort
                        ]
                        [ text "Sort" ]
                    , div
                        [ classes
                             [ T.absolute
                             , (if Maybe.withDefault False (EveryDict.get Sort model.isShowDropdown) then T.db else T.dn)
                             , T.ba
                             , T.w5
                             ]
                            , onMouseEnter <| MouseEnteredDropdown Sort
                            , onMouseLeave <| MouseLeftDropdown Sort
                        ]
                        [ button
                            [ classes
                                [ T.db
                                , T.hover_bg_light_green
                                , T.pa2
                                , T.w_100
                                , T.tl
                                ]
                            , disabled model.isPlayNotes
                            , onClick <| SortUniformTrees Left
                            ]
                            [text "Left"]
                        , button
                            [ classes
                                [ T.db
                                , T.hover_bg_light_green
                                , T.pa2
                                , T.w_100
                                , T.tl
                                ]
                            , disabled model.isPlayNotes
                            , onClick <| SortUniformTrees Right
                            ]
                            [text "Right"]
                        ]
                    ]
                , button
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
                        [ classes
                            ([ T.hover_bg_light_green
                            ] ++ (if Maybe.withDefault False (EveryDict.get Random model.isShowDropdown) then [T.bg_light_green] else []))
                            , onMouseEnter <| MouseEnteredButton Random
                            , onMouseLeave <| MouseLeftButton Random
                        ]
                        [ text "Random Trees" ]
                    , div
                        [ classes
                             [ T.absolute
                             , (if Maybe.withDefault False (EveryDict.get Random model.isShowDropdown) then T.db else T.dn)
                             , T.ba
                             , T.w5
                             ]
                            , onMouseEnter <| MouseEnteredDropdown Random
                            , onMouseLeave <| MouseLeftDropdown Random
                        ]
                        [ button
                            [ classes
                                [ T.db
                                , T.hover_bg_light_green
                                , T.pa2
                                , T.w_100
                                , T.tl
                                ]
                            , onClick RequestRandomTreesWithRandomInsertDirection
                            ]
                            [text "Insert Random L/R"]
                        , div -- divider line
                            [ classes
                                [ T.db
                                , T.w_100
                                , T.bt
                                , T.bw1
                                ]
                            ]
                            []
                        , button
                            [ classes
                                [ T.db
                                , T.hover_bg_light_green
                                , T.pa2
                                , T.w_100
                                , T.tl
                                ]
                            , onClick <| RequestRandomTrees Left
                            ]
                            [text "Insert Left"]
                        , button
                            [ classes
                                [ T.db
                                , T.hover_bg_light_green
                                , T.pa2
                                , T.w_100
                                , T.tl
                                ]
                            , onClick <| RequestRandomTrees Right
                            ]
                            [text "Insert Right"]
                        ]
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
            , button
                [classes [T.fr, T.hover_bg_light_yellow, T.mv1, T.mr2], onClick Reset]
                [text "Reset"]
            ]
        , viewTrees model
        ]


isEnablePlayNotesWidgetry : Model -> Bool
isEnablePlayNotesWidgetry model =
    not (model.isPlayNotes) && not (BTreeUniformType.isAllNothing model.musicNoteTree)


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
