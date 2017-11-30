module TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

import BigInt exposing (BigInt)

import BTreeUniform exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), uniformNothingTreeFrom)
import BTree exposing (BTree(..), fromListBy, singleton)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe)
import TreePlayerParams exposing (TreePlayerParams)


musicNotePlayerOnNothing : MusicNotePlayer
musicNotePlayerOnNothing =
   MusicNotePlayer
       { mbNote = Nothing
       , isPlaying = False
       , mbId = Nothing
       }


uniformNothingSingelton : BTreeUniform
uniformNothingSingelton =
    uniformNothingTreeFrom <| singleton <| NothingNodeVal


uniformNothing3Nodes : BTreeUniform
uniformNothing3Nodes =
    uniformNothingTreeFrom <| fromListBy Basics.toString  <| List.repeat 3 NothingNodeVal


toIntVariety : MaybeSafe Int -> NodeVariety
toIntVariety val =
    IntVariety <| IntNodeVal <| val


toBigIntVariety : BigInt -> NodeVariety
toBigIntVariety val =
    BigIntVariety <| BigIntNodeVal <| val   


toStringVariety : String -> NodeVariety
toStringVariety val =
    StringVariety <| StringNodeVal <| val


toBoolVariety : Maybe Bool -> NodeVariety
toBoolVariety val =
    BoolVariety <| BoolNodeVal <| val


toMusicNoteVariety : MusicNotePlayer -> NodeVariety
toMusicNoteVariety val =
    MusicNoteVariety <| MusicNoteNodeVal <| val
