module NodeValueOperation exposing (Operation(..), operateOnInt, operateOnBigInt, operateOnString, operateOnBool, operateOnMusicNote, operateOnNothing)

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


intOperation : (Int -> Int -> Int) -> Int -> MaybeSafe Int -> MaybeSafe Int
intOperation operation operand mbsInt =
    let
        fn = \int ->
          operand
              |> operation int
              |> toMaybeSafeInt
    in
        MaybeSafe.map fn mbsInt


operateOnInt : Operation -> IntNode -> IntNode
operateOnInt operation node =
    let
        (IntNodeVal mbsInt) = node
    in
        case operation of
            Increment delta ->
                IntNodeVal <| intOperation (+) (abs delta) mbsInt

            Decrement delta ->
                IntNodeVal <| intOperation (-) (abs delta) mbsInt

            Raise exp ->
                IntNodeVal <| intOperation (^) (abs exp) mbsInt


operateOnBigInt : Operation -> BigIntNode -> BigIntNode
operateOnBigInt operation node =
    let
        (BigIntNodeVal bigInt) = node
    in
        case operation of
            Increment delta ->
                BigIntNodeVal <| BigInt.add bigInt <| BigInt.fromInt <| abs delta

            Decrement delta ->
                BigIntNodeVal <| BigInt.sub bigInt <| BigInt.fromInt <| abs delta

            Raise exp ->
                BigIntNodeVal <| Lib.raiseBigInt (abs exp) bigInt


operateOnString : Operation -> StringNode -> StringNode
operateOnString operation node =
    let
        (StringNodeVal string) = node
    in
        case operation of
            Increment delta ->
                StringNodeVal <| string ++ (toString <| abs delta)

            Decrement delta ->
                StringNodeVal <| String.dropRight (abs delta) string

            Raise _ ->
                node


operateOnBool : Operation -> BoolNode -> BoolNode
operateOnBool operation node =
    let
        (BoolNodeVal mbBool) = node
    in
        case operation of
            Increment delta ->
                BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven <| abs delta)) mbBool

            Decrement delta ->
                BoolNodeVal <| Maybe.map (\bool -> bool == (Arithmetic.isEven <| abs delta)) mbBool

            Raise _ ->
                node


operateOnMusicNote : Operation -> MusicNoteNode -> MusicNoteNode
operateOnMusicNote operation node =
    let
        (MusicNoteNodeVal (MusicNotePlayer params)) = node
    in
        case operation of
            Increment delta ->
                MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :+: abs delta}

            Decrement delta ->
                MusicNoteNodeVal <| MusicNotePlayer {params | mbNote = params.mbNote :-: abs delta}

            Raise _ ->
                node


operateOnNothing : Operation -> NothingNode -> NothingNode
operateOnNothing operation node =
    node