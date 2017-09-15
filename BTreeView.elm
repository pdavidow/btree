module BTreeView exposing (bTreeUniform_Diagram, bTreeVaried_Diagram, intNodeEvenColor, intNodeOddColor, unsafeColor)

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
import BigInt exposing (BigInt, toString)
import Maybe.Extra exposing (unwrap)

import BTree exposing (BTree, flatten, toTreeDiagramTree)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import BTreeUniformType exposing (BTreeUniformType(..), toTaggedNodes)
import BTreeVariedType exposing (BTreeVariedType(..))
import MusicNote exposing (displayString)
import MusicNotePlayer exposing (MusicNotePlayer(..))
import UniversalConstants exposing (nothingString, unsafeString)
import MaybeSafe exposing (MaybeSafe(..), withDefault, unwrap)
import Lib exposing (isEvenBigInt, digitCount, digitCountBigInt)


bTreeUniform_Diagram : BTreeUniformType -> Html msg
bTreeUniform_Diagram bTreeUniformType =
    bTreeDiagram (toTaggedNodes bTreeUniformType)


bTreeVaried_Diagram : BTreeVariedType -> Html msg
bTreeVaried_Diagram (BTreeVaried taggedBTree) =
    bTreeDiagram taggedBTree


bTreeDiagram : BTree NodeVariety -> Html msg
bTreeDiagram bTree =
    bTree
        |> toTreeDiagramTree
        |> treeElement (maxNodeDisplayLength bTree)
        |> Element.toHtml


treeElement : Int -> Maybe (TD.Tree (Maybe NodeVariety)) -> Element
treeElement maxLength mbTdTree =
    case mbTdTree of
        Nothing ->
            Element.empty

        Just (tdTree) ->
            TreeDiagram.Canvas.draw
                { defaultTreeLayout
                | padding = 100
                , siblingDistance = if maxLength < 13 then 80 else 150
                , subtreeDistance = if maxLength < 13 then 150 else 200
                }
                drawNode
                drawEdge
                tdTree


maxNodeDisplayLength : BTree NodeVariety -> Int
maxNodeDisplayLength bTree =
    BTree.flatten bTree
        |> List.map nodeDisplayLength
        |> List.maximum
        |> Maybe.withDefault 0


nodeDisplayLength : NodeVariety -> Int
nodeDisplayLength nodeVariety =
    case nodeVariety of
        IntVariety (IntNodeVal mbsInt) ->
            let
                fn = \int -> case digitCount <| Safe int of
                     Unsafe -> 0
                     Safe count -> count
            in
                MaybeSafe.unwrap 0 fn mbsInt

        BigIntVariety (BigIntNodeVal bigInt) ->
            MaybeSafe.withDefault 0 <| digitCountBigInt bigInt

        StringVariety (StringNodeVal string) ->
            String.length string

        BoolVariety (BoolNodeVal mbBool) ->
            Maybe.Extra.unwrap 0 (\a -> 1) mbBool

        MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
            let
                fn = \note -> MusicNote.displayString note
                    |> String.length
            in
                Maybe.Extra.unwrap 0 fn <| params.mbNote

        NothingVariety _ ->
            0


intNodeEvenColor : TachyonsColor
intNodeEvenColor =
    T.dark_green


intNodeOddColor : TachyonsColor
intNodeOddColor =
    T.orange


unsafeColor : TachyonsColor
unsafeColor =
    T.dark_red


drawNode : Maybe NodeVariety -> Form
drawNode mbNodeVariety =
    case mbNodeVariety of
        Just nodeVariety ->
            case nodeVariety of
                IntVariety (IntNodeVal mbsInt) ->
                    case mbsInt of
                        Unsafe ->
                            group
                                [ rect 55 30 |> filled (tachyonsColorToColor unsafeColor)
                                , rect 55 30 |> outlined treeLineStyle
                                , unsafeString |> fromString |> style treeNodeStyle |> text |> moveY 4
                                ]
                        Safe int ->
                            let
                                intString = Basics.toString int
                                stringLength = String.length intString
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
                                    , intString |> fromString |> style treeNodeStyle |> text |> moveY 4
                                    ]

                BigIntVariety (BigIntNodeVal bigInt) ->
                    let
                        bigIntString = BigInt.toString bigInt
                        stringLength = String.length bigIntString
                        width = toFloat (30 + (10 * stringLength))
                        height = 30

                        colorizer : BigInt -> Color
                        colorizer i =
                            tachyonsColorToColor <|
                                if Lib.isEvenBigInt i
                                    then intNodeEvenColor
                                    else intNodeOddColor
                    in
                        group
                            [ oval width height |> filled (colorizer bigInt)
                            , oval width height |> outlined treeThickLineStyle
                            , bigIntString |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                StringVariety (StringNodeVal string) ->
                    let
                        stringLength = String.length string
                        width = toFloat <| 10 * (max 3 stringLength)
                        height = 30
                    in
                        group
                            [ rect width height |> filled (tachyonsColorToColor T.dark_blue)
                            , rect width height |> outlined treeLineStyle
                            , string |> fromString |> style treeNodeStyle |> text |> moveY 4
                            ]

                BoolVariety (BoolNodeVal mbBool) ->
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

                MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
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

                NothingVariety _ ->
                    group
                        [ oval 40 40 |> filled (tachyonsColorToColor T.light_silver)
                        , oval 40 40 |> outlined treeLineStyle
                        , nothingString |> fromString |> style treeNodeStyle |> text |> moveY 4
                        ]

        Nothing ->
            toForm Element.empty


drawNothingNode : Form
drawNothingNode =
    drawNode (Just <| NothingVariety NothingNodeVal)


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


treeThickLineStyle : LineStyle
treeThickLineStyle =
    { defaultLine | width = 3 }


treeLineHighlightStyle : LineStyle
treeLineHighlightStyle =
    { defaultLine | width = 4 }
