module CustomFunctions exposing (lazyUnwrap, digitCount)

import Lazy exposing (Lazy, force)


-- todo https://github.com/maxsnew/lazy/commit/c9c3f85
lazyUnwrap : Lazy b -> (a -> b) -> Maybe a -> b
lazyUnwrap lazy fn mbA =
    case mbA of
        Just a ->
            fn a

        Nothing ->
            Lazy.force lazy


digitCount : Int -> Int
digitCount i =
    -- https://elmlang.slack.com/archives/C0CJ3SBBM/p1500404055237431
    if i == 0
        then
            1
        else
            abs i
                |> toFloat
                |> logBase 10
                |> floor
                |> (+) 1