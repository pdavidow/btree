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
    case operation of
        Increment delta ->
            incrementWith delta nodeVariety

        Decrement delta ->
            decrementWith delta nodeVariety

        Raise exp ->
            raiseWith exp nodeVariety


incrementWith : Int -> NodeVariety -> NodeVariety
incrementWith delta nodeVariety =
    let
        absDelta = abs delta
    in
        case nodeVariety of
            IntVariety (IntNodeVal mbsInt) ->
                IntVariety <| IntNodeVal <| intOperation (+) absDelta mbsInt

            BigIntVariety (BigIntNodeVal bigInt) ->
                BigIntVariety <| BigIntNodeVal <| BigInt.add bigInt <| BigInt.fromInt absDelta

            StringVariety (StringNodeVal string) ->
                StringVariety <| StringNodeVal <| string ++ toString absDelta

            BoolVariety (BoolNodeVal mbBool) ->
                BoolVariety <| BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven <| absDelta)) mbBool

            MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
                MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :+: absDelta}

            NothingVariety NothingNodeVal ->
                NothingVariety NothingNodeVal


decrementWith : Int -> NodeVariety -> NodeVariety
decrementWith delta nodeVariety =
    let
        absDelta = abs delta
    in
        case nodeVariety of
            IntVariety (IntNodeVal mbsInt) ->
                IntVariety <| IntNodeVal <| intOperation (-) absDelta mbsInt

            BigIntVariety (BigIntNodeVal bigInt) ->
                BigIntVariety <| BigIntNodeVal <| BigInt.sub bigInt <| BigInt.fromInt absDelta

            StringVariety (StringNodeVal string) ->
                StringVariety <| StringNodeVal <| String.dropRight absDelta string

            BoolVariety (BoolNodeVal mbBool) ->
                BoolVariety <| BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven absDelta)) mbBool

            MusicNoteVariety (MusicNoteNodeVal (MusicNotePlayer params)) ->
                MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :-: absDelta}

            NothingVariety NothingNodeVal ->
                NothingVariety NothingNodeVal


raiseWith : Int -> NodeVariety -> NodeVariety
raiseWith exp nodeVariety =
    let
        absExp = abs exp
    in
        case nodeVariety of
            IntVariety (IntNodeVal mbsInt) ->
                IntVariety <| IntNodeVal <| intOperation (^) absExp mbsInt

            BigIntVariety (BigIntNodeVal bigInt) ->
                BigIntVariety <| BigIntNodeVal <| Lib.raiseBigInt absExp bigInt

            StringVariety (StringNodeVal string) ->
                StringVariety <| StringNodeVal <| string

            BoolVariety (BoolNodeVal mbBool) ->
                BoolVariety <| BoolNodeVal <| mbBool

            MusicNoteVariety (MusicNoteNodeVal player) ->
                MusicNoteVariety <| MusicNoteNodeVal <| player

            NothingVariety NothingNodeVal ->
                NothingVariety NothingNodeVal


intOperation : (Int -> Int -> Int) -> Int -> MaybeSafe Int -> MaybeSafe Int
intOperation operation operand mbsInt =
    let
        fn = \int ->
          operand
              |> operation int
              |> toMaybeSafeInt
    in
        MaybeSafe.map fn mbsInt