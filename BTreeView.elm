-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (..)

import BTree exposing (BTree, toTreeDiagramTree)
import BTreeUniformContent exposing (BTreeUniformContent(..), NodeTag(..))
import BTreeUniformContent exposing (toTaggedBTree)
import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)

import Color exposing (Color, green, orange, black, white, yellow, blue)
import Collage exposing (group, segment, traced, rotate, move, scale, oval, rect, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)
import Arithmetic exposing (isEven)


bTreeUniformContentDiagram : BTreeUniformContent -> Html msg
bTreeUniformContentDiagram bTreeUniformContent =
    bTreeDiagram (toTaggedBTree bTreeUniformContent)


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
drawNode maybeishNodeTag =
    case maybeishNodeTag of
        Just nodeTag ->
            case nodeTag of
                IntNode i ->
                    let
                        stringLength = String.length (toString i)
                        width = toFloat (50 + (20 * stringLength))
                        height = 50

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
                        width = toFloat (50 + (10 * stringLength))
                        height = 50

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

        Nothing ->
            toForm Element.empty


drawEdge : ( Float, Float ) -> Form
drawEdge ( x, y ) =
    let
        arrowOffset =
            42

        theta =
            atan (y / x)

        rot =
            if x > 0 then
                theta
            else
                pi + theta

        dist =
            sqrt (x ^ 2 + y ^ 2)

        scale =
            (dist - arrowOffset) / dist

        to =
            ( scale * x, scale * y )
    in
        group
            [ segment ( 0, 0 ) to |> traced treeLineStyle
            , arrow |> move to |> rotate rot
            ]


treeNodeStyle : Text.Style
treeNodeStyle =
    { defaultStyle
        | color = white
        , height = Just 30
        , typeface = [ "Times New Roman", "serif" ]
    }


treeNilStyle : Text.Style
treeNilStyle =
    { defaultStyle | color = white, height = Just 20 }


treeLineStyle : LineStyle
treeLineStyle =
    { defaultLine | width = 2 }


arrow : Form
arrow =
    polygon [ ( -1, 1 ), ( 1, 0 ), ( -1, -1 ), ( -0.5, 0 ) ] |> filled black |> scale 10