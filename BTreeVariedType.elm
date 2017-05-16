module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (..)


type alias BTreeVariedType = BTree NodeTag


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTree =
    map (incrementNode delta) bTree


incrementNode : Int -> NodeTag -> NodeTag
incrementNode delta nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (ValueOps.incrementInt delta i)

        StringNode s ->
            StringNode (ValueOps.incrementString delta s)


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTree =
    map (decrementNode delta) bTree


decrementNode : Int -> NodeTag -> NodeTag
decrementNode delta nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (ValueOps.decrementInt delta i)

        StringNode s ->
            StringNode (ValueOps.decrementString delta s)


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTree =
    map (raiseNode exp) bTree


raiseNode : Int -> NodeTag -> NodeTag
raiseNode exp nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (ValueOps.raiseInt exp i)

        StringNode s ->
            StringNode (ValueOps.raiseString exp s)