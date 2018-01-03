module TreeType exposing (TreeType(..))

import BTreeUniform exposing (BTreeUniform)
import BTreeVaried exposing (BTreeVaried)


type TreeType
    = Uniform (BTreeUniform)
    | Varied (BTreeVaried)
