-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (..)


import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)

import Color exposing (green, orange, black, white)
import Collage exposing (group, segment, traced, rotate, move, scale, circle, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)
import Arithmetic as Math exposing (isEven)

treeDiagram : TD.Tree (Maybe Int) -> Html msg
treeDiagram tdTree =
    Element.toHtml <|
            draw
                { defaultTreeLayout | padding = 60, siblingDistance = 80 }
                drawNode
                drawEdge
                tdTree


drawNode : Maybe Int -> Form
drawNode n =
    case n of
        Just n ->
            let
                color =
                    if Math.isEven n
                    then green
                    else orange
            in
                group
                    [ circle 27 |> filled color
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