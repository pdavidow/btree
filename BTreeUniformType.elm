module BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, depth, sumInt, sumString, sort, removeDuplicates, isAllNothing)

import Arithmetic exposing (isPrime)
-- import Basics.Extra exposing (isSafeInteger) -- todo https://github.com/elm-community/basics-extra/issues/7

import BTree exposing (NodeTag(..))
import BTree exposing (BTree, depth, map, removeDuplicatesBy, singleton, sumInt , sumString , sort, sortBy, isEmpty, toNothingNodes)
import MusicNote exposing (MusicNote, mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import BTreeVariedType exposing (BTreeVariedType(..))
import Lib exposing (digitCount)


type OnlyNothing = OnlyNothing

type BTreeUniformType
    = BTreeInt (BTree Int)
    | BTreeString (BTree String)
    | BTreeBool (BTree Bool)
    | BTreeMusicNotePlayer (BTree MusicNotePlayer)
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

            BTreeMusicNotePlayer bTree ->
                nothing bTree

            BTreeNothing bTree ->
                bTreeUniformType


toTaggedNodes : BTreeUniformType -> BTree NodeTag
toTaggedNodes bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeString bTree ->
            map StringNode bTree

        BTreeBool bTree ->
            map BoolNode bTree

        BTreeMusicNotePlayer bTree ->
            map MusicNoteNode bTree

        BTreeNothing bTree ->
            toNothingNodes bTree


toLength : BTreeUniformType -> Maybe BTreeUniformType
toLength bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just (BTreeInt (map digitCount bTree))

        BTreeString bTree ->
            Just (BTreeInt (map String.length bTree))

        BTreeBool bTree ->
            Nothing

        BTreeMusicNotePlayer bTree ->
            Nothing

        BTreeNothing bTree ->
            Nothing


toIsIntPrime : BTreeUniformType -> BTreeVariedType
toIsIntPrime bTreeUniformType =
    -- todo https://github.com/elm-community/basics-extra/issues/7
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                -- todo https://github.com/elm-community/basics-extra/issues/7
                isSafeInteger = \int -> (abs int) <= (2^53 - 1)

                fn = \int -> if isSafeInteger int
                    then BoolNode (Arithmetic.isPrime int)
                    else UnsafeNode
            in
                BTreeVaried (map fn bTree)

        BTreeString bTree ->
            BTreeVaried (toNothingNodes bTree)

        BTreeBool bTree ->
            BTreeVaried (toNothingNodes bTree)

        BTreeMusicNotePlayer bTree ->
            BTreeVaried (toNothingNodes bTree)

        BTreeNothing bTree ->
            BTreeVaried (toNothingNodes bTree)


mapUniformTree : Int -> Mappers -> BTreeUniformType -> BTreeUniformType
mapUniformTree operand mappers bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (mappers.int operand) bTree)

        BTreeString bTree ->
            BTreeString (map (mappers.string operand) bTree)

        BTreeBool bTree ->
            BTreeBool (map (mappers.bool operand) bTree)

        BTreeMusicNotePlayer bTree ->
            BTreeMusicNotePlayer (map (mappers.musicNotePlayer operand) bTree)

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

        BTreeMusicNotePlayer bTree ->
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

        BTreeMusicNotePlayer bTree ->
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

        BTreeMusicNotePlayer bTree ->
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

        BTreeMusicNotePlayer bTree ->
            Just (BTreeMusicNotePlayer (BTree.sortBy MusicNotePlayer.sorter bTree))

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

        BTreeMusicNotePlayer bTree ->
            BTreeMusicNotePlayer (BTree.removeDuplicatesBy MusicNotePlayer.sorter bTree)

        BTreeNothing bTree ->
            BTreeNothing (singleton OnlyNothing)


isAllNothing : BTreeUniformType -> Bool
isAllNothing bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            isEmpty bTree

        BTreeString bTree ->
            isEmpty bTree

        BTreeBool bTree ->
            isEmpty bTree

        BTreeMusicNotePlayer bTree ->
            let
                fn = \(MusicNotePlayer params) -> params.mbNote
            in
                BTree.isAllNothing (map fn bTree)

        BTreeNothing bTree ->
            True

