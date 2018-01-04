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
import BTreeUniform exposing (BTreeUniform(..), displayString)
import BTreeVaried exposing (BTreeVaried(..), displayString)
import BTreeView exposing (bTreeDiagram, intNodeEvenColor, intNodeOddColor, unsafeColor)
import Lib exposing (IntFlex(..))
import MaybeSafe exposing (MaybeSafe(..))
------------------------------------------------

type CardWidth
    = Full
    | Half


uniformIntTreeOfInterest : Model -> BTreeUniform
uniformIntTreeOfInterest model =
    if model.isTreeMorphing then
        model.intTreeMorph
    else
        UniformInt model.intTree


uniformBigIntTreeOfInterest : Model -> BTreeUniform
uniformBigIntTreeOfInterest model =
    if model.isTreeMorphing then
        model.bigIntTreeMorph
    else
        UniformBigInt model.bigIntTree


uniformStringTreeOfInterest : Model -> BTreeUniform
uniformStringTreeOfInterest model =
    if model.isTreeMorphing then
        model.stringTreeMorph
    else
        UniformString model.stringTree


uniformBoolTreeOfInterest : Model -> BTreeUniform
uniformBoolTreeOfInterest model =
    if model.isTreeMorphing then
        model.boolTreeMorph
    else
        UniformBool model.boolTree


uniformMusicNoteTreeOfInterest : Model -> BTreeUniform
uniformMusicNoteTreeOfInterest model =
    if model.isTreeMorphing then
        model.musicNoteTreeMorph
    else
        UniformMusicNotePlayer model.musicNoteTree


intTreeCards : Model -> List (Html msg)
intTreeCards model =
    let
        uniformIntTreesOfInterest = case model.intView of
            IntView -> [uniformIntTreeOfInterest model]
            BigIntView -> [uniformBigIntTreeOfInterest model]
            BothView -> [uniformIntTreeOfInterest model, uniformBigIntTreeOfInterest model]

        cardWidth = case model.intView of
            BothView -> Half
            _ -> Full
    in
        List.map (\tree -> viewUniformTreeCard cardWidth tree) uniformIntTreesOfInterest


viewTrees : Model -> Html Msg
viewTrees model =
    let
        cardWidth = Full

        cards = List.concat
            [   [ viewUniformTreeCard cardWidth <| uniformMusicNoteTreeOfInterest model
                ]
            ,   intTreeCards model
            ,   [ viewUniformTreeCard cardWidth <| uniformStringTreeOfInterest model
                , viewUniformTreeCard cardWidth <| uniformBoolTreeOfInterest model
                , viewVariedTreeCard cardWidth model.variedTree
                ]
            ]
    in
        section
            [ classes
                [ T.cf
                --, T.relative
                --, T.top_2
               ]
            ]
            cards


viewUniformTreeCard : CardWidth -> BTreeUniform -> Html msg
viewUniformTreeCard cardWidth bTreeUniform =
    let
        title = BTreeUniform.displayString bTreeUniform
        status = bTreeUniformStatus bTreeUniform
        mbLegend = bTreeUniformLegend bTreeUniform
        mbBgColor = Nothing
        diagram = bTreeDiagram <| Uniform bTreeUniform
    in
        viewTreeCard cardWidth title status mbLegend mbBgColor diagram


viewVariedTreeCard : CardWidth -> BTreeVaried -> Html msg
viewVariedTreeCard cardWidth bTreeVaried =
    let
        title = BTreeVaried.displayString bTreeVaried
        status = bTreeVariedStatus bTreeVaried
        mbLegend = bTreeVariedLegend bTreeVaried
        mbBgColor = Just T.bg_black_05
        diagram = bTreeDiagram <| Varied bTreeVaried
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



bTreeUniformStatus : BTreeUniform -> Html msg
bTreeUniformStatus bTreeUniform =
    let
        depth = BTreeUniform.depth bTreeUniform
        mbIntFlex = BTreeUniform.sumInt bTreeUniform
    in
        treeStatus depth mbIntFlex


bTreeVariedStatus : BTreeVaried -> Html msg
bTreeVariedStatus (BTreeVaried bTree) =
    let
        depth = BTree.depth bTree
        mbMbsSum = Nothing
    in
        treeStatus depth mbMbsSum


bTreeUniformLegend : BTreeUniform -> Maybe (Html msg)
bTreeUniformLegend bTreeUniform =
    case bTreeUniform of
        UniformInt _ ->
            Just bTreeIntCardLegend

        UniformBigInt _ ->
            Just bTreeBigIntCardLegend

        UniformString _ ->
            Nothing

        UniformBool _ ->
            Nothing

        UniformMusicNotePlayer _ ->
            Nothing

        UniformNothing _ ->
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


bTreeVariedLegend : BTreeVaried -> Maybe (Html msg)
bTreeVariedLegend bTreeVaried =
    if BTreeVaried.hasAnyIntNodes bTreeVaried
        then Just bTreeIntCardLegend
        else Nothing


viewTreeCard : CardWidth -> String -> Html msg -> Maybe (Html msg) -> Maybe String -> Html msg -> Html msg
viewTreeCard cardWidth title status mbLegend mbBgColor diagram =
    let
        tachyonsPartialWidth = case cardWidth of
            Full -> T.w_20_l
            Half -> T.w_10_l

        articleTachyons =
            [ T.fl
            , T.w_100
            , tachyonsPartialWidth
            , T.br2
            , T.ba
            , T.b__black_10
            , T.center
            , T.overflow_x_scroll
            ] ++ (Maybe.Extra.unwrap [] List.singleton mbBgColor)
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