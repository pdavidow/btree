-- http://elm-lang.org/examples/binary-Tree

module BTree exposing (..)

type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


empty : BTree a
empty =
    Empty


singleton : a -> BTree a
singleton v =
    Node v Empty Empty


insert : comparable -> BTree comparable -> BTree comparable
insert x tree =
    case tree of
      Empty ->
          singleton x

      Node y left right ->
          if x > y then
              Node y left (insert x right)

          else if x < y then
              Node y (insert x left) right

          else
              tree


fromList : List comparable -> BTree comparable
fromList xs =
    List.foldl insert empty xs


depth : BTree a -> Int
depth tree =
    case tree of
      Empty -> 0
      Node v left right ->
          1 + max (depth left) (depth right)

