---
title: Variables~andFunctions~
---

Variables
=========

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

``` {.ocaml}

let languages = "OCaml, Perl, C++, C"

```

``` {.ocaml}

let dashed_language =
  let languages = String.split languages ~on:',' in 
  String.concat ~sep:"-" languages
;;

```

``` {.ocaml}
let area_of_ring inner_radius outer_radius = 
  let pi = acos (-1.) in 
  let area_of_circle r = pi *. r *. r in 
  area_of_circle outer_radius -. area_of_circle inner_radius

```

``` {.ocaml}

area_of_ring 1. 3.

```

shadowed
--------

``` {.ocaml}

let area_of_ring inner_radius outer_radius =
  let pi = acos (-1.) in 
  let area_of_circle r = pi *. r *. r in 
  let pi = 0. in 
  area_of_circle outer_radius -. area_of_circle inner_radius
;;

```

``` {.ocaml}

area_of_ring 1. 3.

```

重新定义了 pi, 但是结果和之前一样，因为最开始定义的 pi 没有变，只是被
shadowed, 意思就是之后的 pi 的值都是 0，但是第一个 pi
的值依旧不变，上段代码中并没有用到 pi = 0，所以结果还是一样。

在 OCaml 中 let bindings 是不可变的。

Pattern Matching and let
========================

``` {.ocaml}

let (ints, strings) = List.unzip [(1, "one"); (2, "two"); (3, "three")];;

```

(ints , strings) 是 pattern

Tuple and record patterns are irrefutable

``` {.ocaml}
let upcase_first_enty line = 
  let (first :: rest) = String.split ~on:',' line in 
  String.concat ~sep:"," (String.uppercase first :: rest)

```

由于 String.split 返回的是 List ， 且至少有一个元素，但是 Complier
不知道，所以 emits warning.

``` {.ocaml}

let upcase_first_enty line =
  match String.split ~on:',' line with
  | [] -> assert false 
  | first :: rest -> String.concat ~sep:"," (String.uppercase first :: rest)

```

``` {.example}
<fun>
```
