module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers, safeIsPrime)

import Arithmetic exposing (isEven, isPrime)
import MusicNote exposing (MusicNote, (:+:), (:-:))
import Constants exposing (maxSafeInt)


type alias Mappers =
    { int : Int -> Int -> Int
    , string : Int -> String -> String
    , bool : Int -> Bool -> Bool
    , musicNote : Int -> Maybe MusicNote -> Maybe MusicNote
    }


incrementMappers = Mappers incrementInt incrementString incrementBool incrementMusicNote
decrementMappers = Mappers decrementInt decrementString decrementBool decrementMusicNote
raiseMappers = Mappers raiseInt raiseString raiseBool raiseMusicNote


incrementInt : Int -> Int -> Int
incrementInt delta i =
    i + (abs delta)


decrementInt : Int -> Int -> Int
decrementInt delta i =
    i - (abs delta)


raiseInt : Int -> Int -> Int
raiseInt exp i =
    i ^ (abs exp)


incrementString : Int -> String -> String
incrementString delta s =
    s ++ " +" ++ (toString (abs delta))


decrementString : Int -> String -> String
decrementString delta s =
    s ++ " -" ++ (toString (abs delta))


raiseString : Int -> String -> String
raiseString exp s =
    s ++ " ^" ++ (toString (abs exp))


incrementBool : Int -> Bool -> Bool
incrementBool delta b =
    if (Arithmetic.isEven (abs delta)) then
        b
    else
        not b


decrementBool : Int -> Bool -> Bool
decrementBool delta b =
    if (Arithmetic.isEven (abs delta)) then
        b
    else
        not b


raiseBool : Int -> Bool -> Bool
raiseBool exp b =
    if (Arithmetic.isEven (abs exp)) then
        b
    else
        not b


incrementMusicNote : Int -> Maybe MusicNote -> Maybe MusicNote
incrementMusicNote delta mbNote =
    mbNote :+: (abs delta)


decrementMusicNote : Int -> Maybe MusicNote -> Maybe MusicNote
decrementMusicNote delta mbNote =
    mbNote :-: (abs delta)


raiseMusicNote : Int -> Maybe MusicNote -> Maybe MusicNote
raiseMusicNote exp mbNote =
    mbNote


-- https://github.com/elm-lang/elm-compiler/issues/1246
safeIsPrime : Int -> Maybe Bool
safeIsPrime n =
    if (abs n) > maxSafeInt then
        Debug.log (("abs n" ++ (toString (abs n)) toString n) Nothing
    else
        Just (Arithmetic.isPrime (Debug.log "Just n" n))