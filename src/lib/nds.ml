(* Network Domain Specification *)
open Sexplib.Conv

type value = 
  | Kind of (string * string * string * string)
  | Subkind of (string * string * string * string * string)
  | Relator of (string list * string * string * string)
  | Role of (string * string * string * string)
  | Int of int
  | Null
  | Ident of string
  | String of string
  [@@deriving sexp]


open Core
let rec output_value outc = function
  | value	-> print_value value
  | String s   -> printf "\"%s\"" s
  | Int i      -> printf "INT %d" i
  | Null    -> printf "NULL"
  | Kind k   -> print_kind k
  | Ident id	-> printf "IDENT %s" id
  | Subkind s 	-> print_subkind s
  | Relator r	-> print_relator r
  | Role r  -> print_role r

(*and print_list outc arr =
  Out_channel.output_string outc "[";
  List.iteri ~f:(fun i v ->
      if i > 0 then
        Out_channel.output_string outc ", ";
      output_value outc v) arr;
  Out_channel.output_string outc "]"*)

and print_kind (kid, i, r, b) =
  printf "KIND( kid: %s, identify: %s, recognize: %s, behave: %s)" kid i r b

and print_subkind (kid, skid, i, r, b) =
  printf "SUBKIND( kid: %s, skid: %s, identify: %s, recognize: %s, behave: %s)" kid skid i r b

and print_relator (reltypes, relid, r, b) =
  printf "RELATOR( relatorid: %s, " relid;
  let rec print_rel = function       
    [] -> ()
    | e::l -> printf "relatedid: %s" e ; print_string ", " ; print_rel l in
  print_rel reltypes;
  printf "recognize: %s, behave: %s)" r b

and print_role (rid, kid, r, b) =
  printf "ROLE(roleid: %s kindid: %s, recognize: %s, behave: %s)" rid kid  r b
and print_value v =
  sexp_of_value v |> Sexplib.Sexp.to_string_hum |> print_string

