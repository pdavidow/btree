module BTreeVariedType exposing (..)

import BTree exposing (BTree, map)
import BTree exposing (NodeTag(..))
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)


type alias BTreeVariedType = BTree NodeTag


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTree =
    map (incrementNode delta incrementMappers) bTree


incrementNode : Int -> Mappers -> NodeTag -> NodeTag
incrementNode delta mappers nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (mappers.int delta i)

        StringNode s ->
            StringNode (mappers.string delta s)


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTree =
    map (decrementNode delta decrementMappers) bTree


decrementNode : Int -> Mappers -> NodeTag -> NodeTag
decrementNode delta mappers nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (mappers.int delta i)

        StringNode s ->
            StringNode (mappers.string delta s)


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTree =
    map (raiseNode exp raiseMappers) bTree


raiseNode : Int -> Mappers -> NodeTag -> NodeTag
raiseNode exp mappers nodeTag =
    case nodeTag of
        IntNode i ->
            IntNode (mappers.int exp i)

        StringNode s ->
            StringNode (mappers.string exp s)