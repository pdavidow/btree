module TreeType exposing (TreeType(..))

import BTreeUniformType exposing (BTreeUniform)
import BTreeVariedType exposing (BTreeVaried)


type TreeType
    = Uniform (BTreeUniform)
    | Varied (BTreeVaried)
