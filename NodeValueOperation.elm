module NodeValueOperation exposing (Operation(..), operateWith)

import Arithmetic exposing (isEven)
import BigInt exposing (BigInt, add, sub)

import MusicNote exposing ((:+:), (:-:))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe(..), isSafeInt, toMaybeSafeInt, map)
import Lib exposing (raiseBigInt)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))


type Operation
    = Increment Int
    | Decrement Int
    | Raise Int


operateWith : Operation -> NodeVariety -> NodeVariety
operateWith operation nodeVariety =
    case operation of -- todo: apply abs HERE -- not in main
        Increment delta ->
            incrementWith delta nodeVariety

        Decrement delta ->
            decrementWith delta nodeVariety

        Raise exp ->
            raiseWith exp nodeVariety


incrementWith : Int -> NodeVariety -> NodeVariety
incrementWith delta nodeVariety =
    case nodeVariety of
        IntVariety (IntNodeVal mbsInt) ->
            IntVariety <| IntNodeVal <| intOp (+) delta mbsInt

        BigIntVariety (BigIntNodeVal bigInt) ->
            BigIntVariety <| BigIntNodeVal <| BigInt.add bigInt (BigInt.fromInt <| abs delta)

        StringVariety (StringNodeVal string) ->
            StringVariety <| StringNodeVal <| string ++ toString (abs delta)

        BoolVariety (BoolNodeVal mbBool) ->
            BoolVariety <| BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven <| abs delta)) mbBool

        MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
            MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :+: (abs delta)}

        NothingVariety NothingNodeVal ->
            NothingVariety NothingNodeVal


decrementWith : Int -> NodeVariety -> NodeVariety
decrementWith delta nodeVariety =
    case nodeVariety of
        IntVariety (IntNodeVal mbsInt) ->
            IntVariety <| IntNodeVal <| intOp (-) delta mbsInt

        BigIntVariety (BigIntNodeVal bigInt) ->
            BigIntVariety <| BigIntNodeVal <| BigInt.sub bigInt <| BigInt.fromInt <| abs delta

        StringVariety (StringNodeVal string) ->
            StringVariety <| StringNodeVal <| String.dropRight (abs delta) string

        BoolVariety (BoolNodeVal mbBool) ->
            BoolVariety <| BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven <| abs delta)) mbBool

        MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
            MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :-: (abs delta)}

        NothingVariety NothingNodeVal ->
            NothingVariety NothingNodeVal


raiseWith : Int -> NodeVariety -> NodeVariety
raiseWith exp nodeVariety =
    case nodeVariety of
        IntVariety (IntNodeVal mbsInt) ->
            IntVariety <| IntNodeVal <| intOp (^) exp mbsInt

        BigIntVariety (BigIntNodeVal bigInt) ->
            BigIntVariety <| BigIntNodeVal <| Lib.raiseBigInt (abs exp) bigInt

        StringVariety (StringNodeVal string) ->
            StringVariety <| StringNodeVal <| string

        BoolVariety (BoolNodeVal mbBool) ->
            BoolVariety <| BoolNodeVal <| mbBool

        MusicNoteVariety (MusicNoteNodeVal player) ->
            MusicNoteVariety <| MusicNoteNodeVal <| player

        NothingVariety NothingNodeVal ->
            NothingVariety NothingNodeVal


intOp : (Int -> Int -> Int) -> Int -> MaybeSafe Int -> MaybeSafe Int
intOp opFn delta mbsInt =
    let
        fn = \int ->
          delta
              |> abs
              |> opFn int
              |> toMaybeSafeInt
    in
        MaybeSafe.map fn mbsInt