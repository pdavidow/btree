module BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, nodeValueOperate, deDuplicate, hasAnyIntNodes)

import Arithmetic exposing (isPrime)
-- import Basics.Extra exposing (isSafeInteger) todo
import BigInt exposing (toString)

import BTree exposing (BTree, map)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MusicNote exposing (mbSorter)
import NodeValueOperation exposing (Operation, operateWith)
import Lib exposing (digitCount, digitCountBigInt)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)


type BTreeVariedType = BTreeVaried (BTree NodeVariety)


toLength : BTreeVariedType -> BTreeVariedType
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


toIsIntPrime : BTreeVariedType -> BTreeVariedType
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


nodeValueOperate : Operation -> BTreeVariedType -> BTreeVariedType
nodeValueOperate operation (BTreeVaried bTree) =
    BTreeVaried <| map (operateWith operation) bTree


deDuplicate : BTreeVariedType -> BTreeVariedType
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
                    "MusicNoteVariety " ++ (MusicNote.mbSorter params.mbNote)

                NothingVariety _ ->
                    Basics.toString nodeVariety
    in
        BTreeVaried (BTree.deDuplicateBy fn bTree)


hasAnyIntNodes : BTreeVariedType -> Bool
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