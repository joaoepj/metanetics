Metanetics is an ontological SDN programming language


Compiling

$ cd Metanetics
$ ocamlbuild -use-menhir  -tag thread -use-ocamlfind  -pkg core metanetics.native

Testing

$ ./metanetics.native source-code.nds
