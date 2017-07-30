module MaybeSafe_Tests exposing (..)

import MaybeSafe exposing (MaybeSafe(..), isSafe, isSafeInt, toMaybeSafe, toMaybeSafeInt, maxSafeInt, sumMaybeSafeInt)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


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
                    Expect.equal True (MaybeSafe.isSafeInt maxSafeInt)
            , test "isSafeInt.3" <|
                \() ->
                    Expect.equal False (MaybeSafe.isSafeInt <| maxSafeInt + 1)
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
                    Expect.equal (Safe maxSafeInt) (MaybeSafe.toMaybeSafeInt maxSafeInt)
            , test "toMaybeSafeInt.3" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.toMaybeSafeInt <| negate <| maxSafeInt + 1)
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
                    Expect.equal (Safe maxSafeInt) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInt])
            , test "sumMaybeSafeInt.6" <|
                \() ->
                    Expect.equal (Safe <| maxSafeInt - 1) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInt, Safe -1])
            , test "sumMaybeSafeInt.7" <|
                \() ->
                    Expect.equal (Safe <| maxSafeInt - 1) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInt, Safe -2, Safe 1])
            , test "sumMaybeSafeInt.8" <|
                \() ->
                    Expect.equal (Unsafe) (MaybeSafe.sumMaybeSafeInt [Safe maxSafeInt, Safe 1, Safe -2])
            ]
        ]

