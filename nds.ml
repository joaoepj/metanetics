(* Network Domain Specification *)

type value = [
  | `List of value list
  | `Kind
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
  | `Kind    -> printf "KIND"
  | `Ident id	-> printf "IDENT %s" id

and print_list outc arr =
  output_string outc "[";
  List.iteri ~f:(fun i v ->
      if i > 0 then
        output_string outc ", ";
      output_value outc v) arr;
  output_string outc "]" 
