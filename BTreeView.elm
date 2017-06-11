-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)

import BTree exposing (BTree, toTreeDiagramTree)
import BTree exposing (NodeTag(..))
import BTreeUniformType exposing (BTreeUniformType(..), toTaggedNodes)
import BTreeVariedType exposing (BTreeVariedType(..))
import MusicNote exposing (displayString)

import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)
import Constants exposing (nothingString)

import Color exposing (Color, green, orange, black, white, yellow, blue, purple, lightCharcoal, red)
import Collage exposing (group, segment, traced, rotate, move, scale, oval, rect, ngon, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)
import Arithmetic exposing (isEven)


bTreeUniformTypeDiagram : BTreeUniformType -> Html msg
bTreeUniformTypeDiagram bTreeUniformType =
    bTreeDiagram (toTaggedNodes bTreeUniformType)


bTreeVariedTypeDiagram : BTreeVariedType -> Html msg
bTreeVariedTypeDiagram (BTreeVaried taggedBTree) =
    bTreeDiagram taggedBTree


bTreeDiagram : BTree NodeTag -> Html msg
bTreeDiagram bTree =
    treeDiagram (toTreeDiagramTree bTree)


treeDiagram : TD.Tree (Maybe NodeTag) -> Html msg
treeDiagram tdTree =
    Element.toHtml <|
            draw
                { defaultTreeLayout | padding = 60, siblingDistance = 80 }
                drawNode
                drawEdge
                tdTree


drawNode : Maybe NodeTag -> Form
drawNode mbNodeTag =
    case mbNodeTag of
        Just nodeTag ->
            case nodeTag of
                IntNode i ->
                    let
                        stringLength = String.length (toString i)
                        width = toFloat (30 + (10 * stringLength))
                        height = 30

                        colorizer : Int -> Color
                        colorizer i =
                            if Arithmetic.isEven i
                                then green
                                else orange
                    in
                        group
                            [ oval width height |> filled (colorizer i)
                            , oval width height |> outlined treeLineStyle
                            , toString i |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                StringNode s ->
                    let
                        stringLength = String.length s
                        width = toFloat (30 + (10 * stringLength))
                        height = 30

                        colorizer : String -> Color
                        colorizer s =
                            if Arithmetic.isEven stringLength
                                then yellow
                                else blue
                    in
                        group
                            [ rect width height |> filled (colorizer s)
                            , rect width height |> outlined treeLineStyle
                            , s |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                BoolNode b ->
                    let
                        displayString : Bool -> String
                        displayString bool =
                            if bool
                                then "T"
                                else "F"

                        colorizer : Bool -> Color
                        colorizer bool =
                            if bool
                                then lightCharcoal
                                else black
                    in
                        group
                            [ ngon 6 20 |> filled (colorizer b)
                            , ngon 6 20 |> outlined treeLineStyle
                            , displayString b |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                MusicNoteNode mbNote ->
                    case mbNote of
                        Just note ->
                            group
                                [ ngon 5 25 |> filled (purple)
                                , ngon 5 25 |> outlined treeLineStyle
                                , displayString note |> fromString |> style treeNodeStyle |> text |> moveY 4
                                ]

                        Nothing ->
                            drawNothingNode

                NothingNode ->
                    group
                        [ oval 40 40 |> filled (red)
                        , oval 40 40 |> outlined treeLineStyle
                        , nothingString |> fromString |> style treeNodeStyle |> text |> moveY 4
                        ]

        Nothing ->
            toForm Element.empty


drawNothingNode : Form
drawNothingNode =
    drawNode (Just NothingNode)


drawEdge : ( Float, Float ) -> Form
drawEdge ( x, y ) =
    let
        arrowOffset =
            30

        theta =
            atan (y / x)

        rot =
            if x > 0 then
                theta
            else
                pi + theta

        dist =
            (sqrt (x ^ 2 + y ^ 2)) - 15

        scale =
            ((dist - arrowOffset) / dist)

        to =
            (scale * x, scale * y)
    in
        group
            [ segment ( 0, 0 ) to |> traced treeLineStyle
            , arrow |> move to |> rotate rot
            ]


treeNodeStyle : Text.Style
treeNodeStyle =
    { defaultStyle
        | color = white
        , height = Just 15
        , typeface = [ "Times New Roman", "serif" ]
    }


treeNilStyle : Text.Style
treeNilStyle =
    { defaultStyle | color = white, height = Just 20 }


treeLineStyle : LineStyle
treeLineStyle =
    { defaultLine | width = 1 }


arrow : Form
arrow =
    polygon [ ( -1, 1 ), ( 1, 0 ), ( -1, -1 ), ( -0.5, 0 ) ] |> filled black |> scale 4