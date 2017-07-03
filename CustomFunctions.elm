module CustomFunctions exposing (lazyUnwrap)

import Lazy exposing (Lazy, force)


lazyUnwrap : Lazy b -> (a -> b) -> Maybe a -> b
lazyUnwrap lazy fn mbA =
    case mbA of
        Just a ->
            fn a

        Nothing ->
            Lazy.force lazy