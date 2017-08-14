module MaybeSafe exposing (MaybeSafe(..), isSafe, isSafeInt, toMaybeSafe, toMaybeSafeInt, maxSafeInt, sumMaybeSafeInt, compare)

import List.Extra exposing (last)


type MaybeSafe a
    = Unsafe
    | Safe a


toMaybeSafe : (a -> Bool) -> a -> MaybeSafe a
toMaybeSafe isSafe a =
    if isSafe a
        then Safe a
        else Unsafe


-- todo https://github.com/elm-community/basics-extra/issues/7
maxSafeInt : Int
maxSafeInt = (2 ^ 53) - 1


-- todo https://github.com/elm-community/basics-extra/issues/7
isSafeInt : Int -> Bool
isSafeInt int =
    (abs int) <= maxSafeInt


toMaybeSafeInt : Int -> MaybeSafe Int
toMaybeSafeInt int =
    toMaybeSafe isSafeInt int


sumMaybeSafeInt : List (MaybeSafe Int) -> MaybeSafe Int
sumMaybeSafeInt list =
    if List.any isUnsafe list
        then
            Unsafe
        else
            let
                intermediateResults = list
                    |> toOnlySafeInt
                    |> List.scanl (+) 0
                    |> List.map toMaybeSafeInt
            in
                if List.any isUnsafe intermediateResults
                        then
                            Unsafe
                        else
                            intermediateResults
                                |> List.Extra.last
                                |> Maybe.withDefault (Safe 0)


isUnsafe : MaybeSafe a -> Bool
isUnsafe mbsA =
    mbsA == Unsafe


isSafe : MaybeSafe a -> Bool
isSafe mbsA =
    not <| isUnsafe mbsA


toOnlySafe : a -> List (MaybeSafe a) -> List a
toOnlySafe unusedDefault list =
    let
        fn = \ mbsA ->
            case mbsA of
                Unsafe -> unusedDefault
                Safe a -> a
    in
        List.map fn <| List.filter isSafe list


toOnlySafeInt : List (MaybeSafe Int) -> List Int
toOnlySafeInt list =
    toOnlySafe 0 list


withDefault : a -> MaybeSafe a -> a
withDefault default mbsA =
    case mbsA of
        Unsafe -> default
        Safe a -> a


compare: MaybeSafe comparable -> MaybeSafe comparable -> Order
compare mbsC mbsD =
    -- arbitrarily hold that Safe < Unsafe (Unsafe reminds of Infinity for Int)
    case (mbsC, mbsD) of
        (Safe c, Safe d) -> Basics.compare c d
        (Safe _, Unsafe) -> LT
        (Unsafe, Unsafe) -> EQ
        (Unsafe, Safe _) -> GT