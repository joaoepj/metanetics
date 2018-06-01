open Core_kernel
module Lexing = Mylexing


type t = {
  startpos : Lexing.position;
  endpos : Lexing.position;
}[@@deriving sexp]  

let dummy = {
  startpos = Lexing.dummy_pos;
  endpos = Lexing.dummy_pos;
}

type 'a loc = {
  item : 'a;
  loc : t;
}[@@deriving sexp] 

let mk startpos endpos =
  { startpos; endpos }

let mkloc item loc =
  { item; loc }

let mkdummy item =
  { item; loc = dummy }
