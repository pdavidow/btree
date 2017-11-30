module TreeType exposing (TreeType(..))

import BTreeUniform exposing (BTreeUniform)
import BTreeVariedType exposing (BTreeVaried)


type TreeType
    = Uniform (BTreeUniform)
    | Varied (BTreeVaried)
