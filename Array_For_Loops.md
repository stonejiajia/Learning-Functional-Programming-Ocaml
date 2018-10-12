---
title: Array~ForLoops~
---

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

A Complete Program
==================

``` {.ocaml}

open Core.Std

let rec read_and_accumulate accum = 
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)

let () = 
  printf "Total: %F\n" (read_and_accumulate 0.);;

```



