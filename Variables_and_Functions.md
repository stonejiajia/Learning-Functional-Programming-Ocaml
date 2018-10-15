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

Multiargument functions
=======================

``` {.ocaml}
open Base;;
let abs_diff x y = abs (x -y);;

```

``` {.ocaml}
abs_diff 9 8;;
```

``` {.ocaml}
let abs_diff =
  (fun x -> (fun y -> abs (x - y)));;

```

This style of function is called a curried function. (Currying is named
after Haskell Curry, a logician who had a significant impact on the
design and theory of programming languages.)

``` {.ocaml}
let dist_form_3 = abs_diff 3

```

``` {.ocaml}
dist_form_3 8
```

``` {.ocaml}
dist_form_3 (-1)
```

Partial application

``` {.ocaml}
let abs_diff = (fun x y -> abs (x - y))
```

``` {.ocaml}
let abs_diff (x,y) = abs (x - y)
```

``` {.ocaml}
abs_diff (3,4)
```

Recursive Functions
===================

``` {.ocaml}

let rec find_first_stutter list = 
  match list with
  | [] | [_] ->
     None
  | x :: y :: tl ->
     if x = y then Some x else find_first_stutter (y::tl)

```

the pattern | \[\] | \[\_\] is what's called an or-pattern , which is a
disjunction of two patterns, meaning that it will be considered a match
if either pattern matches.

所以 【】 对应的是 Empty List 【\_】 对应的是single element

``` {.ocaml}
let rec is_even x = 
  if x = 0 then true else is_odd (x - 1)
and is_odd x = 
  if x = 0 then false else is_even (x -1)

```

``` {.ocaml}

Int.max 3 4

```

-   也是一个函数

``` {.ocaml}
(+) 3 4

```

``` {.ocaml}
List.map ~f:((+) 3) [4;5;6]
```

这些都是 函数

! \$ % & \* + - . / : &lt; = &gt; ? @ \^ | \~

``` {.ocaml}

let (+!) (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)

```

``` {.ocaml}

let (***) x y = (x ** y) ** y

```

(**\***) 是 OCaml 中的注释语句

``` {.ocaml}
let ( *** ) x y = (x ** y) ** y

```

``` {.ocaml}
let (|>) x f = f x;;

```

``` {.ocaml}
let path = "/usr/bin:/usr/local/bin:/bin:/sbin"

```

``` {.ocaml}

String.split ~on:':' path
|> List.dedup ~compare:String.compare
|> List.iter ~f:print_endline

```

``` {.ocaml}
let split_path = String.split ~on:':' path in 
let deduped_path = List.dedup ~compare:String.compare split_path in 
List.iter ~f:print_endline deduped_path

```

``` {.ocaml}
List.iter ~f:print_endline ["Two"; "lines"]

```

``` {.ocaml}
List.iter ~f:print_endline
```

``` {.ocaml}
let (^>) x f = f x
```

``` {.ocaml}
let (^>) x f = f x;;

Core.Sys.getenv "PATH"
^> String.split ~on:':' path
^> List.dedup_and_sort ~compare:String.compare
^> List.iter ~f:print_endline
;;
```

注意：

  --------------------------
  &gt; 是 left-associative
  --------------------------

\^&gt; 是 right-associative
