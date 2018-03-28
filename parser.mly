%token <int> INT
%token <string> STRING
%token <string> IDENT
%token NULL
%token KIND IDENTIFY RECOGNIZE BEHAVE
%token EOF
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token COLON
%token COMMA


%start <Nds.value option> grammar
%%

grammar:
  | EOF		{ None }
  | v = value 	{ Some v }
  

value:
  | LEFT_BRACK vl = array_values RIGHT_BRACK	
	{ `List vl }
  | KIND COMMA COMMA id = IDENT k = kind	
	{ match k with (i, r, b) -> `Kind (id, i, r, b)  }
  | s = STRING	
	{ `String s }
  | id = IDENT
	{ `Ident id }
  | i = INT	
	{ `Int i }
  | NULL	
	{ `Null }
  

kind:
  | IDENTIFY COMMA i = STRING  RECOGNIZE COMMA r = STRING BEHAVE COMMA b = STRING
	{ (i, r, b) }

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
