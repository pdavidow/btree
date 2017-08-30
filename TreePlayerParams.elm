module TreePlayerParams exposing (TreePlayerParams, defaultTreePlayerParams)

import Time exposing (Time, millisecond)
import BTree exposing (TraversalOrder(..))


type alias TreePlayerParams =
    { traversalOrder : TraversalOrder
    --, isPlaying : Bool
    --, isRepeat : Bool
    , noteDuration : Time
    , gapDuration : Time
    }


defaultTreePlayerParams : TreePlayerParams
defaultTreePlayerParams =
    { traversalOrder = InOrder
    --, isPlaying = False
    --, isRepeat = False
    , noteDuration = 750 * millisecond
    , gapDuration = 250 * millisecond
    }

