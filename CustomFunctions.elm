module CustomFunctions exposing (lazyUnwrap)

import Lazy exposing (Lazy, force)


lazyUnwrap : Lazy b -> (a -> b) -> Maybe a -> b
lazyUnwrap lazy func mbA = --todo reanme global: func => fn
    case mbA of
        Just a ->
            func a

        Nothing ->
            Lazy.force lazy