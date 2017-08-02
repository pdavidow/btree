module NodeTag exposing (NodeTag(..))

import MaybeSafe exposing (MaybeSafe)
import MusicNotePlayer exposing (MusicNotePlayer)
import BigInt exposing (BigInt)


type NodeTag
    = IntNode (MaybeSafe Int)
    | BigIntNode BigInt
    | StringNode String
    | BoolNode (Maybe Bool)
    | MusicNoteNode MusicNotePlayer
    | NothingNode