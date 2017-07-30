module BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, deDuplicate, hasAnyIntNodes)

import Arithmetic exposing (isPrime)
-- import Basics.Extra exposing (isSafeInteger) todo

import BTree exposing (BTree, map)
import NodeTag exposing (NodeTag(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MusicNote exposing (mbSorter)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Lib exposing (digitCount)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)

type BTreeVariedType = BTreeVaried (BTree NodeTag)


toLength : BTreeVariedType -> BTreeVariedType
toLength (BTreeVaried bTree) =
    let
        fn : NodeTag -> NodeTag
        fn nodeTag = case nodeTag of
            IntNode mbsInt ->
                IntNode (digitCount mbsInt)

            StringNode s ->
                IntNode <| toMaybeSafeInt <| (String.length s)

            BoolNode x ->
                NothingNode

            MusicNoteNode x ->
                NothingNode

            NothingNode ->
                NothingNode
    in
        BTreeVaried (map fn bTree)


toIsIntPrime : BTreeVariedType -> BTreeVariedType
toIsIntPrime (BTreeVaried bTree) =
    let
        -- todo https://github.com/elm-community/basics-extra/issues/7
        isSafeInteger = \int -> (abs int) <= (2^53 - 1)

        fn : NodeTag -> NodeTag
        fn nodeTag = case nodeTag of
            IntNode mbsInt ->
                let
                    mbBool = case mbsInt of
                        Unsafe ->
                            Nothing

                        Safe int ->
                            Just (Arithmetic.isPrime int)
                in
                    BoolNode mbBool

            StringNode x ->
                NothingNode

            BoolNode x ->
                NothingNode

            MusicNoteNode x ->
                NothingNode

            NothingNode ->
                NothingNode
    in
        BTreeVaried (map fn bTree)


mapVariedTree : Int -> Mappers -> BTreeVariedType -> BTreeVariedType
mapVariedTree operand mappers (BTreeVaried bTree) =
    let
        fn : Int -> Mappers -> NodeTag -> NodeTag
        fn operand mappers nodeTag =
            case nodeTag of
                IntNode mbsInt ->
                    IntNode (mappers.int operand mbsInt)

                StringNode x ->
                    StringNode (mappers.string operand x)

                BoolNode mbBool ->
                    BoolNode (mappers.bool operand mbBool)

                MusicNoteNode x ->
                    MusicNoteNode (mappers.musicNotePlayer operand x)

                NothingNode ->
                    NothingNode
    in
        BTreeVaried (map (fn operand mappers) bTree)


incrementNodes : Int -> BTreeVariedType -> BTreeVariedType
incrementNodes delta bTreeVaried =
    mapVariedTree delta incrementMappers bTreeVaried


decrementNodes : Int -> BTreeVariedType -> BTreeVariedType
decrementNodes delta bTreeVaried =
    mapVariedTree delta decrementMappers bTreeVaried


raiseNodes : Int -> BTreeVariedType -> BTreeVariedType
raiseNodes exp bTreeVaried =
    mapVariedTree exp raiseMappers bTreeVaried


deDuplicate : BTreeVariedType -> BTreeVariedType
deDuplicate (BTreeVaried bTree) =
    let
        fn = \node ->
            case node of
                IntNode x ->
                    toString node

                StringNode x ->
                    toString node

                BoolNode x ->
                    toString node

                MusicNoteNode (MusicNotePlayer params) ->
                    "MusicNoteNode " ++ (MusicNote.mbSorter params.mbNote)

                NothingNode ->
                    toString node
    in
        BTreeVaried (BTree.deDuplicateBy fn bTree)


hasAnyIntNodes : BTreeVariedType -> Bool
hasAnyIntNodes (BTreeVaried bTree) =
    let
        isIntNode : NodeTag -> Bool
        isIntNode node =
            case node of
                IntNode x -> True
                _ -> False
    in
        BTree.flatten bTree
            |> List.any isIntNode