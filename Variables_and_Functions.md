---
title: Variables~andFunctions~
---

``` {.ocaml}

let x = 3;;

```

let &lt;variable&gt; = &lt;expr1&gt; in &lt;expr2&gt;

``` {.ocaml}

let languages = "OCaml, Perl, C++, C";;

```

``` {.ocaml}

let dashed_languages = 
  let language_list = String.split languages ~on:',' in
  String.concat ~sep:"-" language_list
;;

```
