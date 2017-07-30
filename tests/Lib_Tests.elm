module Lib_Tests exposing (..)

import Lib exposing (lazyUnwrap, digitCount)

import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)

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
        ]

