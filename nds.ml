(* Network Domain Specification *)

type value = [
  | `Int of int
  | `Null
  | `String of string
]


open Core
let rec output_value outc = function
  | `String s   -> printf "\"%s\"" s
  | `Int i      -> printf "%d" i
  | `Null    -> printf "null" 
