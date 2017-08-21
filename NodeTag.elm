module NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))

import MaybeSafe exposing (MaybeSafe)
import MusicNotePlayer exposing (MusicNotePlayer)
import BigInt exposing (BigInt)


type IntNode = IntNodeVal (MaybeSafe Int)
type BigIntNode = BigIntNodeVal (BigInt)
type StringNode = StringNodeVal (String)
type BoolNode = BoolNodeVal (Maybe Bool)
type MusicNoteNode = MusicNoteNodeVal (MusicNotePlayer)
type NothingNode = NothingNodeVal


type NodeVariety
    = IntVariety IntNode
    | BigIntVariety BigIntNode
    | StringVariety StringNode
    | BoolVariety BoolNode
    | MusicNoteVariety MusicNoteNode
    | NothingVariety NothingNode