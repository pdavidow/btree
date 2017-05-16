module ValueOps exposing (..)

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