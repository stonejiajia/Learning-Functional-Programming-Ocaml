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

open Core_bench;;
[ Bench.Test.create ~name:"plus_one_match" (fun () ->
      ignore (plus_one_match 10))
; Bench.Test.create ~name:"plus_one_if" (fun () ->
      ignore (plus_one_if 10)) ]
|> Bench.bench
;;

```

┌────────────────┬──────────┐ │ Name │ Time/Run │
├────────────────┼──────────┤ │ plus~onematch~ │ 66.51ns │ │ plus~oneif~
│ 197.14ns │ └────────────────┴──────────┘

-   ``` {.example}
    unit = ()
    ```

``` {.ocaml}
let rec sum_if l = 
  if List.is_empty l then 0
  else List.hd_exn l + sum_if (List.tl_exn l)
```

``` {.ocaml}
let numbers = List.range 0 1000 in
[ Bench.Test.create ~name:"sum_if" (fun () -> ignore (sum_if numbers))
; Bench.Test.create ~name:"sum"    (fun () -> ignore (sum numbers)) ]
|> Bench.bench
```

Estimated testing time 20s (2 benchmarks x 10s). Change using -quota
SECS. ┌────────┬──────────┐ │ Name │ Time/Run │ ├────────┼──────────┤ │
sum~if~ │ 102.21us │ │ sum │ 50.65us │ └────────┴──────────┘

-   ``` {.example}
    unit = ()
    ```

从上面的统计来看，Pattern matching 比 if (alternatives) 更有效率

Detectiong Errors
=================

``` {.ocaml}
let rec drop_zero l = 
  match l with
  | [] -> []
  | 0 :: tl -> drop_zero tl

```

``` {.ocaml}
printf "%s\n"
  (render_table
     ["language";"architect";"first release"]
     [ ["Lisp" ;"John McCarthy" ;"1958"] ;
       ["C"    ;"Dennis Ritchie";"1969"] ;
       ["ML"   ;"Robin Milner"  ;"1973"] ;
       ["OCaml";"Xavier Leroy"  ;"1996"] ;
     ]);;

```

``` {.ocaml}
List.map ~f:String.length["Hello"; "World"]

```

``` {.ocaml}
List.map2 ~f:Int.max [1;2;3] [3;2;1]  

```

``` {.ocaml}
List.fold

```

List.fold three arguments

-   a list to process
-   an initial accumulator value
-   a function for updating the accumulator

``` {.ocaml}
List.fold ~init:10 ~f:(+) [1;2;3;4]
```

``` {.ocaml}
List.fold ~init:[] ~f:(fun list x -> x :: list) [1;2;3;4]

```

``` {.ocaml}
let max_widths header rows = 
  let lengths l = List.map ~f:String.length l in 
  List.fold rows 
    ~init:(lengths header)
    ~f:(fun acc row ->
      List.map2_exn ~f:Int.max acc (lengths row))

```

``` {.ocaml}
let render_separator widths =
  let pieces = List.map widths
      ~f:(fun w -> String.make (w + 2) '-')
  in
  "|" ^ String.concat ~sep:"+" pieces ^ "|"
;;

```

Performance of String.concat and \^
-----------------------------------

``` {.ocaml}
let s = "." ^ "." ^ "." ^ "." ^ "." ^ "."

```

``` {.ocaml}
let s = String.concat [".";".";".";".";".";".";"."]

```

``` {.ocaml}
let pad s length = 
  " " ^ s ^ String.make (length - String.length s + 1) ' '

```

``` {.ocaml}
pad "hello" 4

```
