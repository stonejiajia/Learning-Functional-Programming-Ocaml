---
title: Files~ModulesPrograms~
---

Single-File Programs
====================

``` {.ocaml}
let assoc = [("one", 1); ("two",2); ("three",3)]

```

``` {.ocaml}
List.Assoc.find assoc "two"

```

``` {.ocaml}
List.Assoc.add assoc "four" 4

```

``` {.ocaml}
assoc

```

虽然 Add 了新的元素，但是原来的 accoc 中的元素没变。

``` {.ocaml}
open Core.Std

let build_counts () = 
  In_channel.fold_lines stdin ~init:[] ~f:(fun counts line ->
    let count = 
    match List.Assoc.find counts line with
    | None -> 0
    | Some x -> x
    in 
    List.Assoc.add counts ine (count + 1))

let () = 
  build_counts ()
|> List.sort ~cmp:(fun (_,x) (_,y) -> Int.descending x y)
|> (fun l -> List.take l 10)
|> List.iter ~f:(fun (line, count) -> printf "%3d: %s\n" count line)

```

OCaml ships with twi compilers.

1.  the ocamlc bytecode compiler ocamlc are interpreted by a virtual
    machine

2.  ocamlopt native-code compiler are compiled bto a native machine code
    to be run on a specific operating system and processor architecture

The byte code compiler is quicker than the native-code compiler

Multifile Programs and Modules
==============================

``` {.ocaml}


```
