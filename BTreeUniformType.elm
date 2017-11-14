module BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, depth, sumInt, sort, deDuplicate, isAllNothing, nodeValOperate, setTreePlayerParams, displayString, musicNotePlayerParams)

import Arithmetic exposing (isPrime)
import BigInt exposing (BigInt, toString)

import BTree exposing (BTree(..), TraversalOrder, Direction, depth, map, deDuplicateBy, singleton, sumMaybeSafeInt, sumBigInt, sumString, sortTo, sortByTo, sortWithTo, isEmpty, toNothingNodes)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote, mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import NodeValueOperation exposing (Operation, operateOnInt, operateOnBigInt, operateOnString, operateOnBool, operateOnMusicNote, operateOnNothing)
import BTreeVariedType exposing (BTreeVariedType(..))
import Lib exposing (IntFlex(..), digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), compare, toMaybeSafeInt)
import TreePlayerParams exposing (TreePlayerParams, defaultTreePlayerParams)


type BTreeUniformType
    = BTreeInt (BTree IntNode)
    | BTreeBigInt (BTree BigIntNode)
    | BTreeString (BTree StringNode)
    | BTreeBool (BTree BoolNode)
    | BTreeMusicNotePlayer TreePlayerParams (BTree MusicNoteNode)
    | BTreeNothing (BTree NothingNode)


musicNotePlayerParamsWithTree : BTreeUniformType -> (TreePlayerParams, BTree MusicNoteNode)
musicNotePlayerParamsWithTree bTreeMusicNotePlayer =
    let
        mbTuple = case bTreeMusicNotePlayer of
            BTreeInt _ -> Nothing
            BTreeBigInt _ -> Nothing
            BTreeString _ -> Nothing
            BTreeBool _ -> Nothing
            BTreeMusicNotePlayer params bTree -> Just (params, bTree)
            BTreeNothing _ -> Nothing

        (params, bTree) = Maybe.withDefault (defaultTreePlayerParams, Empty) mbTuple
    in
        (params, bTree)


musicNotePlayerParams : BTreeUniformType -> TreePlayerParams
musicNotePlayerParams bTreeMusicNotePlayer =
    let
        (params, bTree) = musicNotePlayerParamsWithTree bTreeMusicNotePlayer
    in
        params


setTreePlayerParams : (TreePlayerParams -> TreePlayerParams) -> BTreeUniformType -> BTreeUniformType
setTreePlayerParams fn bTreeMusicNotePlayer =
    let
        (params, bTree) = musicNotePlayerParamsWithTree bTreeMusicNotePlayer
    in
        BTreeMusicNotePlayer (fn params) bTree


toNothing : BTreeUniformType -> BTreeUniformType
toNothing bTreeUniformType =
    let
        toBTreeNothing : BTree a -> BTreeUniformType
        toBTreeNothing  = \bTree -> BTreeNothing <| toNothingNodes bTree
    in
        case bTreeUniformType of
            BTreeInt bTree ->
                toBTreeNothing bTree

            BTreeBigInt bTree ->
                toBTreeNothing bTree

            BTreeString bTree ->
                toBTreeNothing bTree

            BTreeBool bTree ->
                toBTreeNothing bTree

            BTreeMusicNotePlayer treeParams bTree ->
                toBTreeNothing bTree

            BTreeNothing bTree ->
                bTreeUniformType


toTaggedNodes : BTreeUniformType -> BTree NodeVariety
toTaggedNodes bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            map IntVariety bTree

        BTreeBigInt bTree ->
            map BigIntVariety bTree

        BTreeString bTree ->
            map StringVariety bTree

        BTreeBool bTree ->
            map BoolVariety bTree

        BTreeMusicNotePlayer treeParams bTree ->
            map MusicNoteVariety bTree

        BTreeNothing bTree ->
            map NothingVariety bTree


toLength : BTreeUniformType -> Maybe BTreeUniformType
toLength bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                fn = \(IntNodeVal mbsInt) -> IntNodeVal <| digitCount mbsInt
            in
                Just <| BTreeInt <| map fn bTree

        BTreeBigInt bTree ->
            let
                fn = \(BigIntNodeVal bigInt) -> IntNodeVal <| digitCountBigInt bigInt
            in
                Just <| BTreeInt <| map fn bTree

        BTreeString bTree ->
            let
                fn = \(StringNodeVal string) -> IntNodeVal <| toMaybeSafeInt <| String.length string
            in
                Just <| BTreeInt <| map fn bTree

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


toIsIntPrime : BTreeUniformType -> Maybe BTreeUniformType
toIsIntPrime bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                fn = \(IntNodeVal mbsInt) ->
                    BoolNodeVal <| MaybeSafe.unwrap Nothing (\int -> Just <| Arithmetic.isPrime int) mbsInt
            in
                Just <| BTreeBool (map fn bTree)

        BTreeBigInt _ -> -- todo. not found in BigInt module
            Nothing

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


nodeValOperate : Operation -> BTreeUniformType -> BTreeUniformType
nodeValOperate operation bTreeUniformType =
        case bTreeUniformType of
            BTreeInt bTree ->
                BTreeInt <| map (operateOnInt operation) bTree

            BTreeBigInt bTree ->
                BTreeBigInt <| map (operateOnBigInt operation) bTree

            BTreeString bTree ->
                BTreeString <| map (operateOnString operation) bTree

            BTreeBool bTree ->
                BTreeBool <| map (operateOnBool operation) bTree

            BTreeMusicNotePlayer treeParams bTree ->
                BTreeMusicNotePlayer treeParams <| map (operateOnMusicNote operation) bTree

            BTreeNothing bTree ->
                BTreeNothing <| map (operateOnNothing operation) bTree


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

        BTreeMusicNotePlayer treeParams bTree ->
            BTree.depth bTree

        BTreeNothing bTree ->
            BTree.depth bTree


sumInt : BTreeUniformType -> Maybe IntFlex
sumInt bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            bTree
                |> map (\(IntNodeVal mbsInt) -> mbsInt)
                |> BTree.sumMaybeSafeInt
                |> IntVal
                |> Just

        BTreeBigInt bTree ->
            bTree
                |> map (\(BigIntNodeVal bigInt) -> bigInt)
                |> BTree.sumBigInt
                |> BigIntVal
                |> Just

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


sort : Direction -> BTreeUniformType -> BTreeUniformType
sort direction bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                fn = \(IntNodeVal int1) (IntNodeVal int2) -> MaybeSafe.compare int1 int2
            in
                BTreeInt <| BTree.sortWithTo fn direction bTree

        BTreeBigInt bTree ->
            let
                fn = \(BigIntNodeVal bigInt1) (BigIntNodeVal bigInt2) -> BigInt.compare bigInt1 bigInt2
            in
                BTreeBigInt <| BTree.sortWithTo fn direction bTree

        BTreeString bTree ->
            let
                fn = \(StringNodeVal string) -> string
            in
                BTreeString <| BTree.sortByTo fn direction bTree

        BTreeBool bTree ->
            let
                fn = \(BoolNodeVal mbBool) -> Basics.toString mbBool
            in
                BTreeBool <| BTree.sortByTo fn direction bTree

        BTreeMusicNotePlayer treeParams bTree ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                BTreeMusicNotePlayer treeParams <| BTree.sortByTo fn direction bTree

        BTreeNothing bTree ->
            bTreeUniformType


deDuplicate : BTreeUniformType -> BTreeUniformType
deDuplicate bTreeUniformType =
    case bTreeUniformType of
        BTreeInt bTree ->
            let
                fn = \(IntNodeVal int) -> Basics.toString int
            in
                BTreeInt <| BTree.deDuplicateBy fn bTree

        BTreeBigInt bTree ->
            let
                fn = \(BigIntNodeVal bigInt) -> BigInt.toString bigInt
            in
                BTreeBigInt <| BTree.deDuplicateBy fn bTree

        BTreeString bTree ->
            let
                fn = \(StringNodeVal string) -> string
            in
                BTreeString <| BTree.deDuplicateBy fn bTree

        BTreeBool bTree ->
            let
                fn = \(BoolNodeVal mbBool) -> Basics.toString mbBool
            in
                BTreeBool <| BTree.deDuplicateBy fn bTree

        BTreeMusicNotePlayer treeParams bTree ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                BTreeMusicNotePlayer treeParams <| BTree.deDuplicateBy fn bTree

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

        BTreeMusicNotePlayer treeParams bTree ->
            let
                fn = \(MusicNoteNodeVal (MusicNotePlayer params)) -> params.mbNote
            in
                BTree.isAllNothing (map fn bTree)

        BTreeNothing bTree ->
            True


displayString : BTreeUniformType -> String
displayString bTreeUniformType =
    case bTreeUniformType of
        BTreeInt _ ->
            "Int"

        BTreeBigInt _ ->
            "Big-Int"

        BTreeString _ ->
            "String"

        BTreeBool _ ->
            "Bool"

        BTreeMusicNotePlayer _ _ ->
            "Music-Note"

        BTreeNothing _ ->
            "Not-Applicable"