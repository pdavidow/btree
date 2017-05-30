module MusicScaleType exposing (MusicScaleType(..), sortOrder)


type MusicScaleType
    = A -- todo Int == octave ...
    | A_sharp
    | B
    | C
    | C_sharp
    | D
    | D_sharp
    | E
    | F
    | F_sharp
    | G
    | G_sharp


sortOrder : MusicScaleType -> String
sortOrder note =
    toString note