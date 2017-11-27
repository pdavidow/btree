module TreeRandomInsertStyle exposing (TreeRandomInsertStyle(..), treeRandomInsertStyleOptions)

-- ### must keep in sync ################
type TreeRandomInsertStyle
    = Random
    | Right
    | Left
treeRandomInsertStyleOptions : List TreeRandomInsertStyle
treeRandomInsertStyleOptions =
    [ Random
    , Right
    , Left
    ]
-- #####################################
