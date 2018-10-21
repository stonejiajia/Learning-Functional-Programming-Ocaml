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

More Useful List Functions
==========================

``` {.ocaml}
List.reduce

```

``` {.ocaml}
List.reduce ~f:(+) [1;2;3;4;5]

```

``` {.ocaml}
List.reduce ~f:(+) [] 
```

Filtering with List.filter and List.filter~map~
-----------------------------------------------

``` {.ocaml}
List.filter ~f:(fun x -> x mod 2 = 1) [1;2;3;4;5]
```

``` {.ocaml}
List.filter_map (Sys.ls_dir ".") ~f:(fun fname ->
    match String.rsplit2 ~on:'.' fname with 
    | None | Some ("",_) -> None
    | Some (_,ext) ->
      Some ext)
              |> List.dedup

```

``` {.ocaml}
let extensions filenames =
  List.filter_map filenames ~f:(fun fname ->
      match String.rsplit2 ~on:'.' fname with
      | None  | Some ("",_) -> None
      | Some (_,ext) ->
        Some ext)
  |> List.dedup_and_sort ~compare:String.compare

```

None | Some ("",\_) is an Or pattern

Partitioning with List.partition~tf~
------------------------------------

把 List 中的元素用布尔值来判断是否 tf 告诉读者 true 元素是第一个， False
是第二个

``` {.ocaml}
let is_ocaml_source s = 
  match String.rsplit2 s ~on:'.' with
  | Some (_,("ml"|"mli")) -> true
  | _ -> false
```

``` {.ocaml}

let (ml_files,other_files) =
  List.partition_tf ["foo.c"; "foo.ml"; "bar.ml"; "bar.mli"]  ~f:is_ocaml_source;;
```

Tail Recursion
==============

``` {.ocaml}
let rec length = function
  | [] -> 0
  | _ :: tl -> 1 + length tl

```

``` {.ocaml}
length [1;2;3;3;9]
```

``` {.ocaml}
let make_list n = List.init n ~f:(fun x -> x)
```

``` {.ocaml}
make_list 10
```

``` {.ocaml}
length (make_list 10000)

```

``` {.ocaml}
let rec length_plus_n l n = 
  match l with
  | [] -> n
  | _ :: tl -> length_plus_n tl (n + 1)

```

``` {.ocaml}
let length l = length_plus_n l 0

```

``` {.ocaml}
length [1;2;3;4;4;5;9]

```

``` {.ocaml}
length (make_list 100)
```

Terser and Faster Patterns
==========================

``` {.ocaml}

let rec destutter list =
  match list with
  | [] -> []
  | [hd] -> [hd]
  | hd :: hd' :: tl ->
    if hd = hd' then destutter (hd' :: tl)
    else hd :: destutter (hd' :: tl)
;;

```

val destutter : Base\_~Int~.t Base\_~List~.t -&gt; Base\_~Int~.t
Base\_~List~.t = &lt;fun&gt;

``` {.ocaml}
let rec destutter = function
  | [] as l -> l
  | [_] as l -> l
  | hd :: (hd' :: _ as tl) ->
    if hd = hd' then destutter tl
    else hd :: destutter tl

```

``` {.ocaml}
let rec destutter = function
  | [] | [_] as l -> l
  | hd :: (hd' :: _ as tl) ->
    if hd = hd' then destutter tl
    else hd :: destutter tl
;;

```
