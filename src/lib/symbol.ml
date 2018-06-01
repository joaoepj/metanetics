open Core_kernel

(*
type t = int * string [@@deriving sexp]

let symbol =
  let table = Hashtbl.create 128 in
  let n = ref (-1) in
  function name ->
    try
      Hashtbl.find table name, name
    with Not_found ->
      incr n;
      Hashtbl.add table name !n;
      !n, name

let name = snd

module Ord = struct
  type symbol = t
  type t = symbol

  let compare (n1, _sym1) (n2, _sym2) =
    Pervasives.compare n1 n2
end

module Table = Map.Make (Ord)
*)

type t = int * string [@@deriving compare, sexp_of, hash]

let symbol =
  let table = Hashtbl.create (module Symbol) in
  try Hashtbl.find table symbol
   with Not_found -> Hashtbl.add table symbol
  
