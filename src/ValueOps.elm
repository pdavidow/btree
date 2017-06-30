module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)

import Arithmetic exposing (isEven)

import MusicNote exposing ((:+:), (:-:))
import MusicNotePlayer exposing (MusicNotePlayer(..))


type alias Mappers =
    { int : Int -> Int -> Int
    , string : Int -> String -> String
    , bool : Int -> Bool -> Bool
    , musicNotePlayer : Int -> MusicNotePlayer -> MusicNotePlayer
    }


incrementMappers = Mappers incrementInt incrementString incrementBool incrementMusicNoteInPlayer
decrementMappers = Mappers decrementInt decrementString decrementBool decrementMusicNoteInPlayer
raiseMappers = Mappers raiseInt raiseString raiseBool raiseMusicNoteInPlayer


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


incrementMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
incrementMusicNoteInPlayer delta (MusicNotePlayer params) =
    MusicNotePlayer {params | mbNote = params.mbNote :+: (abs delta)}


decrementMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
decrementMusicNoteInPlayer delta (MusicNotePlayer params) =
    MusicNotePlayer {params | mbNote = params.mbNote :-: (abs delta)}


raiseMusicNoteInPlayer : Int -> MusicNotePlayer -> MusicNotePlayer
raiseMusicNoteInPlayer exp player =
    player