module NodeTag exposing (NodeTag(..))

import MaybeSafe exposing (MaybeSafe)
import MusicNotePlayer exposing (MusicNotePlayer)


type NodeTag
    = IntNode (MaybeSafe Int)
    | StringNode String
    | BoolNode (Maybe Bool)
    | MusicNoteNode MusicNotePlayer
    | NothingNode