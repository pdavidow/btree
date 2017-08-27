module MaybeSafe exposing (MaybeSafe(..), isSafe, isSafeInt, toMaybeSafe, toMaybeSafeInt, maxSafeInt, sumMaybeSafeInt, compare, withDefault, map, unwrap, toOnlySafe, toOnlySafeInt)

import List.Extra exposing (last)
import Basics.Extra exposing (isSafeInteger, maxSafeInteger)

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
maxSafeInt =
    Basics.Extra.maxSafeInteger


-- todo https://github.com/elm-community/basics-extra/issues/7
isSafeInt : Int -> Bool
isSafeInt int =
    Basics.Extra.isSafeInteger int


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
    list
        |> List.filter isSafe
        |> List.map (withDefault unusedDefault)


toOnlySafeInt : List (MaybeSafe Int) -> List Int
toOnlySafeInt list =
    toOnlySafe 0 list


withDefault : a -> MaybeSafe a -> a
withDefault default mbsA =
    unwrap default identity mbsA


map : (a -> MaybeSafe b) -> MaybeSafe a -> MaybeSafe b
map fn mbsA =
    unwrap Unsafe fn mbsA


unwrap : b -> (a -> b) -> MaybeSafe a -> b
unwrap default fn mbsVal =
    case mbsVal of
        Unsafe ->
            default

        Safe val ->
            fn val


compare: MaybeSafe comparable -> MaybeSafe comparable -> Order
compare mbsC mbsD =
    -- arbitrarily hold that Safe < Unsafe (Unsafe reminds of Infinity for Int)
    case (mbsC, mbsD) of
        (Safe c, Safe d) -> Basics.compare c d
        (Safe _, Unsafe) -> LT
        (Unsafe, Unsafe) -> EQ
        (Unsafe, Safe _) -> GT