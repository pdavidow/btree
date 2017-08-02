module Lib exposing (IntFlex(..), lazyUnwrap, digitCount, digitCountBigInt, raiseBigInt, isEvenBigInt, isOddBigInt)

import Lazy exposing (Lazy, force)
import BigInt exposing (BigInt, abs, mul, toString)

import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)


type IntFlex
    = IntVal (MaybeSafe Int)
    | BigIntVal BigInt


-- todo
-- todo https://github.com/maxsnew/lazy/commit/c9c3f85
lazyUnwrap : Lazy b -> (a -> b) -> Maybe a -> b
lazyUnwrap lazy fn mbA =
    case mbA of
        Just a ->
            fn a

        Nothing ->
            Lazy.force lazy


digitCount : MaybeSafe Int -> MaybeSafe Int
digitCount mbsInt =
    case mbsInt of
        Unsafe ->
            Unsafe

        Safe int ->
            -- https://elmlang.slack.com/archives/C0CJ3SBBM/p1500404055237431
            if int == 0
                then
                    Safe 1
                else
                    Basics.abs int
                        |> toFloat
                        |> logBase 10
                        |> floor
                        |> (+) 1
                        |> toMaybeSafeInt


digitCountBigInt : BigInt -> MaybeSafe Int
digitCountBigInt bigInt =
    -- hack, will fail on overflow
    BigInt.abs bigInt
        |> BigInt.toString
        |> String.length
        |> toMaybeSafeInt


raiseBigInt : Int -> BigInt -> BigInt
raiseBigInt exp bigInt =
    let
        absExp = Basics.abs exp
    in
        if absExp == 0
            then BigInt.fromInt 1
        else if absExp == 1
            then bigInt
        else
            List.foldl BigInt.mul bigInt <| List.repeat (absExp - 1) bigInt


isEvenBigInt : BigInt -> Bool
isEvenBigInt bigInt =
    ( BigInt.compare
        ( BigInt.mod bigInt (BigInt.fromInt 2) )
        ( BigInt.fromInt 0 )
    ) == EQ


isOddBigInt : BigInt -> Bool
isOddBigInt bigInt =
    not <| isEvenBigInt bigInt