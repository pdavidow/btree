-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

module BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram)

import BTree exposing (BTree, toTreeDiagramTree)
import BTree exposing (NodeTag(..))
import BTreeUniformType exposing (BTreeUniformType(..), toTaggedNodes)
import BTreeVariedType exposing (BTreeVariedType(..))
import MusicNote exposing (displayString)
import MusicNotePlayer exposing (MusicNotePlayer(..))

import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)
import UniversalConstants exposing (nothingString, unsafeString)

import Color exposing (Color, green, orange, black, white, yellow, blue, purple, lightCharcoal, red)
import Collage exposing (group, segment, traced, rotate, move, scale, oval, rect, ngon, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element exposing (Element)
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
    bTree
        |> toTreeDiagramTree
        |> treeElement
        |> Element.toHtml


treeElement : Maybe (TD.Tree (Maybe NodeTag)) -> Element
treeElement mbTdTree =
    case mbTdTree of
        Nothing ->
            Element.empty

        Just (tdTree) ->
            draw
                { defaultTreeLayout
                | padding = 100
                , siblingDistance = 80
                }
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
                    in
                        group
                            [ rect width height |> filled blue
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

                MusicNoteNode (MusicNotePlayer params) ->
                    case params.mbNote of
                        Just note ->
                            let
                                outlineStyle = if params.isPlaying
                                    then treeLineHighlightStyle
                                    else treeLineStyle
                            in
                                group
                                    [ ngon 5 25 |> filled (purple)
                                    , ngon 5 25 |> outlined outlineStyle
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

                UnsafeNode ->
                    group
                        [ rect 55 30 |> filled (red)
                        , rect 55 30 |> outlined treeLineStyle
                        , unsafeString |> fromString |> style treeNodeStyle |> text |> moveY 4
                        ]

        Nothing ->
            toForm Element.empty


drawNothingNode : Form
drawNothingNode =
    drawNode (Just NothingNode)


drawEdge : ( Float, Float ) -> Form
drawEdge ( x, y ) =
    group [segment (0, 0) (x, y) |> traced treeLineStyle]


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


treeLineHighlightStyle : LineStyle
treeLineHighlightStyle =
    { defaultLine | width = 4 }
