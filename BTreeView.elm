module BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram, intNodeEvenColor, intNodeOddColor)

-- https://github.com/brenden/elm-tree-diagram/blob/master/examples/canvas/RedBlackTree.elm

import TreeDiagram as TD exposing (node, Tree, defaultTreeLayout)
import TreeDiagram.Canvas exposing (draw)

import Color exposing (Color)
import Collage exposing (group, segment, traced, rotate, move, scale, oval, rect, ngon, filled, outlined, text, rect, polygon, moveY, defaultLine, Form, toForm, LineStyle)
import Element exposing (Element, centered, toHtml)
import Html exposing (Html)
import Text exposing (fromString, style, defaultStyle)
import Arithmetic exposing (isEven)
import TachyonsColor exposing (TachyonsColor, tachyonsColorToColor)
import Tachyons.Classes as T exposing (..)

import BTree exposing (BTree, toTreeDiagramTree)
import BTree exposing (NodeTag(..))
import BTreeUniformType exposing (BTreeUniformType(..), toTaggedNodes)
import BTreeVariedType exposing (BTreeVariedType(..))
import MusicNote exposing (displayString)
import MusicNotePlayer exposing (MusicNotePlayer(..))
import UniversalConstants exposing (nothingString, unsafeString)
import MaybeSafe exposing (MaybeSafe(..))

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
            TreeDiagram.Canvas.draw
                { defaultTreeLayout
                | padding = 100
                , siblingDistance = 80
                }
                drawNode
                drawEdge
                tdTree


intNodeEvenColor : TachyonsColor
intNodeEvenColor =
    T.dark_green


intNodeOddColor : TachyonsColor
intNodeOddColor =
    T.orange


drawNode : Maybe NodeTag -> Form
drawNode mbNodeTag =
    case mbNodeTag of
        Just nodeTag ->
            case nodeTag of
                IntNode mbsInt ->
                    case mbsInt of
                        Unsafe ->
                            group
                                [ rect 55 30 |> filled (tachyonsColorToColor T.dark_red)
                                , rect 55 30 |> outlined treeLineStyle
                                , unsafeString |> fromString |> style treeNodeStyle |> text |> moveY 4
                                ]
                        Safe int ->
                            let
                                stringLength = String.length (toString int)
                                width = toFloat (30 + (10 * stringLength))
                                height = 30

                                colorizer : Int -> Color
                                colorizer int =
                                    tachyonsColorToColor <|
                                        if Arithmetic.isEven int
                                            then intNodeEvenColor
                                            else intNodeOddColor
                            in
                                group
                                    [ oval width height |> filled (colorizer int)
                                    , oval width height |> outlined treeLineStyle
                                    , toString int |> fromString |> style treeNodeStyle |> text |> moveY 4
                                    ]

                StringNode s ->
                    let
                        stringLength = String.length s
                        width = toFloat (30 + (10 * stringLength))
                        height = 30
                    in
                        group
                            [ rect width height |> filled (tachyonsColorToColor T.dark_blue)
                            , rect width height |> outlined treeLineStyle
                            , s |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                BoolNode mbBool ->
                    case mbBool of
                        Nothing ->
                            drawNothingNode

                        Just bool ->
                            let
                                displayString : Bool -> String
                                displayString bool =
                                    if bool
                                        then "T"
                                        else "F"

                                colorizer : Bool -> Color
                                colorizer bool =
                                    if bool
                                        then (tachyonsColorToColor T.gray)
                                        else (tachyonsColorToColor T.black)
                            in
                                group
                                    [ ngon 6 20 |> filled (colorizer bool)
                                    , ngon 6 20 |> outlined treeLineStyle
                                    , displayString bool |> fromString |> style treeNodeStyle |> text |> moveY 4
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
                                    [ ngon 5 25 |> filled (tachyonsColorToColor T.purple)
                                    , ngon 5 25 |> outlined outlineStyle
                                    , displayString note |> fromString |> style treeNodeStyle |> text |> moveY 4
                                    ]

                        Nothing ->
                            drawNothingNode

                NothingNode ->
                    group
                        [ oval 40 40 |> filled (tachyonsColorToColor T.dark_red)
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
    group [segment (0, 0) (x, y) |> traced treeLineStyle]


treeNodeStyle : Text.Style
treeNodeStyle =
    { defaultStyle
        | color = (tachyonsColorToColor T.white)
        , bold = False
        , height = Just 15.0
        , typeface = [ "Times New Roman", "serif" ]
    }


treeNilStyle : Text.Style
treeNilStyle =
    { defaultStyle | color = (tachyonsColorToColor T.white), height = Just 20 }


treeLineStyle : LineStyle
treeLineStyle =
    { defaultLine | width = 1 }


treeLineHighlightStyle : LineStyle
treeLineHighlightStyle =
    { defaultLine | width = 4 }
