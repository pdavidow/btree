module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))


type alias BTreeVariedType = BTree NodeTag


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTree =
    map (incrementNode delta) bTree


incrementNode : Int -> NodeTag -> NodeTag
incrementNode delta nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (i + delta)

        StringNode s ->
            StringNode (s ++ " +" ++ (toString delta))


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTree =
    map (decrementNode delta) bTree


decrementNode : Int -> NodeTag -> NodeTag
decrementNode delta nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (i - delta)

        StringNode s ->
            StringNode (s ++ " -" ++ (toString delta))


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTree =
    map (raiseNode exp) bTree


raiseNode : Int -> NodeTag -> NodeTag
raiseNode exp nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (i ^ exp)

        StringNode s ->
            StringNode (s ++ " ^" ++ (toString exp))