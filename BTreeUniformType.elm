module BTreeUniformType exposing (BTreeUniformType(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, depth, sumInt, sort, deDuplicate, isAllNothing, nodeValueOperate)

import Arithmetic exposing (isPrime)
-- import Basics.Extra exposing (isSafeInteger) -- todo https://github.com/elm-community/basics-extra/issues/7

import BTree exposing (BTree, Direction, depth, map, deDuplicateBy, singleton, sumMaybeSafeInt, sumBigInt, sumString, sortTo, sortByTo, sortWithTo, isEmpty, toNothingNodes)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote, mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import NodeValueOperation exposing (Operation, operateWith)
import BTreeVariedType exposing (BTreeVariedType(..))
import Lib exposing (IntFlex(..), digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), compare, toMaybeSafeInt)
import BigInt exposing (BigInt, toString)


type BTreeUniformType
    = BTreeInt (BTree IntNode)
    | BTreeBigInt (BTree BigIntNode)
    | BTreeString (BTree StringNode)
    | BTreeBool (BTree BoolNode)
    | BTreeMusicNotePlayer (BTree MusicNoteNode)
    | BTreeNothing (BTree NothingNode)


toNothing : BTreeUniformType -> BTreeUniformType
toNothing bTreeUniformType =
    let
        nothingitize : BTree a -> BTreeUniformType
        nothingitize  = \bTree -> BTreeNothing <| toNothingNodes bTree
    in
        case bTreeUniformType of
            BTreeInt bTree ->
                nothingitize bTree

            BTreeBigInt bTree ->
                nothingitize bTree

            BTreeString bTree ->
                nothingitize bTree

            BTreeBool bTree ->
                nothingitize bTree

            BTreeMusicNotePlayer bTree ->
                nothingitize bTree

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

        BTreeMusicNotePlayer bTree ->
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

        BTreeBool bTree ->
            Nothing

        BTreeMusicNotePlayer bTree ->
            Nothing

        BTreeNothing bTree ->
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

        BTreeMusicNotePlayer _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


nodeValueOperate : Operation -> BTreeUniformType -> BTreeUniformType
nodeValueOperate operation bTreeUniformType =
        case bTreeUniformType of -- todo refactor
            BTreeInt bTree ->
                let
                    fn = \node ->
                        let
                            mbNode = case operateWith operation <| IntVariety node of
                                IntVariety node -> Just node
                                BigIntVariety _ -> Nothing
                                StringVariety _ -> Nothing
                                BoolVariety _ -> Nothing
                                MusicNoteVariety _ -> Nothing
                                NothingVariety _ -> Nothing
                        in
                            Maybe.withDefault node mbNode
                in
                    BTreeInt <| map fn bTree

            BTreeBigInt bTree ->
                let
                    fn = \node ->
                        let
                            mbNode = case operateWith operation <| BigIntVariety node of
                                IntVariety _ -> Nothing
                                BigIntVariety node -> Just node
                                StringVariety _ -> Nothing
                                BoolVariety _ -> Nothing
                                MusicNoteVariety _ -> Nothing
                                NothingVariety _ -> Nothing
                        in
                            Maybe.withDefault node mbNode
                in
                    BTreeBigInt <| map fn bTree

            BTreeString bTree ->
                let
                    fn = \node ->
                        let
                            mbNode = case operateWith operation <| StringVariety node of
                                IntVariety _ -> Nothing
                                BigIntVariety _ -> Nothing
                                StringVariety node -> Just node
                                BoolVariety _ -> Nothing
                                MusicNoteVariety _ -> Nothing
                                NothingVariety _ -> Nothing
                        in
                            Maybe.withDefault node mbNode
                in
                    BTreeString <| map fn bTree

            BTreeBool bTree ->
                let
                    fn = \node ->
                        let
                            mbNode = case operateWith operation <| BoolVariety node of
                                IntVariety _ -> Nothing
                                BigIntVariety _ -> Nothing
                                StringVariety _ -> Nothing
                                BoolVariety node -> Just node
                                MusicNoteVariety _ -> Nothing
                                NothingVariety _ -> Nothing
                        in
                            Maybe.withDefault node mbNode
                in
                    BTreeBool <| map fn bTree

            BTreeMusicNotePlayer bTree ->
                let
                    fn = \node ->
                        let
                            mbNode = case operateWith operation <| MusicNoteVariety node of
                                IntVariety _ -> Nothing
                                BigIntVariety _ -> Nothing
                                StringVariety _ -> Nothing
                                BoolVariety _ -> Nothing
                                MusicNoteVariety node -> Just node
                                NothingVariety _ -> Nothing
                        in
                            Maybe.withDefault node mbNode
                in
                    BTreeMusicNotePlayer <| map fn bTree

            BTreeNothing _ ->
                bTreeUniformType


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

        BTreeMusicNotePlayer _ ->
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

        BTreeMusicNotePlayer bTree ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                BTreeMusicNotePlayer <| BTree.sortByTo fn direction bTree

        BTreeNothing bTree ->
            bTreeUniformType


deDuplicate : BTreeUniformType -> BTreeUniformType
deDuplicate bTreeUniformType =
    case bTreeUniformType of -- todo refactor out a sorter general purpose fn (looks like it has to be for NodeVariety)
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

        BTreeMusicNotePlayer bTree ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                BTreeMusicNotePlayer <| BTree.deDuplicateBy fn bTree

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
                fn = \(MusicNoteNodeVal (MusicNotePlayer params)) -> params.mbNote
            in
                BTree.isAllNothing (map fn bTree)

        BTreeNothing bTree ->
            True

