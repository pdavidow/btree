-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (..)

import TreeDiagram exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)

import Color exposing (red, black, white)
import Collage exposing (segment, circle, filled, text, traced, defaultLine, Form)
import Element
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)


treeDiagram : TreeDiagram.Tree (Maybe a) -> Html msg
treeDiagram tdTree =
    Element.toHtml <|
            draw
                defaultTreeLayout
                drawNode
                drawEdge
                tdTree


-- COMMENT OUT THIS FUNCTION -----------------------------------------
isEven : Int -> Bool
isEven n =
    rem (n / 2) == 0
--}


drawNode : Maybe Int -> Form
drawNode n =
    circle 10 |> filled black


drawEdge : ( Float, Float ) -> Form
drawEdge ( x, y ) =
    let
        to = ( x, y )
            ( 10 * x, 10 * y )
    in
        segment ( 0, 0 ) to |> traced defaultLine
