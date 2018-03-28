(* Network Domain Specification *)


type value = [
  | `List of value list
  | `Kind of (string * string * string * string)
  | `Int of int
  | `Null
  | `Ident of string
  | `String of string
]


open Core
let rec output_value outc = function
  | `List l	-> print_list outc l
  | `String s   -> printf "\"%s\"" s
  | `Int i      -> printf "INT %d" i
  | `Null    -> printf "NULL"
  | `Kind k   -> print_kind k
  | `Ident id	-> printf "IDENT %s" id

and print_list outc arr =
  output_string outc "[";
  List.iteri ~f:(fun i v ->
      if i > 0 then
        output_string outc ", ";
      output_value outc v) arr;
  output_string outc "]"

and print_kind k =
  match k with (id, i, r, b) -> printf "KIND( id: %s, identify: %s, recognize: %s, behave: %s)" id,i,r,b 
