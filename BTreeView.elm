-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (..)

import BTree exposing (BTree, toTreeDiagramTree)
import BTreeUniformContent exposing (BTreeUniformContent(..))
import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)

import Color exposing (Color, green, orange, black, white)
import Collage exposing (group, segment, traced, rotate, move, scale, circle, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)
import Arithmetic exposing (isEven)


-- Can this be simplified with pattern matching?
bTreeUniformContentDiagram : BTreeUniformContent -> Html msg
bTreeUniformContentDiagram btreeUniformContent =
    case btreeUniformContent of
        BTreeInt btree ->
            bTreeDiagram btree

        BTreeString btree ->
            bTreeDiagram btree


bTreeDiagram : BTree a -> Html msg
bTreeDiagram bTree =
    let
        tdTree = toTreeDiagramTree bTree
    in
        treeDiagram tdTree


treeDiagram : TD.Tree (Maybe a) -> Html msg
treeDiagram tdTree =
    Element.toHtml <|
            draw
                { defaultTreeLayout | padding = 60, siblingDistance = 80 }
                drawNode
                drawEdge
                tdTree


colorizer : Int -> Color
colorizer n =
    if Arithmetic.isEven n
        then green
        else orange


drawNode : Maybe a -> Form
drawNode maybeishN =
    case maybeishN of
        Just n ->
            group
                [ circle 27 |> filled black -- (colorizer n)
                , circle 27 |> outlined treeLineStyle
                , toString n |> fromString |> style treeNodeStyle |> text |> moveY 4
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