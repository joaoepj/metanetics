(*
val position_of_sexp : Sexplib0.Sexp.t -> position = <fun>
val sexp_of_position : position -> Sexplib0.Sexp.t = <fun>
*)
open Core_kernel
include Lexing

let position_of_sexp  (Sexp.List[ Sexp.List [
      Sexp.Atom "pos_fname";
      Sexp.Atom str_pos_fname
    ];
    Sexp.List [
      Sexp.Atom "pos_lnum";
      Sexp.Atom str_pos_lnum
    ];
    Sexp.List [
      Sexp.Atom "pos_bol";
      Sexp.Atom str_pos_bol 
    ];
    Sexp.List [
      Sexp.Atom "pos_cnum";
      Sexp.Atom str_pos_cnum
    ] 
  ]) = {Lexing.pos_fname = str_pos_fname; pos_lnum = (int_of_string str_pos_lnum);
        pos_bol = (int_of_string str_pos_bol); pos_cnum = (int_of_string str_pos_cnum)}


let sexp_of_position {Lexing.pos_fname; pos_lnum; pos_bol; pos_cnum} =
  Sexp.List [
    Sexp.List [
      Sexp.Atom "pos_fname";
      Sexp.Atom pos_fname
    ];
    Sexp.List [
      Sexp.Atom "pos_lnum";
      Sexp.Atom (string_of_int pos_lnum)
    ];
    Sexp.List [
      Sexp.Atom "pos_bol";
      Sexp.Atom (string_of_int pos_bol)
    ];
    Sexp.List [
      Sexp.Atom "pos_cnum";
      Sexp.Atom (string_of_int pos_cnum)
    ]
  ]
  
