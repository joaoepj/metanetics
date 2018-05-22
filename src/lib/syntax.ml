

type ty =
  | KindTy of Symbol.t Location.loc
  | SubkindTy of Symbol.t Location.loc
  | RoleTy of Symbol.t Location.loc
  | RelationTy of Symbol.t Location.loc
  | UniversalTy of Symbol.t Location.loc

(*and exp =
  |*)

and dec =
  | TypeDec of typedec Location.loc list

and typedec = {
  type_name : Symbol.t Location.loc;
  typ: ty;
}
