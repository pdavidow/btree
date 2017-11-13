module TreePlayerParams exposing (PlaySpeed(..), TreePlayerParams, defaultTreePlayerParams, noteDurationFor, playSpeedOptions)

import Time exposing (Time, millisecond)
import BTree exposing (TraversalOrder(..))


-- ### must keep in sync ################
type PlaySpeed
    = Fast
    | Medium
    | Slow


playSpeedOptions : List PlaySpeed
playSpeedOptions =
    [ Fast
    , Medium
    , Slow
    ]
-- #####################################


type alias TreePlayerParams =
    { traversalOrder : TraversalOrder
    , playSpeed : PlaySpeed
    , gapDuration : Time
    }


defaultTreePlayerParams : TreePlayerParams
defaultTreePlayerParams =
    { traversalOrder = InOrder
    , playSpeed = Slow
    , gapDuration = 250 * millisecond
    }


noteDurationFor : PlaySpeed -> Time
noteDurationFor playSpeed =
    let
        increment = 250 * millisecond

        multiple =
            case playSpeed of
                Fast ->
                    1

                Medium ->
                    2

                Slow ->
                    3
    in
        multiple * increment
