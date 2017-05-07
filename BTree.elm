-- http://elm-lang.org/examples/binary-Tree

module BTree exposing (..)

type BTree a
    = Empty
    | Node a (BTree a) (BTree a)


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
    List.foldl insert Empty xs


depth : BTree a -> Int
depth tree =
    case tree of
        Empty ->
            0

        Node v left right ->
            1 + max (depth left) (depth right)


map : (a -> b) -> BTree a -> BTree b
map func tree =
    case tree of
        Empty ->
            Empty

        Node v left right ->
            Node (func v) (map func left) (map func right)


sum : BTree number -> number
sum tree =
    case tree of
        Empty ->
            0

        Node number left right ->
            number + (sum left) + (sum right)


flatten : BTree a -> List a
flatten tree =
    case tree of
        Empty ->
            []

        Node v left right ->
            v :: ((flatten left) ++ (flatten right))


isElement : a -> BTree a -> Bool
isElement a tree =
    case tree of
        Empty ->
            False

        Node v left right ->
            if v == a then True
            else (isElement a left) || (isElement a right)


fold : (a -> b -> b) -> b -> BTree a -> b
fold func acc tree =
    case tree of
        Empty ->
            acc

        Node v left right ->
            let
                leftAcc = fold func (func v acc) left
            in
                fold func leftAcc right
