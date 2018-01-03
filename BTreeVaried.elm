module BTreeVaried exposing (BTreeVaried(..), toLength, toIsIntPrime, nodeValOperate, deDuplicate, hasAnyIntNodes, displayString)

import Arithmetic exposing (isPrime)
import BigInt exposing (toString)

import BTree exposing (BTree, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MusicNote exposing (mbSorter)
import NodeValueOperation exposing (Operation, operateOnInt, operateOnBigInt, operateOnString, operateOnBool, operateOnMusicNote, operateOnNothing)
import Lib exposing (digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)


type BTreeVaried = BTreeVaried (BTree NodeVariety)


toLength : BTreeVaried -> BTreeVaried
toLength (BTreeVaried bTree) =
    let
        fn : NodeVariety -> NodeVariety
        fn nodeVariety = case nodeVariety of
            IntVariety (IntNodeVal mbsInt) ->
                IntVariety <| IntNodeVal <| digitCount mbsInt

            BigIntVariety (BigIntNodeVal bigInt) ->
                IntVariety <| IntNodeVal <| digitCountBigInt bigInt

            StringVariety (StringNodeVal string) ->
                IntVariety <| IntNodeVal <| toMaybeSafeInt <| (String.length string)

            BoolVariety _ ->
                NothingVariety <| NothingNodeVal

            MusicNoteVariety _ ->
                NothingVariety <| NothingNodeVal

            NothingVariety _ ->
                NothingVariety <| NothingNodeVal
    in
        BTreeVaried (map fn bTree)


toIsIntPrime : BTreeVaried -> BTreeVaried
toIsIntPrime (BTreeVaried bTree) =
    let
        fn : NodeVariety -> NodeVariety
        fn nodeVariety = case nodeVariety of
            IntVariety (IntNodeVal mbsInt) ->
                let
                    fn = \int -> Just <| Arithmetic.isPrime int
                in
                    BoolVariety <| BoolNodeVal <| MaybeSafe.unwrap Nothing fn mbsInt

            BigIntVariety _ ->
                NothingVariety <| NothingNodeVal

            StringVariety _ ->
                NothingVariety <| NothingNodeVal

            BoolVariety _ ->
                NothingVariety <| NothingNodeVal

            MusicNoteVariety _ ->
                NothingVariety <| NothingNodeVal

            NothingVariety _ ->
                NothingVariety <| NothingNodeVal
    in
        BTreeVaried (map fn bTree)


nodeValOperate : Operation -> BTreeVaried -> BTreeVaried
nodeValOperate operation (BTreeVaried bTree) =
    let
        fn = \nodeVariety ->
            case nodeVariety of
                IntVariety node ->
                    IntVariety <| operateOnInt operation node

                BigIntVariety node ->
                    BigIntVariety <| operateOnBigInt operation node

                StringVariety node ->
                    StringVariety <| operateOnString operation node

                BoolVariety node ->
                    BoolVariety <| operateOnBool operation node

                MusicNoteVariety node ->
                    MusicNoteVariety <| operateOnMusicNote operation node

                NothingVariety node ->
                    NothingVariety <| operateOnNothing operation node
    in
        BTreeVaried <| map fn bTree


deDuplicate : BTreeVaried -> BTreeVaried
deDuplicate (BTreeVaried bTree) =
    let
        fn : NodeVariety -> String
        fn = \nodeVariety ->
            case nodeVariety of
                IntVariety _ ->
                    Basics.toString nodeVariety

                BigIntVariety (BigIntNodeVal bigInt) ->
                    BigInt.toString bigInt

                StringVariety _ ->
                    Basics.toString nodeVariety

                BoolVariety _ ->
                    Basics.toString nodeVariety

                MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
                    "MusicNoteVariety " ++ (Basics.toString <| MusicNote.mbSorter params.mbNote)

                NothingVariety _ ->
                    Basics.toString nodeVariety
    in
        BTreeVaried (BTree.deDuplicateBy fn bTree)


hasAnyIntNodes : BTreeVaried -> Bool
hasAnyIntNodes (BTreeVaried bTree) =
    let
        isIntNode : NodeVariety -> Bool
        isIntNode nodeVariety =
            case nodeVariety of
                IntVariety _ -> True
                BigIntVariety _ -> True
                StringVariety _ -> False
                BoolVariety _ -> False
                MusicNoteVariety _ -> False
                NothingVariety _ -> False
    in
        bTree
            |> BTree.flatten
            |> List.any isIntNode


displayString : BTreeVaried -> String
displayString _ =
    "Varied"