module BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, incrementNodes, decrementNodes, raiseNodes, depth, sumInt, sort, deDuplicate, isAllNothing)

import Arithmetic exposing (isPrime)
-- import Basics.Extra exposing (isSafeInteger) -- todo https://github.com/elm-community/basics-extra/issues/7

import BTree exposing (BTree, Direction, depth, map, deDuplicateBy, singleton, sumMaybeSafeInt, sumBigInt, sumString, sortTo, sortByTo, sortWithTo, isEmpty, toNothingNodes)
import NodeTag exposing (NodeTag(..))
import MusicNote exposing (MusicNote, mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import BTreeVariedType exposing (BTreeVariedType(..))
import Lib exposing (IntFlex(..), digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), compare, toMaybeSafeInt)
import BigInt exposing (BigInt, toString)


type OnlyNothing = OnlyNothing

type BTreeUniformType
    = BTreeInt (BTree (MaybeSafe Int))
    | BTreeBigInt (BTree BigInt)
    | BTreeString (BTree String)
    | BTreeBool (BTree (Maybe Bool))
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

            BTreeBigInt bTree ->
                nothing bTree

            BTreeString bTree ->
                nothing bTree

            BTreeBool bTree ->
                nothing bTree

            BTreeMusicNotePlayer bTree ->
                nothing bTree

            BTreeNothing _ ->
                bTreeUniformType


toTaggedNodes : BTreeUniformType -> BTree NodeTag
toTaggedNodes bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntNode bTree

        BTreeBigInt bTree ->
            map BigIntNode bTree

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
            Just <| BTreeInt <| map digitCount bTree

        BTreeBigInt bTree ->
            Just <| BTreeInt <| map digitCountBigInt bTree

        BTreeString bTree ->
            let
                fn = \s -> toMaybeSafeInt <| String.length s
            in
                Just <| BTreeInt <| map fn bTree

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


toIsIntPrime : BTreeUniformType -> Maybe BTreeUniformType
toIsIntPrime bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                fn = \mbsInt ->
                    case mbsInt of
                        Unsafe ->
                            Nothing

                        Safe int ->
                            Just <| Arithmetic.isPrime int
            in
                Just (BTreeBool (map fn bTree))

        BTreeBigInt _ -> -- todo. not found in BigInt module
            Nothing

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


mapUniformTree : Int -> Mappers -> BTreeUniformType -> BTreeUniformType
mapUniformTree operand mappers bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (map (mappers.int operand) bTree)

        BTreeBigInt bTree ->
            BTreeBigInt (map (mappers.bigInt operand) bTree)

        BTreeString bTree ->
            BTreeString (map (mappers.string operand) bTree)

        BTreeBool bTree ->
            BTreeBool (map (mappers.bool operand) bTree)

        BTreeMusicNotePlayer bTree ->
            BTreeMusicNotePlayer (map (mappers.musicNotePlayer operand) bTree)

        BTreeNothing _ ->
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

        BTreeBigInt bTree ->
            BTree.depth bTree

        BTreeString bTree ->
            BTree.depth bTree

        BTreeBool bTree ->
            BTree.depth bTree

        BTreeMusicNotePlayer bTree ->
            BTree.depth bTree

        BTreeNothing bTree ->
            BTree.depth bTree


sumInt : BTreeUniformType -> Maybe IntFlex
sumInt bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            Just <| IntVal <| BTree.sumMaybeSafeInt bTree

        BTreeBigInt bTree ->
            Just <| BigIntVal <| BTree.sumBigInt bTree

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


sort : Direction -> BTreeUniformType -> BTreeUniformType
sort direction bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt <| BTree.sortWithTo MaybeSafe.compare direction bTree

        BTreeBigInt bTree ->
            BTreeBigInt <| BTree.sortWithTo BigInt.compare direction bTree

        BTreeString bTree ->
            BTreeString <| BTree.sortTo direction bTree

        BTreeBool bTree ->
            BTreeBool <| BTree.sortByTo Basics.toString direction bTree

        BTreeMusicNotePlayer bTree ->
            BTreeMusicNotePlayer <| BTree.sortByTo MusicNotePlayer.sorter direction bTree

        BTreeNothing bTree ->
            bTreeUniformType


deDuplicate : BTreeUniformType -> BTreeUniformType
deDuplicate bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            BTreeInt (BTree.deDuplicateBy Basics.toString bTree)

        BTreeBigInt bTree ->
            BTreeBigInt (BTree.deDuplicateBy BigInt.toString bTree)

        BTreeString bTree ->
            BTreeString (BTree.deDuplicate bTree)

        BTreeBool bTree ->
            BTreeBool (BTree.deDuplicateBy Basics.toString bTree)

        BTreeMusicNotePlayer bTree ->
            BTreeMusicNotePlayer (BTree.deDuplicateBy MusicNotePlayer.sorter bTree)

        BTreeNothing bTree ->
            BTreeNothing <| BTree.deDuplicateBy Basics.toString bTree


isAllNothing : BTreeUniformType -> Bool
isAllNothing bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            isEmpty bTree

        BTreeBigInt bTree ->
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

