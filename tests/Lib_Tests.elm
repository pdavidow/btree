module Lib_Tests exposing (..)

import Lib exposing (lazyUnwrap, digitCount, digitCountBigInt, raiseBigInt, isEvenBigInt, isOddBigInt)

import MaybeSafe exposing (MaybeSafe(..), maxSafeInt, toMaybeSafeInt)
import BigInt exposing (fromInt)

import Lazy exposing (lazy)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


lib : Test
lib =
    describe "Lib module"
         [ describe "Lib.lazyUnwrap"
            [ test "Nothing" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "5" (Lib.lazyUnwrap lazyDefault toString Nothing)
            , test "Just" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "3" (Lib.lazyUnwrap lazyDefault toString (Just 3))
            ]
         , describe "Lib.digitCount"
            [ test "positive" <|
                \() ->
                    Expect.equal (Safe 5) (Lib.digitCount <| Safe <| 12321)
            , test "negative" <|
                \() ->
                    Expect.equal (Safe 5) (Lib.digitCount  <| Safe <| -12321)
            , test "zero" <|
                \() ->
                    Expect.equal (Safe 1) (Lib.digitCount  <| Safe <| 0)
            , test "Unsafe" <|
                \() ->
                    Expect.equal Unsafe (Lib.digitCount <| toMaybeSafeInt <| 1234 ^ 5678)
            ]
         , describe "Lib.raiseBigInt"
            [ test "raiseBigInt.1" <|
                \() ->
                    Expect.equal (BigInt.fromInt 1) (Lib.raiseBigInt 0 <| BigInt.fromInt 3)
            , test "raiseBigInt.2" <|
                \() ->
                    Expect.equal (BigInt.fromInt 3) (Lib.raiseBigInt 1 <| BigInt.fromInt 3)
            , test "raiseBigInt.3" <|
                \() ->
                    Expect.equal (BigInt.fromInt 9) (Lib.raiseBigInt 2 <| BigInt.fromInt 3)
            , test "raiseBigInt.4" <|
                \() ->
                    Expect.equal (BigInt.fromInt -3) (Lib.raiseBigInt 1 <| BigInt.fromInt -3)
            , test "raiseBigInt.5" <|
                \() ->
                    Expect.equal (BigInt.fromInt 9) (Lib.raiseBigInt 2 <| BigInt.fromInt -3)
            , test "raiseBigInt.6" <|
                \() ->
                    Expect.equal (BigInt.fromInt 3) (Lib.raiseBigInt -1 <| BigInt.fromInt 3)
            , test "raiseBigInt.7" <|
                \() ->
                    Expect.equal (BigInt.fromInt 9) (Lib.raiseBigInt -2 <| BigInt.fromInt 3)
            , test "raiseBigInt.8" <|
                \() ->
                    Expect.equal (BigInt.fromInt -3) (Lib.raiseBigInt -1 <| BigInt.fromInt -3)
            , test "raiseBigInt.9" <|
                \() ->
                    Expect.equal (BigInt.fromInt 9) (Lib.raiseBigInt -2 <| BigInt.fromInt -3)
            , test "raiseBigInt.10" <|
                \() ->
                    Expect.equal (BigInt.mul (BigInt.fromInt maxSafeInt) (BigInt.fromInt maxSafeInt)) (Lib.raiseBigInt 2 <| BigInt.fromInt maxSafeInt)
            ]
         , describe "Lib.digitCountBigInt"
            [ test "positive" <|
                \() ->
                    Expect.equal (Safe 5) (Lib.digitCountBigInt <| BigInt.fromInt <| 12321)
            , test "negative" <|
                \() ->
                    Expect.equal (Safe 5) (Lib.digitCountBigInt  <| BigInt.fromInt <| -12321)
            , test "zero" <|
                \() ->
                    Expect.equal (Safe 1) (Lib.digitCountBigInt  <| BigInt.fromInt <| 0)
            , test "huge positive" <|
                \() ->
                    Expect.equal (Safe 16) (Lib.digitCountBigInt  <| BigInt.fromInt <| maxSafeInt + 1)
            , test "huge negative" <|
                \() ->
                    Expect.equal (Safe 16) (Lib.digitCountBigInt  <| BigInt.fromInt <| negate <| maxSafeInt + 1)
            ]
         , describe "Lib.isEvenBigInt"
            [ test "isEvenBigInt.1" <|
                \() ->
                    Expect.equal True (Lib.isEvenBigInt <| BigInt.fromInt <| 4)
            , test "isEvenBigInt.2" <|
                \() ->
                    Expect.equal False (Lib.isEvenBigInt <| BigInt.fromInt <| 3)
            , test "isEvenBigInt.3" <|
                \() ->
                    Expect.equal True (Lib.isEvenBigInt <| BigInt.add (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt 1))
            , test "isEvenBigInt.4" <|
                \() ->
                    Expect.equal False (Lib.isEvenBigInt <| BigInt.add (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt 2))
            , test "isEvenBigInt.5" <|
                \() ->
                    Expect.equal False (Lib.isEvenBigInt <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInt) (BigInt.fromInt -2))
            ]
         , describe "Lib.isOddBigInt"
            [ test "isOddBigInt.1" <|
                \() ->
                    Expect.equal False (Lib.isOddBigInt <| BigInt.fromInt <| 4)
            , test "isOddBigInt.2" <|
                \() ->
                    Expect.equal True (Lib.isOddBigInt <| BigInt.fromInt <| 3)
            , test "isOddBigInt.3" <|
                \() ->
                    Expect.equal False (Lib.isOddBigInt <| BigInt.add (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt 1))
            , test "isOddBigInt.4" <|
                \() ->
                    Expect.equal True (Lib.isOddBigInt <| BigInt.add (BigInt.fromInt <| maxSafeInt) (BigInt.fromInt 2))
            , test "isOddBigInt.5" <|
                \() ->
                    Expect.equal True (Lib.isOddBigInt <| BigInt.add (BigInt.fromInt <| negate <| maxSafeInt) (BigInt.fromInt 2))
            ]
        ]

