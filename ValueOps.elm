module ValueOps exposing (Mappers, incrementMappers, decrementMappers, raiseMappers)

type alias Mappers =
    { int : Int -> Int -> Int
    , string : Int -> String -> String
    }


incrementMappers = Mappers incrementInt incrementString
decrementMappers = Mappers decrementInt decrementString
raiseMappers = Mappers raiseInt raiseString


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
raiseString delta s =
    s ++ " ^" ++ (toString delta)