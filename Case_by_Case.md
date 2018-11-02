---
title: Case~byCase~
---

Simple patter matching
======================

``` {.ocaml}
let rec factorial a = 
  if a = 1 then 1 else a * factorial (a - 1)

```

``` {.ocaml}
let rec factorial a = 
  match a with
    1 -> 1
  | _ -> a * factorial (a - 1)

```

See if a matches the pattern 1, If it does, just return 1, If not, see
if it matches the pattern\_ , If is does, then return is a \* factorial
(a - 1).

**The pattern \_ is special , it matches anything**

``` {.ocaml}
let isvowel c = 
  c = 'a' || c = 'e' || c = 'i';;

```

Here is how to write it using matching

``` {.ocaml}

let isvowel c = 
  match c with 
    'a' -> true
  | 'e' -> true
  | 'i' -> true
  | 'o' -> true
  | 'u' -> true
  | _   -> false

```

``` {.ocaml}
let iscowel c = 
  match c with
    'a' | 'e' | 'i' | 'o'| 'u' -> true
    | _ -> false


```

``` {.ocaml}
let rec gcd a b = 
  if b = 0 then a else gcd b (a mod b)

```

``` {.ocaml}
let rec gcd a b = 
  match b with
    0 -> a
  | _ -> gcd b (a mod b)

```

We use pattern mathcing whenever it is easier to read and understand
than if then else expressions

``` {.ocaml}
let not x = 
  match x with
    x -> false
  | _ -> true;;

```

Sorting Things
==============

``` {.ocaml}

let rec insert x l =
  match l with
    [] -> [x]
  | h::t -> 
     if x <= h
       then x :: h :: t
       else h :: insert x t

```

``` {.ocaml}
insert 39 [1; 1; 2; 3; 5; 9];;

```

``` {.ocaml}
let rec sort l = 
  match l with
    [] -> []
  | h::t -> insert h (sort t)

```

``` {.ocaml}
sort [53; 9; 2; 6; 19]

```

sort \[53; 9; 2; 6; 19\]

insert 53 (sort \[9; 2; 6; 19\])

insert 53 (insert 9 (sort \[2; 6; 19\])))

insert 53 (insert 9 (insert 2 sort \[6; 19\]))

insert 53 (insert 9 (insert 2 (insert 6 (sort \[19\]))))

insert 53 (insert 9 (insert 2 (insert 6 (insert 19 \[\]))))

insert 53 (insert 9 (insert 2 (insert 6 \[19\]))

insert 53 (insert 9 (insert 2 \[6; 19\]))

insert 53 (insert 9 \[2; 6; 19\])

insert 53 \[2; 6; 9; 19\]

\[2; 6; 9; 19; 53\]

``` {.ocaml}
sort ['p'; 'i'; 'm'; 'c'; 's'; 'h'];;

```

sort function takes time proportional to n^2^

``` {.ocaml}

let rec merge x y =
  match x, y with
    [], l -> l
  | l, [] -> l
  | hx::tx, hy::ty ->
     if hx < hy
       then hx :: merge tx (hy :: ty)
       else hy :: merge (hx :: tx) ty

```

``` {.ocaml}
let rec length l = 
  match l with
    [] -> 0
  | _::t -> 1 + length t

```

``` {.ocaml}
let rec msort l = 
  match l with 
    [] -> []
  | [x] -> [x]
  | _ -> 
     let left = take (length 1 / 2) l in 
     let right = drop  (length 1 / 2) l in 
     merge (msort left) (msort right)

```

Functions upon Functions upon Functions
=======================================

``` {.ocaml}
let rec double l = 
  match l with
    [] -> [] 
  | h::t -> (h * 2) :: double t;;

```

``` {.example}
double [1; 2; 4]

2 :: double [2; 4]

2 :: 4 :: double [4]

2 :: 4 :: 8 :: double []

2 :: 4 :: 8 :: []

[2; 4; 8]
```

``` {.ocaml}

let rec evens l = 
  match l with
    [] -> []
  | h::t -> (h mod 2 = 0) :: evens t

```

``` {.ocaml}
evens [1; 2; 4]

```

``` {.ocaml}
let rec map f l = 
  match l with
    [] -> [] 
  | h::t -> f h :: map f t

```

val map : ('a -&gt; 'b) -&gt; 'a list -&gt; 'b list = &lt;fun&gt;

``` {.ocaml}
let halve x = x / 2

```

``` {.ocaml}


map halve [10; 20; 30]
```

``` {.example}
map halve [10; 20; 30]

5 :: map halve [20; 30]

5 :: 10 :: map halve [30]

5 :: 10 :: 15 :: map halve []

5 :: 10 :: 15 :: []

[5; 10; 15]
```

``` {.ocaml}
let is_even x = 
  x mod 2 = 0

```

``` {.ocaml}
let evens l = 
  map (fun x -> x mod 2 = 0) l

```

``` {.ocaml}
map (fun x -> x / 2) [10; 20; 30]

```

val merge : ('a -&gt; 'a -&gt; bool) -&gt; 'a list -&gt; 'a list -&gt;
'a list = &lt;fun&gt;

val msort : ('a -&gt; 'a -&gt; bool) -&gt; 'a list -&gt; 'a list =
&lt;fun&gt;

type a -&gt; a -&gt; bool . That is ,it takes two elements of the same
type , and return true, if the first is "greater" than the second

``` {.ocaml}
let rec merge cmp x y = 
  match x, y with 
    [], l -> l
  | l, [] -> l
  | hx::tx, hy::ty ->
     if cmp hx hy
        then hx :: merge cmp tx (hy :: ty)
        else hy :: merge cmp (hx :: tx) ty



```

``` {.ocaml}
let rec msort cmp l = 
  match l with 
    [] -> []
  | [x] -> [x]
  | _ -> 
     let left = take (length l / 2) l in
       let right = drop (length l / 2) l in 
         merge cmp (msort cmp left) (msort cmp right)

```

``` {.ocaml}

let greater a b = 
  a >= b

```

``` {.ocaml}
msort greater [5; 4; 6; 2; 1]

```

``` {.ocaml}
( <= )

```

``` {.ocaml}
msort ( <= ) [5; 4; 6; 2; 1]

```

``` {.ocaml}
msort ( >= ) [5; 4; 6; 2; 1]

```

When Things Go Wrong
====================

Looking Things Up
=================

  House   People
  ------- --------
  1       4
  2       2
  3       2
  4       3
  5       1
  6       2
          

To make a pair in OCaml

``` {.ocaml}
let p = (1, 4)

```

val p : int \* int = (1, 4)

``` {.ocaml}
let q = (1, '1')

```

val q : int \* char = (1, '1')

``` {.ocaml}
let fst p = match p with (x, _) -> x;;
let snd p = match p with (_, y) -> y;;

```

``` {.ocaml}
fst (1, 'a')

```

``` {.ocaml}
snd (7, 'a')

```

``` {.ocaml}
let census = [(1, 4); (2, 2); (3, 2); (4, 3); (5, 1); (6, 2)]

```

val census : (int \* int) list =

``` {.ocaml}
let y = (1, [2; 3; 4])

```

lookup :a -&gt; (axb) list -&gt; b

``` {.ocaml}
let rec lookup x l = 
  match l with
    [] -> raise Not_found
  | (k, v)::t ->
     if k = x then v else lookup x t
```

``` {.ocaml}
let rec add k v d = 
  match d with
    [] -> [(k, v)]
  | (k', v')::t ->
     if k = k'
        then (k, v) :: t
        else (k', v') :: add k v t    
```

``` {.ocaml}
add 8 2 [(4, 5); (6, 3)]

```

  --- ---
  4   5
  6   3
  8   2
  --- ---

More with Functions
===================

``` {.ocaml}
let add x y = x + y

```

``` {.ocaml}
let f = add 6

```

``` {.ocaml}

f 5

```

``` {.ocaml}

map (add 6) [10; 20; 30]

```

  ---- ---- ----
  16   26   36
  ---- ---- ----

``` {.ocaml}

map (fun x -> x * 2) [10; 20; 30]

```
