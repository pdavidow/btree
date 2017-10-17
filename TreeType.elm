module TreeType exposing (TreeType(..))

import BTreeUniformType exposing (BTreeUniformType)
import BTreeVariedType exposing (BTreeVariedType)


type TreeType
    = Uniform (BTreeUniformType)
    | Varied (BTreeVariedType)
