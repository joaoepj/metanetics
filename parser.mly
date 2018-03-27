%token <int> INT
%token <string> STRING
%token <string> IDENT
%token NULL
%token KIND IDENTIFY
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
  | k = KIND 	
	{ `Kind }
  | s = STRING	
	{ `String s }
  | id = IDENT
	{ `Ident id }
  | i = INT	
	{ `Int i }
  | NULL	
	{ `Null }
  

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
