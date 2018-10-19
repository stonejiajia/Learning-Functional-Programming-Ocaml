---
title: List and Patterns
---

List Basics
===========

``` {.ocaml}
open Base;;

[1;2;3]
```

``` {.ocaml}
1 :: 2 :: [] 
```

:: operator is right-associative, means the we can build up lists
without parenthese

``` {.ocaml}
let empty = [];;
3 :: empty

```

``` {.ocaml}
"three" :: empty;;

```

``` {.ocaml}
let l = 1 :: 2 :: 3 :: []

```

``` {.ocaml}

let m = 0 :: l

```

Using Patterns to Extract Data from a List
==========================================

``` {.ocaml}
let rec sum l = 
  match l with
  | [] -> 0
  | hd :: tl -> hd + sum tl

```

``` {.ocaml}
sum [1;2;3;2;3;4;5;9]

```

``` {.ocaml}
sum []

```

``` {.ocaml}
let rec drop_value l to_drop = 
  match l with
  | [] -> []
  | to_drop :: tl -> drop_value tl to_drop
  | hd :: tl -> hd :: drop_value tl to_drop

```

``` {.ocaml}
drop_value [1;2;3] 2

```

``` {.ocaml}
let rec drop_value l to_drop = 
  match l with
  | [] -> []
  | hd :: tl ->
     let new_tl = drop_value tl to_drop in 
     if hd = to_drop then new_tl else hd :: new_tl
```

``` {.ocaml}
let rec drop_zero l =
  match l with
  | [] -> []
  | 0  :: tl -> drop_zero tl
  | hd :: tl -> hd :: drop_zero tl
;;


```

``` {.ocaml}
drop_zero [1;2;0;3];;

```

Limitations (and Blessings) of Pattern Matching
===============================================

``` {.ocaml}
let plus_one_match x =
  match x with
  | 0 -> 1
  | 1 -> 2
  | 2 -> 3
  | 3 -> 4
  | 4 -> 5
  | 5 -> 6
  | _ -> x + 1

```

``` {.ocaml}
let plus_one_if x =
  if      x = 0 then 1
  else if x = 1 then 2
  else if x = 2 then 3
  else if x = 3 then 4
  else if x = 4 then 5
  else if x = 5 then 6
  else x + 1
;;

```

``` {.ocaml}
#require "core_bench";;
open Core_bench;;
[ Bench.Test.create ~name:"plus_one_match" (fun () ->
      ignore (plus_one_match 10))
; Bench.Test.create ~name:"plus_one_if" (fun () ->
      ignore (plus_one_if 10)) ]
|> Bench.bench
;;

```
