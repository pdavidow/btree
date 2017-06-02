module BTreeUniformType exposing (..)

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, map, depth, sumInt, sumString, sort)
import MusicScaleType exposing (MusicScaleType, sortOrder)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isPrime)


type BTreeUniformType
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)
    | BTreeBool (BTree Bool)
    | BTreeMusicScale (BTree MusicScaleType)


toTaggedBTree : BTreeUniformType -> BTree NodeTag
toTaggedBTree bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeString bTree ->
            map StringNode bTree

        BTreeBool bTree ->
            map BoolNode bTree

        BTreeMusicScale bTree ->
            map MusicScaleNode bTree


toStringLength : BTreeUniformType -> Maybe BTreeUniformType
toStringLength bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Nothing

        BTreeString bTree ->
            Just (BTreeInt (map String.length bTree))

        BTreeBool bTree ->
            Nothing

        BTreeMusicScale bTree ->
            Nothing


toIsIntPrime : BTreeUniformType -> Maybe BTreeUniformType
toIsIntPrime bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just (BTreeBool (map Arithmetic.isPrime bTree))

        BTreeString bTree ->
            Nothing

        BTreeBool bTree ->
            Nothing

        BTreeMusicScale bTree ->
            Nothing


mapUniformTree : Int -> Mappers -> BTreeUniformType -> BTreeUniformType
mapUniformTree operand mappers bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (mappers.int operand) bTree)

        BTreeString bTree ->
            BTreeString (map (mappers.string operand) bTree)

        BTreeBool bTree ->
            BTreeBool (map (mappers.bool operand) bTree)

        BTreeMusicScale bTree ->
            BTreeMusicScale bTree -- todo (map (mappers.musicScale operand) bTree)


incrementNodes : Int -> BTreeUniformType -> BTreeUniformType
incrementNodes delta bTreeUniformType =
    mapUniformTree delta incrementMappers bTreeUniformType


decrementNodes : Int -> BTreeUniformType -> BTreeUniformType
decrementNodes delta bTreeUniformType =
    mapUniformTree delta decrementMappers bTreeUniformType


raiseNodes : Int -> BTreeUniformType -> BTreeUniformType
raiseNodes exp bTreeUniformType =
    mapUniformTree exp raiseMappers bTreeUniformType


depth : BTreeUniformType -> Int
depth bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTree.depth bTree

        BTreeString bTree ->
            BTree.depth bTree

        BTreeBool bTree ->
            BTree.depth bTree

        BTreeMusicScale bTree ->
            BTree.depth bTree


sumInt : BTreeUniformType -> Maybe Int
sumInt bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just (BTree.sumInt bTree)

        BTreeString bTree ->
            Nothing

        BTreeBool bTree ->
            Nothing

        BTreeMusicScale bTree ->
            Nothing


sumString : BTreeUniformType -> Maybe String
sumString bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Nothing

        BTreeString bTree ->
            Just (BTree.sumString bTree)

        BTreeBool bTree ->
            Nothing

        BTreeMusicScale bTree ->
            Nothing


sort : BTreeUniformType -> Maybe BTreeUniformType
sort bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just (BTreeInt (BTree.sort bTree))

        BTreeString bTree ->
            Just (BTreeString (BTree.sort bTree))

        BTreeBool bTree ->
            Just (BTreeBool (BTree.sortBy toString bTree))

        BTreeMusicScale bTree ->
            Just (BTreeMusicScale (BTree.sortBy MusicScaleType.sortOrder bTree))


removeDuplicates : BTreeUniformType -> BTreeUniformType
removeDuplicates bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (BTree.removeDuplicates bTree)

        BTreeString bTree ->
            BTreeString (BTree.removeDuplicates bTree)

        BTreeBool bTree ->
            BTreeBool (BTree.removeDuplicatesBy toString bTree)

        BTreeMusicScale bTree ->
            BTreeMusicScale (BTree.removeDuplicatesBy MusicScaleType.sortOrder bTree)
