---
title: Ocaml~basic~
---

Tuples List Options, and Pattern Matching
=========================================

Tuples
------

Tuples 里有不同类型的元素

``` {.ocaml}
let a_tuple = (3,"three");;

```

    let another_tuple = (3, "four", 5);;

Tuples using Ocaml's pattern-matching

``` {.ocaml .rundoc-block rundoc-language="ocaml" rundoc-results="output"}
let (x,y) = a_tuple;;
```

``` {.ocaml}
x + String.length y;;
```

Pattern matching can also show up in function arguments

``` {.ocaml}
let distance (x1, y1) (x2, y2) =
  sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.)

```

RESULTS: val distance : float \* float -&gt; float \* float -&gt; float
= &lt;fun&gt;

List
====

List 中的元素必须是相同的 Type

``` {.ocaml}
let languages = ["Ocaml";"perl";"C"];;

```

``` {.ocaml}
let numbers = [3;"four";5];;

```

The List module
---------------

``` {.ocaml}

List.length languages;;

```

``` {.ocaml}
List.map languages ~f:String.length;;

```

Constructing lists with::

``` {.ocaml}
"French" :: "Spanish" :: languages;;

```

注： List 用 ； 来分割元素 Tuple 用 ， 来分割元素

两个 List 连接用 @ 而不是 ::

``` {.ocaml}
[1;2;3] @ [4;5;6];;


```

List patterns using match
-------------------------

``` {.ocaml}
let my_favorite_language (my_favorite :: the_rest) =
  my_favorite
;;

```

Characters 25-67: .........................(my~favorite~ :: the~rest~) =
my~favorite~ Warning 8: this pattern-matching is not exhaustive. Here is
an example of a case that is not matched: \[\] val my~favoritelanguage~
: 'a list -&gt; 'a = &lt;fun&gt;

这个类似于 Lisp 中的 cdr 和 car

``` {.commonlisp}

(car '(1 2 3))

```

``` {.commonlisp}

(cdr '(1 2 3 4))

```

``` {.ocaml}
my_favorite_language ["English";"Spanish";"French"];;

```

Match
-----

``` {.ocaml}

let my_favorite_language languages =
  match languages with
  | first :: the_rest -> first
  | [] -> "Ocaml" (* A good default*)

```

``` {.ocaml}

my_favorite_language ["English";"Spanish";"French"];;

```

Recursive list functions
------------------------
