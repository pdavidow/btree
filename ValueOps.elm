module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)

import Arithmetic exposing (isEven)
import BigInt exposing (BigInt, add, sub)

import MusicNote exposing ((:+:), (:-:))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe(..), isSafeInt, toMaybeSafeInt, map)
import Lib exposing (raiseBigInt)


type alias Mappers =
    { int : Int -> MaybeSafe Int -> MaybeSafe Int
    , bigInt : Int -> BigInt -> BigInt
    , string : Int -> String -> String
    , bool : Int -> Maybe Bool -> Maybe Bool
    , musicNotePlayer : Int -> MusicNotePlayer -> MusicNotePlayer
    }


incrementMappers = Mappers incrementInt incrementBigInt incrementString incrementBool incrementMusicNoteInPlayer
decrementMappers = Mappers decrementInt decrementBigInt decrementString decrementBool decrementMusicNoteInPlayer
raiseMappers = Mappers raiseInt raiseBigInt raiseString raiseBool raiseMusicNoteInPlayer


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


incrementInt : Int -> MaybeSafe Int -> MaybeSafe Int
incrementInt delta mbsInt =
    intOp (+) delta mbsInt


decrementInt : Int -> MaybeSafe Int -> MaybeSafe Int
decrementInt delta mbsInt =
    intOp (-) delta mbsInt


raiseInt : Int -> MaybeSafe Int -> MaybeSafe Int
raiseInt exp mbsInt =
    intOp (^) exp mbsInt


incrementBigInt : Int -> BigInt -> BigInt
incrementBigInt delta bigInt =
    BigInt.add bigInt (BigInt.fromInt <| abs delta)


decrementBigInt : Int -> BigInt -> BigInt
decrementBigInt delta bigInt =
    BigInt.sub bigInt <| BigInt.fromInt <| abs delta


raiseBigInt : Int -> BigInt -> BigInt
raiseBigInt exp bigInt =
    Lib.raiseBigInt (abs exp) bigInt


incrementString : Int -> String -> String
incrementString delta s =
    s ++ toString (abs delta)


decrementString : Int -> String -> String
decrementString delta s =
    String.dropRight (abs delta) s


raiseString : Int -> String -> String
raiseString exp s =
    s


incrementBool : Int -> Maybe Bool -> Maybe Bool
incrementBool delta mbBool =
    let
        fn = \delta bool -> bool == Arithmetic.isEven (abs delta)
    in
        Maybe.map (fn delta) mbBool


decrementBool : Int -> Maybe Bool -> Maybe Bool
decrementBool delta mbBool =
    let
        fn = \delta bool -> bool == Arithmetic.isEven (abs delta)
    in
        Maybe.map (fn delta) mbBool


raiseBool : Int -> Maybe Bool -> Maybe Bool
raiseBool exp mbBool =
    mbBool


incrementMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
incrementMusicNoteInPlayer delta (MusicNotePlayer params) =
    MusicNotePlayer {params | mbNote = params.mbNote :+: (abs delta)}


decrementMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
decrementMusicNoteInPlayer delta (MusicNotePlayer params) =
    MusicNotePlayer {params | mbNote = params.mbNote :-: (abs delta)}


raiseMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
raiseMusicNoteInPlayer exp player =
    player