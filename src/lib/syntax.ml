open Sexplib.Conv

type ty =
  | KindTy of Symbol.t Location.loc   
  | SubkindTy of Symbol.t Location.loc (* sexp_opaque *)
  | RoleTy of Symbol.t Location.loc (* sexp_opaque *)
  | RelationTy of Symbol.t Location.loc (* sexp_opaque *)
  

type exp =
(*  | Universal of Symbol.t Location.loc
  | Var of var Location.loc *)
  | Nil of unit Location.loc 
  | Int of int Location.loc
  | String of string Location.loc


and dec =
  | TypeDec of typedec Location.loc list

and typedec = {
  type_name : Symbol.t Location.loc;
  typ: ty;
}
(*  [@@deriving sexp] *)




(* let print_ty ty =
 sexp_of_ty ty |> Sexplib.Sexp.to_string_hum |> print_string *)
