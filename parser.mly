%token <int> INT
%token <string> STRING
%token NULL
%token EOF

%start <Nds.value option> grammar
%%

grammar:
  | EOF		{ None }
  | v = value	{ Some v }
  ;

value:
  | s = STRING	{ `String s }
  | i = INT	{ `Int i }
  | NULL	{ `Null }
  ;
