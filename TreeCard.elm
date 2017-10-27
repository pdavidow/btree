module TreeCard exposing (viewTrees)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, label, programWithFlags)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Maybe.Extra exposing (unwrap)
import BigInt exposing (BigInt, fromInt)

import Model exposing (Model)
import Msg exposing (Msg)
import IntView exposing (IntView(..))
import BTree exposing (BTree, depth)
import TreeType exposing (TreeType(..))
import BTreeUniformType exposing (BTreeUniformType(..), displayString)
import BTreeVariedType exposing (BTreeVariedType(..), displayString)
import BTreeView exposing (bTreeDiagram, intNodeEvenColor, intNodeOddColor, unsafeColor)
import Lib exposing (IntFlex(..))
import MaybeSafe exposing (MaybeSafe(..))
------------------------------------------------

type CardWidth
    = Full
    | Half


intTreeCards : Model -> List (Html msg)
intTreeCards model =
    let
        intTreesOfInterest = case model.intView of
            IntView -> [model.intTree]
            BigIntView -> [model.bigIntTree]
            BothView -> [model.intTree, model.bigIntTree]

        cardWidth = case model.intView of
            BothView -> Half
            _ -> Full
    in
        List.map (\tree -> viewUniformTreeCard cardWidth tree) intTreesOfInterest


viewTrees : Model -> Html Msg
viewTrees model =
    let
        cardWidth = Full

        cards = List.concat
            [   [ viewUniformTreeCard cardWidth model.musicNoteTree
                ]
            ,   intTreeCards model
            ,   [ viewUniformTreeCard cardWidth model.stringTree
                , viewUniformTreeCard cardWidth model.boolTree
                , viewVariedTreeCard cardWidth model.variedTree
                ]
            ]
    in
        section
            [ classes
                [ T.cf
                , T.pt5
                , T.flex_auto
                --, T.bg_washed_green
               ]
            ]
            cards


viewUniformTreeCard : CardWidth -> BTreeUniformType -> Html msg
viewUniformTreeCard cardWidth bTreeUniformType =
    let
        title = BTreeUniformType.displayString bTreeUniformType
        status = bTreeUniformStatus bTreeUniformType
        mbLegend = bTreeUniformLegend bTreeUniformType
        mbBgColor = Nothing
        diagram = bTreeDiagram <| Uniform bTreeUniformType
    in
        viewTreeCard cardWidth title status mbLegend mbBgColor diagram


viewVariedTreeCard : CardWidth -> BTreeVariedType -> Html msg
viewVariedTreeCard cardWidth bTreeVariedType =
    let
        title = BTreeVariedType.displayString bTreeVariedType
        status = bTreeVariedStatus bTreeVariedType
        mbLegend = bTreeVariedLegend bTreeVariedType
        mbBgColor = Just T.bg_black_05
        diagram = bTreeDiagram <| Varied bTreeVariedType
    in
        viewTreeCard cardWidth title status mbLegend mbBgColor diagram


depthStatus : Int -> String
depthStatus depth =
    "depth " ++ toString depth


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
                            MaybeSafe.unwrap
                                (span
                                    [ classes [unsafeColor] ]
                                    [ text "unsafe" ]
                                )
                                (\sum -> okSum <| Basics.toString sum)
                                mbsInt
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
        BTreeInt _ ->
            Just bTreeIntCardLegend

        BTreeBigInt _ ->
            Just bTreeBigIntCardLegend

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ _ ->
            Nothing

        BTreeNothing _ ->
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


viewTreeCard : CardWidth -> String -> Html msg -> Maybe (Html msg) -> Maybe String -> Html msg -> Html msg
viewTreeCard cardWidth title status mbLegend mbBgColor diagram =
    let
        tachyonsPartialWidth = case cardWidth of
            Full -> T.w_20_ns
            Half -> T.w_10_ns

        articleTachyons =
            [ T.fl
            , T.w_100
            , tachyonsPartialWidth
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