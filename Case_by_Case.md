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
