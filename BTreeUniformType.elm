module BTreeUniformType exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), toNothing, toTaggedNodes, toLength, toIsIntPrime, depth, sumInt, sort, deDuplicate, isAllNothing, nodeValOperate, displayString, intTreeFrom, bigIntTreeFrom, stringTreeFrom, boolTreeFrom, musicNotePlayerTreeFrom)

import Arithmetic exposing (isPrime)
import BigInt exposing (BigInt, toString)

import BTree exposing (BTree(..), TraversalOrder, Direction, depth, map, deDuplicateBy, singleton, sumMaybeSafeInt, sumBigInt, sumString, sortTo, sortByTo, sortWithTo, isEmpty, toNothingNodes)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote, mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import NodeValueOperation exposing (Operation, operateOnInt, operateOnBigInt, operateOnString, operateOnBool, operateOnMusicNote, operateOnNothing)
import BTreeVariedType exposing (BTreeVaried(..))
import Lib exposing (IntFlex(..), digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), compare, toMaybeSafeInt)
import TreePlayerParams exposing (TreePlayerParams, defaultTreePlayerParams)


type IntTree = IntTree (BTree IntNode)
type BigIntTree = BigIntTree (BTree BigIntNode)
type StringTree = StringTree (BTree StringNode)
type BoolTree = BoolTree (BTree BoolNode)
type MusicNotePlayerTree = MusicNotePlayerTree TreePlayerParams (BTree MusicNoteNode)
type NothingTree = NothingTree (BTree NothingNode)


type BTreeUniform
    = UniformInt IntTree
    | UniformBigInt BigIntTree
    | UniformString StringTree
    | UniformBool BoolTree
    | UniformMusicNotePlayer MusicNotePlayerTree
    | UniformNothing NothingTree

-- todo If these are unused then DEL
intTreeFrom : BTreeUniform -> IntTree
intTreeFrom bTreeUniform =
    let
        mbRequested = case bTreeUniform of
            UniformInt (IntTree btree) -> Just (IntTree btree)

            _ -> Nothing
    in
        Maybe.withDefault (IntTree Empty) mbRequested


bigIntTreeFrom : BTreeUniform -> BigIntTree
bigIntTreeFrom bTreeUniform =
    let
        mbRequested = case bTreeUniform of
            UniformBigInt (BigIntTree btree) -> Just (BigIntTree btree)
            _ -> Nothing
    in
        Maybe.withDefault (BigIntTree Empty) mbRequested


stringTreeFrom : BTreeUniform -> StringTree
stringTreeFrom bTreeUniform =
    let
        mbRequested = case bTreeUniform of
            UniformString (StringTree btree) -> Just (StringTree btree)
            _ -> Nothing
    in
        Maybe.withDefault (StringTree Empty) mbRequested


boolTreeFrom : BTreeUniform -> BoolTree
boolTreeFrom bTreeUniform =
    let
        mbRequested = case bTreeUniform of
            UniformBool (BoolTree btree) -> Just (BoolTree btree)
            _ -> Nothing
    in
        Maybe.withDefault (BoolTree Empty) mbRequested


musicNotePlayerTreeFrom : BTreeUniform -> MusicNotePlayerTree
musicNotePlayerTreeFrom bTreeUniform =
    let
        mbRequested = case bTreeUniform of
            UniformMusicNotePlayer (MusicNotePlayerTree params bTree) -> Just (MusicNotePlayerTree params bTree)
            _ -> Nothing
    in
        Maybe.withDefault (MusicNotePlayerTree defaultTreePlayerParams Empty) mbRequested


toNothing : BTreeUniform -> BTreeUniform
toNothing bTreeUniform =
    let
        toBTreeNothing : BTree a -> BTreeUniform
        toBTreeNothing  = \bTree -> UniformNothing <| NothingTree <| toNothingNodes bTree
    in
        case bTreeUniform of
            UniformInt (IntTree bTree) ->
                toBTreeNothing bTree

            UniformBigInt (BigIntTree bTree) ->
                toBTreeNothing bTree

            UniformString (StringTree bTree) ->
                toBTreeNothing bTree

            UniformBool (BoolTree bTree) ->
                toBTreeNothing bTree

            UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
                toBTreeNothing bTree

            UniformNothing (NothingTree bTree) ->
                bTreeUniform


toTaggedNodes : BTreeUniform -> BTree NodeVariety
toTaggedNodes bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            map IntVariety bTree

        UniformBigInt (BigIntTree bTree) ->
            map BigIntVariety bTree

        UniformString (StringTree bTree) ->
            map StringVariety bTree

        UniformBool (BoolTree bTree) ->
            map BoolVariety bTree

        UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
            map MusicNoteVariety bTree

        UniformNothing (NothingTree bTree) ->
            map NothingVariety bTree


toLength : BTreeUniform -> Maybe BTreeUniform
toLength bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            let
                fn = \(IntNodeVal mbsInt) -> IntNodeVal <| digitCount mbsInt
            in
                Just <| UniformInt <| IntTree <| map fn bTree

        UniformBigInt (BigIntTree bTree) ->
            let
                fn = \(BigIntNodeVal bigInt) -> IntNodeVal <| digitCountBigInt bigInt
            in
                Just <| UniformInt <| IntTree <| map fn bTree

        UniformString (StringTree bTree) ->
            let
                fn = \(StringNodeVal string) -> IntNodeVal <| toMaybeSafeInt <| String.length string
            in
                Just <| UniformInt <| IntTree <| map fn bTree

        UniformBool _ ->
            Nothing

        UniformMusicNotePlayer _ ->
            Nothing

        UniformNothing _ ->
            Nothing


toIsIntPrime : BTreeUniform -> Maybe BTreeUniform
toIsIntPrime bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            let
                fn = \(IntNodeVal mbsInt) ->
                    BoolNodeVal <| MaybeSafe.unwrap Nothing (\int -> Just <| Arithmetic.isPrime int) mbsInt
            in
                Just <| UniformBool <| BoolTree (map fn bTree)

        UniformBigInt _ -> -- todo. not found in BigInt module
            Nothing

        UniformString _ ->
            Nothing

        UniformBool _ ->
            Nothing

        UniformMusicNotePlayer _ ->
            Nothing

        UniformNothing _ ->
            Nothing


nodeValOperate : Operation -> BTreeUniform -> BTreeUniform
nodeValOperate operation bTreeUniform =
        case bTreeUniform of
            UniformInt (IntTree bTree) ->
                UniformInt <| IntTree <| map (operateOnInt operation) bTree

            UniformBigInt (BigIntTree bTree) ->
                UniformBigInt <| BigIntTree <| map (operateOnBigInt operation) bTree

            UniformString (StringTree bTree) ->
                UniformString <| StringTree <| map (operateOnString operation) bTree

            UniformBool (BoolTree bTree) ->
                UniformBool <| BoolTree <| map (operateOnBool operation) bTree

            UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
                UniformMusicNotePlayer <| MusicNotePlayerTree treeParams <| map (operateOnMusicNote operation) bTree

            UniformNothing (NothingTree bTree) ->
                UniformNothing <| NothingTree <| map (operateOnNothing operation) bTree


depth : BTreeUniform -> Int
depth bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            BTree.depth bTree

        UniformBigInt (BigIntTree bTree) ->
            BTree.depth bTree

        UniformString (StringTree bTree) ->
            BTree.depth bTree

        UniformBool (BoolTree bTree) ->
            BTree.depth bTree

        UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
            BTree.depth bTree

        UniformNothing (NothingTree bTree) ->
            BTree.depth bTree


sumInt : BTreeUniform -> Maybe IntFlex
sumInt bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            bTree
                |> map (\(IntNodeVal mbsInt) -> mbsInt)
                |> BTree.sumMaybeSafeInt
                |> IntVal
                |> Just

        UniformBigInt (BigIntTree bTree) ->
            bTree
                |> map (\(BigIntNodeVal bigInt) -> bigInt)
                |> BTree.sumBigInt
                |> BigIntVal
                |> Just

        UniformString _ ->
            Nothing

        UniformBool _ ->
            Nothing

        UniformMusicNotePlayer _ ->
            Nothing

        UniformNothing _ ->
            Nothing


sort : Direction -> BTreeUniform -> BTreeUniform
sort direction bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            let
                fn = \(IntNodeVal int1) (IntNodeVal int2) -> MaybeSafe.compare int1 int2
            in
                UniformInt <| IntTree <| BTree.sortWithTo fn direction bTree

        UniformBigInt (BigIntTree bTree) ->
            let
                fn = \(BigIntNodeVal bigInt1) (BigIntNodeVal bigInt2) -> BigInt.compare bigInt1 bigInt2
            in
                UniformBigInt <| BigIntTree <| BTree.sortWithTo fn direction bTree

        UniformString (StringTree bTree) ->
            let
                fn = \(StringNodeVal string) -> string
            in
                UniformString <| StringTree <| BTree.sortByTo fn direction bTree

        UniformBool (BoolTree bTree) ->
            let
                fn = \(BoolNodeVal mbBool) -> Basics.toString mbBool
            in
                UniformBool <| BoolTree <| BTree.sortByTo fn direction bTree

        UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                UniformMusicNotePlayer <| MusicNotePlayerTree treeParams <| BTree.sortByTo fn direction bTree

        UniformNothing (NothingTree bTree) ->
            bTreeUniform


deDuplicate : BTreeUniform -> BTreeUniform
deDuplicate bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            let
                fn = \(IntNodeVal int) -> Basics.toString int
            in
                UniformInt <| IntTree <| BTree.deDuplicateBy fn bTree

        UniformBigInt (BigIntTree bTree) ->
            let
                fn = \(BigIntNodeVal bigInt) -> BigInt.toString bigInt
            in
                UniformBigInt <| BigIntTree <| BTree.deDuplicateBy fn bTree

        UniformString (StringTree bTree) ->
            let
                fn = \(StringNodeVal string) -> string
            in
                UniformString <| StringTree <| BTree.deDuplicateBy fn bTree

        UniformBool (BoolTree bTree) ->
            let
                fn = \(BoolNodeVal mbBool) -> Basics.toString mbBool
            in
                UniformBool <| BoolTree <| BTree.deDuplicateBy fn bTree

        UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
            let
                fn = \(MusicNoteNodeVal player) -> MusicNotePlayer.sorter player
            in
                UniformMusicNotePlayer <| MusicNotePlayerTree treeParams <| BTree.deDuplicateBy fn bTree

        UniformNothing (NothingTree bTree) ->
            UniformNothing <| NothingTree <| BTree.deDuplicateBy Basics.toString bTree


isAllNothing : BTreeUniform -> Bool
isAllNothing bTreeUniform =
    case bTreeUniform of
        UniformInt (IntTree bTree) ->
            isEmpty bTree

        UniformBigInt (BigIntTree bTree) ->
            isEmpty bTree

        UniformString (StringTree bTree) ->
            isEmpty bTree

        UniformBool (BoolTree bTree) ->
            isEmpty bTree

        UniformMusicNotePlayer (MusicNotePlayerTree treeParams bTree) ->
            let
                fn = \(MusicNoteNodeVal (MusicNotePlayer params)) -> params.mbNote
            in
                BTree.isAllNothing (map fn bTree)

        UniformNothing (NothingTree bTree) ->
            True


displayString : BTreeUniform -> String
displayString bTreeUniform =
    case bTreeUniform of
        UniformInt _ ->
            "Int"

        UniformBigInt _ ->
            "Big-Int"

        UniformString _ ->
            "String"

        UniformBool _ ->
            "Bool"

        UniformMusicNotePlayer _ ->
            "Music-Note"

        UniformNothing _ ->
            "Not-Applicable"