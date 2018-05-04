open Ppxlib
open Base

let ext_key = "nds"

(* expands `s` in `let%nk x = {| s |}` *)
let expand_nk_string ~loc s =
  let pos = Location.(loc.loc_start) in
  (* string starts after '{' and '|' *)
  let pos = Lexing.{ pos with pos_cnum = pos.pos_cnum + 2 } in
  Lexer.parse_string ~ppx:true ~pos s Parser.()

let expand_nk_string2 ~loc s =
  {[
        Pstr_value Nonrec
        [
            expression (loc)
              Pexp_constant PConst_string (s ^ "123456",Some "")
        ]

 ]} 

(* expands `e` in `let%nk x = e` *)
let expand_bound_expr expr =
  let loc = expr.pexp_loc in
  match expr.pexp_desc with
  (* only expand e if e = {| s |} *)
  | Pexp_constant (Pconst_string (s, Some "")) ->
    { (expand_nk_string2 ~loc s) with pexp_loc = loc }
  | _ ->
    Location.raise_errorf ~loc "'let%%%s' may only bind quoted NetKAT" ext_keyw

(* expands `x=e` in `let%nk x = e` *)
let expand_binding ~pred binding =
  { binding with pvb_expr = expand_bound_expr ~pred binding.pvb_expr }

(* expands `let%nk <bindings>` *)
let expand_let_decl ~loc ~path:_ bindings =
  let module B = Ast_builder.Make(struct let loc = loc end) in
  B.(pstr_value Nonrecursive (List.map bindings ~f:(expand_binding)))


(* declare `let%nds x = e` extension *)
let ext =
  Extension.declare
    ext_key 
    Extension.Context.structure_item
    Ast_pattern.(pstr (pstr_value nonrecursive __ ^:: nil))
    (fun ~path ~loc <parsed-payload...> -> <expansion>)

Ppx_driver.register_transformation "metanetics" ~extensions:[ext]
