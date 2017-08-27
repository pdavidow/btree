module MaybeSafe_Tests exposing (..)

import MaybeSafe exposing (MaybeSafe(..), isSafe, isSafeInt, toMaybeSafe, toMaybeSafeInt, sumMaybeSafeInt, compare, withDefault, map, unwrap, toOnlySafe, toOnlySafeInt)

import Arithmetic exposing (isOdd)
import Basics.Extra exposing (maxSafeInteger)

import Test exposing (..)
import Expect


maybeSafe : Test
maybeSafe =
    describe "MaybeSafe module"
         [ describe "MaybeSafe.isSafe"
            [ test "isSafe.1" <|
                \() ->
                    Expect.equal True (MaybeSafe.isSafe <| Safe 'q')
            , test "isSafe.2" <|
                \() ->
                    Expect.equal False (MaybeSafe.isSafe <| Unsafe)
            ]
         , describe "MaybeSafe.isSafeInt"
            [ test "isSafeInt.1" <|
                \() ->
                    Expect.equal True (MaybeSafe.isSafeInt 3)
            , test "isSafeInt.2" <|
                \() ->
                    Expect.equal True (MaybeSafe.isSafeInt maxSafeInteger)
            , test "isSafeInt.3" <|
                \() ->
                    Expect.equal False (MaybeSafe.isSafeInt <| maxSafeInteger + 1)
            ]
         , describe "MaybeSafe.toMaybeSafe"
            [ test "toMaybeSafe.1" <|
                \() ->
                    Expect.equal (Safe "a") (MaybeSafe.toMaybeSafe (\v -> True) "a")
            , test "toMaybeSafe.2" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.toMaybeSafe (\v -> False) "a")
            , test "toMaybeSafe.3" <|
                \() ->
                    let
                        isSafe : Int -> Bool
                        isSafe int =
                            (abs int) <= 55
                    in
                        Expect.equal (Unsafe) (MaybeSafe.toMaybeSafe isSafe 56)
            ]
         , describe "MaybeSafe.toMaybeSafeInt"
            [ test "toMaybeSafeInt.1" <|
                \() ->
                    Expect.equal (Safe 3) (MaybeSafe.toMaybeSafeInt 3)
            , test "toMaybeSafeInt.2" <|
                \() ->
                    Expect.equal (Safe maxSafeInteger) (MaybeSafe.toMaybeSafeInt maxSafeInteger)
            , test "toMaybeSafeInt.3" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.toMaybeSafeInt <| negate <| maxSafeInteger + 1)
            ]
         , describe "MaybeSafe.sumMaybeSafeInt"
            [ test "sumMaybeSafeInt.1" <|
                \() ->
                    Expect.equal (Safe 0) (MaybeSafe.sumMaybeSafeInt [Safe 0])
            , test "sumMaybeSafeInt.2" <|
                \() ->
                    Expect.equal (Safe 0) (MaybeSafe.sumMaybeSafeInt [Safe 1, Safe -1])
            , test "sumMaybeSafeInt.3" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.sumMaybeSafeInt [Unsafe])
            , test "sumMaybeSafeInt.4" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.sumMaybeSafeInt [Unsafe, Safe 1])
            , test "sumMaybeSafeInt.5" <|
                \() ->
                    Expect.equal (Safe maxSafeInteger) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInteger])
            , test "sumMaybeSafeInt.6" <|
                \() ->
                    Expect.equal (Safe <| maxSafeInteger - 1) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInteger, Safe -1])
            , test "sumMaybeSafeInt.7" <|
                \() ->
                    Expect.equal (Safe <| maxSafeInteger - 1) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInteger, Safe -2, Safe 1])
            , test "sumMaybeSafeInt.8" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInteger, Safe 1, Safe -2])
            ]
         , describe "MaybeSafe.compare"
            [ test "compare.Safe Safe LT" <|
                \() ->
                    Expect.equal LT (MaybeSafe.compare (Safe 0) (Safe 1))
            , test "compare.Safe Safe EQ" <|
                \() ->
                    Expect.equal EQ (MaybeSafe.compare (Safe 0) (Safe 0))
            , test "compare.Safe Safe GT" <|
                \() ->
                    Expect.equal GT (MaybeSafe.compare (Safe 1) (Safe 0))
            , test "compare.(Safe _, Unsafe) -> LT" <|
                \() ->
                    Expect.equal LT (MaybeSafe.compare (MaybeSafe.toMaybeSafeInt <| maxSafeInteger) (MaybeSafe.toMaybeSafeInt <| negate <| maxSafeInteger + 1))
            , test "compare.(Unsafe, Unsafe) -> EQ" <|
                \() ->
                    Expect.equal EQ (MaybeSafe.compare (MaybeSafe.toMaybeSafeInt <| maxSafeInteger + 1) (MaybeSafe.toMaybeSafeInt <| negate <| maxSafeInteger + 1))
            , test "compare.(Unsafe, Safe _) -> GT" <|
                \() ->
                    Expect.equal GT (MaybeSafe.compare (MaybeSafe.toMaybeSafeInt <| negate <| maxSafeInteger + 1) (MaybeSafe.toMaybeSafeInt <| maxSafeInteger))
            ]
         , describe "MaybeSafe.withDefault"
            [ test "Unsafe" <|
                \() ->
                    Expect.equal
                        0
                        (MaybeSafe.withDefault 0 <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger + 1)
            , test "Safe" <|
                \() ->
                    Expect.equal
                        maxSafeInteger
                        (MaybeSafe.withDefault 0 <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger)
            ]
         , describe "MaybeSafe.map"
            [ test "Unsafe" <|
                \() ->
                    Expect.equal
                        Unsafe
                        (MaybeSafe.map (\i -> Safe <| Arithmetic.isOdd i) <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger + 1)
            , test "Safe" <|
                \() ->
                    Expect.equal
                        (Safe True)
                        (MaybeSafe.map (\i -> Safe <| Arithmetic.isOdd i) <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger)
            ]
         , describe "MaybeSafe.unwrap"
            [ test "Unsafe" <|
                \() ->
                    Expect.equal
                        False
                        (MaybeSafe.unwrap False Arithmetic.isOdd <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger + 1)
            , test "Safe" <|
                \() ->
                    Expect.equal
                        True
                        (MaybeSafe.unwrap False Arithmetic.isOdd <| MaybeSafe.toMaybeSafeInt <| maxSafeInteger)
            ]
         , describe "MaybeSafe.toOnlySafe"
            [ test "empty" <|
                \() ->
                    Expect.equal
                        []
                        (MaybeSafe.toOnlySafe 'q' [])
            , test "toOnlySafe" <|
                \() ->
                    Expect.equal
                        ['a', 'c']
                        (MaybeSafe.toOnlySafe 'q' [Safe 'a', Unsafe, Safe 'c', Unsafe])
            ]
         , describe "MaybeSafe.toOnlySafeInt"
            [ test "empty" <|
                \() ->
                    Expect.equal
                        []
                        (MaybeSafe.toOnlySafeInt [])
            , test "toOnlySafeInt" <|
                \() ->
                    Expect.equal
                        [1, maxSafeInteger, negate <| maxSafeInteger]
                        (MaybeSafe.toOnlySafeInt [toMaybeSafeInt 1, toMaybeSafeInt maxSafeInteger, toMaybeSafeInt <| maxSafeInteger + 1, toMaybeSafeInt <| negate <| maxSafeInteger, toMaybeSafeInt <| negate <| maxSafeInteger +1])            ]
        ]