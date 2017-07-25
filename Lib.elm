module Lib exposing (lazyUnwrap, digitCount)

import Lazy exposing (Lazy, force)

import MaybeSafe exposing (MaybeSafe(..))


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
                    abs int
                        |> toFloat
                        |> logBase 10
                        |> floor
                        |> (+) 1
                        |> Safe