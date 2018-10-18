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

``` {.ocaml}
abs_diff 3
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

Declaring Functions with Function
=================================

``` {.ocaml}

let some_or_zero = function
    | Some x -> x
    | None -> 0

```

``` {.ocaml}
List.map ~f:some_or_zero [Some 3; None; Some 4]
```

用 match 的写法

``` {.ocaml}
let some_or_zero num_opt = 
  match num_opt with
  | Some x -> x
  | None -> 0
```

``` {.ocaml}
let some_or_default default = function
  | Some x -> x
  | None -> default



```

``` {.ocaml}
some_or_default 0 (Some 5)
```

``` {.ocaml}
List.map ~f:(some_or_default 100) [Some 3; None; Some 4]
```

``` {.ocaml}

some_or_default 9 (None)
```

Labeled Arguments
=================

Labeled Arguments 是指函数中的 Arguments 由 name 来 identify（确定）

``` {.ocaml}
let ratio ~num ~denom = float num /. float denom

```

``` {.ocaml}
ratio ~num:3 ~denom:10
```

label punning
-------------

``` {.ocaml}
let num = 3 in
    let denom = 4 in 
    ratio ~num ~denom
```

Higher-order functions and labels
---------------------------------

``` {.ocaml}
let apply_to_tuple f (first,second) = f ~first ~second
```

``` {.ocaml}
let apply_to_tuple_2 f (first,second) = f ~second ~first
```

``` {.ocaml}
let divide ~first ~second = first / second
```

``` {.ocaml}
apply_to_tuple_2 divide (3,4)
```

``` {.ocaml}
let apply_to_tuple f (first, second) = f ~first ~second
```

``` {.ocaml}
apply_to_tuple divide (3, 4)
```

Optional Arguments
==================

``` {.ocaml}
let concat ?sep x y =
  let sep = match sep with None -> "" | Some x -> x in
  x ^ sep ^ y
```

``` {.ocaml}
concat "foo" "bar"
```

``` {.ocaml}
concat ~sep:":" "foo" "bar"
```

什么时候使用 Optional Arguments， 因为 Optional Arguments
有时很容易混淆。当有的 函数很少用的时候，就不要使用 Optional Arguments。

Explicit passing of an optional argument
----------------------------------------

``` {.ocaml}
concat ~sep:":" "foo" "bar"
```

``` {.ocaml}
concat ?sep:(Some ":") "foo" "bar"
```

``` {.ocaml}
concat ?sep:None "foo" "bar"
```

``` {.ocaml}
let uppercase_concat ?(sep="") a b = concat ~sep (String.uppercase a) b
```

``` {.ocaml}
uppercase_concat "foo" "bar"
```

``` {.ocaml}
uppercase_concat "foo" "bar" ~sep:":"
```

``` {.ocaml}
let uppercase_concat ?sep a b = concat ?sep (String.uppercase a) b
```

Inference of labeled and optional argument
------------------------------------------

``` {.ocaml}
let numeric_deriv ~delta ~x ~y ~f =
  let x' = x +. delta in 
  let y' = y +. delta in 
  let base = f ~x ~y in 
  let dx = (f ~x:x' ~y -. base) /. delta in 
  let dy = (f ~x ~y:y' -. base) /. delta in 
  (dx, dy)

```

``` {.ocaml}

```

Optional arguments and partial application
------------------------------------------

``` {.ocaml}
let colon_conat = concat ~sep:":"

```

``` {.ocaml}
colon_conat "a" "b"
```

``` {.ocaml}
let prepend_pound = concat "# "

```

``` {.ocaml}
prepend_pound "a BASH comment"

```

``` {.ocaml}
prepend_pound "a BASH comment" ~sep:":"

```

``` {.ocaml}
(* previous concat function*)
let concat ?sep x y =
  let sep = match sep with None -> "" | Some x -> x in
  x ^ sep ^ y

```

``` {.ocaml}
let concat x ?(sep="") y = x ^ sep ^ y

```

``` {.ocaml}

prepend_pound "a BASH comment" ~sep:"--- "


```
