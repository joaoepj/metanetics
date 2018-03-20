%token <int> INT
%token <string> STRING
%token NULL
%token EOF

%start <Metanetics.value option> prog
%%

prog:
  | EOF		{ None }
  | v = value	{ Some v }
  ;

value:
  | s = STRING	{ `String s }
  | i = INT	{ `INt i }
  | NULL	{ `Null }
  ;
