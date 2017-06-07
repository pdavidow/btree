module BTreeUniformType exposing (..)

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, depth, map, removeDuplicatesBy, singleton, sumInt , sumString , sort, sortBy)
import MusicNote exposing (MusicNote, sortOrder)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isPrime)


type OnlyNothing = OnlyNothing

type BTreeUniformType
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)
    | BTreeBool (BTree Bool)
    | BTreeMusicNote (BTree (Maybe MusicNote))
    | BTreeNothing (BTree OnlyNothing)


toNothing : BTreeUniformType -> BTreeUniformType
toNothing bTreeUniformType =
    let
        nothing : BTree a -> BTreeUniformType
        nothing bTree =
            BTreeNothing (map (\a -> OnlyNothing) bTree)
    in
        case bTreeUniformType of
            BTreeInt bTree ->
                nothing bTree

            BTreeString bTree ->
                nothing bTree

            BTreeBool bTree ->
                nothing bTree

            BTreeMusicNote bTree ->
                nothing bTree

            BTreeNothing bTree ->
                bTreeUniformType


toTagged : BTreeUniformType -> BTree NodeTag
toTagged bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeString bTree ->
            map StringNode bTree

        BTreeBool bTree ->
            map BoolNode bTree

        BTreeMusicNote bTree ->
            map MusicNoteNode bTree

        BTreeNothing bTree ->
            map (\a -> NothingNode) bTree


toStringLength : BTreeUniformType -> Maybe BTreeUniformType
toStringLength bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Nothing

        BTreeString bTree ->
            Just (BTreeInt (map String.length bTree))

        BTreeBool bTree ->
            Nothing

        BTreeMusicNote bTree ->
            Nothing

        BTreeNothing bTree ->
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

        BTreeMusicNote bTree ->
            Nothing

        BTreeNothing bTree ->
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

        BTreeMusicNote bTree ->
            BTreeMusicNote (map (mappers.musicNote operand) bTree)

        BTreeNothing bTree ->
            bTreeUniformType


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

        BTreeMusicNote bTree ->
            BTree.depth bTree

        BTreeNothing bTree ->
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

        BTreeMusicNote bTree ->
            Nothing

        BTreeNothing bTree ->
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

        BTreeMusicNote bTree ->
            Nothing

        BTreeNothing bTree ->
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

        BTreeMusicNote bTree ->
            Just (BTreeMusicNote (BTree.sortBy MusicNote.sortOrder bTree))

        BTreeNothing bTree ->
            Just bTreeUniformType


removeDuplicates : BTreeUniformType -> BTreeUniformType
removeDuplicates bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (BTree.removeDuplicates bTree)

        BTreeString bTree ->
            BTreeString (BTree.removeDuplicates bTree)

        BTreeBool bTree ->
            BTreeBool (BTree.removeDuplicatesBy toString bTree)

        BTreeMusicNote bTree ->
            BTreeMusicNote (BTree.removeDuplicatesBy MusicNote.sortOrder bTree)

        BTreeNothing bTree ->
            BTreeNothing (singleton OnlyNothing)

