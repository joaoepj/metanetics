%token <int> INT
%token <string> STRING
%token <string> IDENT
%token NULL
%token KIND SUBKIND RELATOR IDENTIFY RECOGNIZE BEHAVE
%token EOF
%token L_BRACE R_BRACE L_BRACK R_BRACK L_PAREN R_PAREN
%token COLON
%token COMMA


%start <Nds.value option> grammar
%%

grammar:
  | EOF		{ None }
  | v = value 	{ Some v }
  

value:
  | k = kind 		{ k }
  | s = subkind 	{ s }
  | r = relator 	{ r }
  | L_BRACK vl = array_values R_BRACK
        { `List vl }
  | s = STRING
        { `String s }
  | id = IDENT
        { `Ident id }
  | i = INT
        { `Int i }
  | NULL
        { `Null }



kind:
  | KIND COLON COLON kid = IDENT kattr = kindattr	
	{ match kattr with (identify, recognize, behave) -> `Kind (kid, identify, recognize, behave)  }

kindattr:
  | IDENTIFY COLON identify = STRING  RECOGNIZE COLON recognize = STRING BEHAVE COLON behave = STRING
	{ (identify, recognize, behave) }


subkind:
  | SUBKIND L_PAREN kid = IDENT R_PAREN COLON COLON skid = IDENT skattr = kindattr
        { match skattr with (identify, recognize, behave) -> `Subkind (kid, skid, identify, recognize, behave)  }

relator:
  | RELATOR L_PAREN related_type = IDENT R_PAREN COLON COLON relid = IDENT relattr = kindattr
        { match relattr with (identify, recognize, behave) -> `Relator (related_type, relid, recognize, behave)  }


array_values:
  | (* empty *) { [] }
  | vl = rev_values { List.rev vl }
  

rev_values:
  | v = value { [v] }
  | vl = rev_values; COMMA; v = value
    { v :: vl }
  

(*

%token AGGREGATE COMPOSE KIND SUBKIND ROLE RELATOR RELATION

*)
