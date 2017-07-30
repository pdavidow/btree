module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)

import Arithmetic exposing (isEven)

import MusicNote exposing ((:+:), (:-:))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe(..), isSafeInt, toMaybeSafeInt)


type alias Mappers =
    { int : Int -> MaybeSafe Int -> MaybeSafe Int
    , string : Int -> String -> String
    , bool : Int -> Maybe Bool -> Maybe Bool
    , musicNotePlayer : Int -> MusicNotePlayer -> MusicNotePlayer
    }


incrementMappers = Mappers incrementInt incrementString incrementBool incrementMusicNoteInPlayer
decrementMappers = Mappers decrementInt decrementString decrementBool decrementMusicNoteInPlayer
raiseMappers = Mappers raiseInt raiseString raiseBool raiseMusicNoteInPlayer


incrementInt : Int -> MaybeSafe Int -> MaybeSafe Int
incrementInt delta mbsInt =
    case mbsInt of -- todo refactor...
        Unsafe ->
            Unsafe

        Safe int ->
            delta
                |> abs
                |> (+) int
                |> toMaybeSafeInt


decrementInt : Int -> MaybeSafe Int -> MaybeSafe Int
decrementInt delta mbsInt =
    case mbsInt of -- todo refactor...
        Unsafe ->
            Unsafe

        Safe int ->
            delta
                |> abs
                |> (-) int
                |> toMaybeSafeInt


raiseInt : Int -> MaybeSafe Int -> MaybeSafe Int
raiseInt exp mbsInt =
    case mbsInt of -- todo refactor...
        Unsafe ->
            Unsafe

        Safe int ->
            exp
                |> abs
                |> (^) int
                |> toMaybeSafeInt


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