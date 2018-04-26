open Ppxlib

let ext_key = "nds"

(* declare `let%nds x = e` extension *)
let ext =
  Extension.declare
    ext_key 
    Expression.Context.structure_item
    Ast_pattern.(pstr (pstr_value nonrecursive __ ^:: nil))
    (fun ~path ~loc <parsed-payload...> -> <expansion>)

Ppx_driver.register ext_key ~extensions:[ext]
