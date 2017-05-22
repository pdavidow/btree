module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)
import Arithmetic exposing (isEven)

type alias Mappers =
    { int : Int -> Int -> Int
    , string : Int -> String -> String
    , bool: Int -> Bool -> Bool
    }


incrementMappers = Mappers incrementInt incrementString incrementBool
decrementMappers = Mappers decrementInt decrementString decrementBool
raiseMappers = Mappers raiseInt raiseString raiseBool


incrementInt : Int -> Int -> Int
incrementInt delta i =
    i + delta


decrementInt : Int -> Int -> Int
decrementInt delta i =
    i - delta


raiseInt : Int -> Int -> Int
raiseInt exp i =
    i ^ exp


incrementString : Int -> String -> String
incrementString delta s =
    s ++ " +" ++ (toString delta)


decrementString : Int -> String -> String
decrementString delta s =
    s ++ " -" ++ (toString delta)


raiseString : Int -> String -> String
raiseString exp s =
    s ++ " ^" ++ (toString exp)


incrementBool : Int -> Bool -> Bool
incrementBool delta b =
    if (Arithmetic.isEven delta) then
        b
    else
        not b


decrementBool : Int -> Bool -> Bool
decrementBool delta b =
    if (Arithmetic.isEven delta) then
        b
    else
        not b


raiseBool : Int -> Bool -> Bool
raiseBool exp b =
    if (Arithmetic.isEven exp) then
        b
    else
        not b