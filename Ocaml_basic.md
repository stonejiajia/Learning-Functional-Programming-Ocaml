---
title: Ocaml~basic~
---

Tuples List Options, and Pattern Matching
=========================================

``` {.ocaml}


open Base;;
```

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

``` {.ocaml}
let rec sum l =
  match l with
  | [] -> 0
  | hd :: tl -> hd + sum tl

```

``` {.ocaml}
sum [1;2;3];;

```

``` {.ocaml}

let rec destutter list =
  match list with
  | [] -> []
  | hd1 :: hd2 :: tl ->
     if hd1 = hd2 then destutter (hd2 :: tl)
     else hd1 :: destutter (hd2 :: tl)
;;

```

``` {.ocaml}
let rec destutter list =
  match list with
  | [] -> []
  | [hd] -> [hd]
  | hd1 :: hd2 :: tl ->
     if hd1 = hd2 then destutter (hd2 :: tl)
     else hd1 :: destutter (hd2 :: tl)
;;

```

``` {.ocaml}
destutter ["hey";"hey";"hey";"man"]

```

Options
-------

``` {.ocaml}
let divide x y =
  if y = 0 then None else Some (x/y);;

```

把 Options 想象成特殊的 List ，这 List 里最多只有一个元素。

``` {.ocaml}
open Core.Std;;

let log_entry maybe_time message =
  let time =
    match maybe_time with
    | Some x -> x
    | None -> Time.now()
  in
  Time.to_sec_string time ^ "__" ^ message
;;

```

### in

let 表达式中有 in 时，in 用来建立一个新的 scope（作用域）在 let
的作用域里。

``` {.ocaml}
let x = 7 in
    x + x;;

```

``` {.ocaml}
x
```

Records and Variants
--------------------

``` {.ocaml}

type point2d = { x : float; y : float};;

```

``` {.ocaml}
let p = { x = 3.; y = -4. };;

```

``` {.ocaml}
let magnitude { x = x_pos; y = y_pos } =
  sqrt (x_pos **2. +. y_pos ** 2.);;

```

val magnitude : point2d -&gt; float = &lt;fun&gt;

field punning 可以跟简洁的写成这种形式。

``` {.ocaml}
let magnitude { x; y } = sqrt ( x ** 2. +. y ** 2.);;

```

val magnitude : point2d -&gt; float = &lt;fun&gt;

``` {.ocaml}

let distance v1 v2 =
  magnitude { x = v1.x -. v2.x; y = v1.y -. v2.y };;

```

``` {.ocaml}
type circle_desc = { center: point2d; radius: float }
type rect_desc = { lower_left: point2d; width: float; height: float }
type segment_desc = { endpoint1: point2d; endpoint2: point2d };;

```

variant type 的方式把上面的三个 object 结合起来。

``` {.ocaml}

type sene_element =
  | Circle  of circle_desc
  | Rect    of rect_desc
  | Segment of segment_desc
;;

```

“|” 分割不同的 Case, 每个 Case 都有一个 capitalized tag

``` {.ocaml}

let is_inside_scene_element point scene_element =
  let open Float.O in
  match scene_element with
  | Circle { center; radius } ->
    distance center point < radius
  | Rect { lower_left; width; height } ->
    point.x    > lower_left.x && point.x < lower_left.x + width
    && point.y > lower_left.y && point.y < lower_left.y + height
  | Segment { endpoint1; endpoint2 } -> false

```

val is~insidesceneelement~ : point2d -&gt; sene~element~ -&gt; bool =
&lt;fun&gt;

``` {.ocaml}
let is_inside_scene point scene =
  List.exists scene
    ~f:(fun el -> is_inside_scene_element point el)
;;

```

``` {.ocaml}
is_inside_scene {x=3.;y=7.}
  [ Circle {center = {x=4.;y= 4.}; radius = 0.5} ];;

```

``` {.ocaml}
is_inside_scene {x=3.;y=7.}
  [ Circle {center = {x=4.;y= 4.}; radius = 5.0} ];;

```

Imperative Programming
======================

Arrays
------

``` {.ocaml}
let numbers = [| 1; 2; 3; 4|];;

```

Arrays 和 Python 一样， 从 0 开始

``` {.ocaml}
numbers.(2) <- 4;;

```

``` {.ocaml}
numbers;;

```

Mutable Record Fields
---------------------

``` {.ocaml}
type running_sum =
  {
    mutable sum: float;
    mutable sum_sq: float;
    mutable samples: int;
  }
;;
```

``` {.ocaml}
let mean rsum = rsum.sum /. Float.of_int rsum.samples
let stdev rsum =
  Float.sqrt (rsum.sum_sq /. Float.of_int rsum.samples
              -. (rsum.sum /. Float.of_int rsum.samples) **. 2.) ;;

```

``` {.ocaml}

let create () = { sum = 0.; sum_sq = 0.; samples = 0 }
let update rsum x =
  rsum.samples <- rsum.samples + 1;
  rsum.sum     <- rsum.sum     +. x;
  rsum.sum_sq  <- rsum.sum_sq  +. x *. x
;;
```

``` {.ocaml}

let rsum = create ();;

```

``` {.ocaml}

List.iter [1.;3.;2.;-7.;4.;5.] ~f:(fun x -> update rsum x);;

```

``` {.ocaml}

mean rsum;;

```

``` {.ocaml}

stdev rsum;;

```

Refs
====

``` {.ocaml}

let x = { contents = 0 };;

```

``` {.ocaml}

x.contents <- x.contents + 1;;

```

``` {.ocaml}
x;;

```

``` {.ocaml}

let x = ref 0

```

``` {.ocaml}
!x;;

```

``` {.ocaml}

x := !x + 1;; (* assignment, i.e., x.contents <- ......*);;
!x;;

```

``` {.ocaml}

type 'a ref = { mutable contents : 'a }

let ref x = { contents = x }
let (!) r = r.contents
let (:=) r x = r.contents <- x
;;
```

``` {.ocaml}
let sum list =
  let sum = ref 0 in
  List.iter list ~f:(fun x -> sum := !sum + x);
  !sum
;;

```
