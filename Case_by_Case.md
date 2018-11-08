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

New Kinds of Data
=================

The name of type is colour. It has four constructors, Red, Green, and
Yellow

``` {.ocaml}

type colour = Red | Green | Blue | Yellow

```

``` {.ocaml}
let col = Blue

let cols = [Red; Red; Green; Yellow]

let colpair = ('R', Red)

```

``` {.ocaml}
type colour = 
  Red
| Green
| Blue
| Yellow
| RGB of int * int * int

```

``` {.ocaml}
let cols = [Red; Red; Green; Yellow; RGB (150, 0, 255);]

```

我们可用 Pattern matching 的 functions 来代替新的 Type

We can write functions by pattern matching over our new type

``` {.ocaml}
let components c = 
  match c with 
    Red -> (255, 0, 0)
  | Green -> (0, 255, 0)
  | Blue -> (0, 0, 255)
  | Yellow -> (255, 255, 0)
  | RGB (r, g, b) -> (r, g, b)

```

Type could be polymorphic.

``` {.ocaml}
type 'a option = None | Some of 'a

```

We can read as "a value of type a optio is either nothing, or something
of type a"

``` {.ocaml}
let nothing = None

let number = Some 50

let numbers = [Some 12; None; None; Some 2]

let word = Some ['c'; 'a'; 'k'; 'e']

```

Here is a function to look up a value in a dictionary, return None,
instead of raising an exception if the value is not found

``` {.ocaml}

let rec lookup_opt x l = 
  match l with
    [] -> None
  | (k, v)::t -> if x = k then Some v else lookup_opt x t
```

``` {.ocaml}
type 'a sequence = Nil | Cons of 'a * 'a sequence

```

  Built-in                    Ours                                        Our Type
  --------------------------- ------------------------------------------- ----------------
  \[\]                        Nil                                         a sequence
  \[1\]                       Cons (1, Nil)                               int sequence
  \['a'; 'x'; 'e'\]           Cons ('a', Cons ('x', Cons ('e', Nil)))     char sequence
  \[Red; RGB (20, 20, 20)\]   COns (Red, Cons (RGB (20, 20 , 20), Nil))   color sequence

``` {.ocaml}
let rec length l = 
  match l with
    [] -> 0
  | _::t -> 1 + length t

let rec append a b =
  match a with 
    [] -> b
  | h::t -> h :: append t b

```

Web can creat same functions with new sequence type:

``` {.ocaml}
let rec length s = 
  match s with
    Nil -> 0
  | Cons (_, t) -> 1 + length t

let rec append a b = 
  match a with
    Nil -> b
  | Cons (h, t) -> Cons (h, append t b)

```

A Type for Mathematical Expressions
-----------------------------------

``` {.ocaml}
type expr = 
  Num of int 
| Add of expr * expr
| Subtract of expr * expr
| Multiply of expr * expr
| Divide of expr * expr

```

``` {.ocaml}
Add (Num 1, Multiply (Num 2, Num 3))

```

Wen can write a same function

``` {.ocaml}
let rec evaluate e = 
  match e with
    Num x -> x
  | Add (e, e') -> evaluate e + evaluate e'
  | Subtract (e, e') -> evaluate e - evaluate e'
  | Multiply (e, e') -> evaluate e * evaluate e'
  | Divide (e, e') -> evaluate e / evaluate e'

```

Growing Trees
=============

``` {.ocaml}
type 'a tree = 
  Br of 'a * 'a tree * 'a tree
| Lf

```

Two constructors

1.  Br
2.  Lf (leaf)

The empty tree is simply

``` {.ocaml}
let rec size tr = 
  match tr with
    Br (_, l, r) -> 1 + size l + size r
  | Lf -> 0

```

A similar function can be used to add up all the integers in an int
tree.

``` {.ocaml}
let rec total tr = 
  match tr with
    Br (x, l, r) -> x + total l + total r
  | Lf -> 0

```

Calculate the maximum depth fo tree.

``` {.ocaml}
let max x y = 
  if x > y then x else y;;

let rec maxdepth tr = 
  match tr with
    Br (_, l, r) -> 1 + max (maxdepth l) (maxdepth r)
  | Lf -> 0

```

Exract all of the elements from a tree into a list

``` {.ocaml}
let rec list_of_tree tr = 
  match tr with
    Br (x, l, r) -> list_of_tree l @ [x] @ list_of_tree r
  | Lf -> []

```

Usring trees to build better dictionaries
-----------------------------------------

The most important advantage of a tree is that if is often very much
easier to reach a given element.

``` {.ocaml}
let rec lookup tr k = 
  match tr with
    Lf -> raise Not_found
  | Br ((k', v), l, r) -> 
     if k = k' then v
     else if k < k' then lookup l k
     else lookup r k

```

``` {.ocaml}
let rec insert tr k v = 
  match tr with
    Lf -> Br ((k, v), Lf, Lf)
  | Br ((k', v'), l, r) ->
     if k = k' then Br ((k', v'), l, r)
     else if k < k' then Br ((k', v'), insert l k v, r)
     else Br ((k', v'), l, insert r k v)


```

In and Out
==========

``` {.ocaml .rundoc-block rundoc-language="ocaml" rundoc-results="value"}
print_int 100;;
```

``` {.ocaml}
let print_dict_entry (k, v) = 
  print_int k; 
  print_newline (); 
  print_string v ; 
  print_newline ()

```

val print~dictentry~ : int \* string -&gt; unit = &lt;fun&gt;

``` {.ocaml}
print_dict_entry (1, "one");;

```

1 one

-   ``` {.example}
    unit = ()
    ```

We could write our own function to literate over all the entries

``` {.ocaml}
let rec print_dict d = 
  match d with
    [] -> ()
  | h::t -> print_dict_entry h; print_dict t

```

``` {.ocaml}
let rec iter f l = 
  match l with
    [] -> ()
  | h::t -> f h; iter f t

```

val iter : ('a -&gt; 'b) -&gt; 'a list -&gt; unit = &lt;fun&gt;

``` {.ocaml}
let print_dict d 
      iter print_dict_entry d;;


let print_dict = 
  iter print_dict_entry

```

``` {.ocaml}
print_dict [(1, "one"); (2, "two"); (3, "three")];;

```

### Read from the keyboard

``` {.ocaml}
let rec read_dict () = 
  let i = read_int () in
    if  i = 0 then [] else
      let name = read_line () in 
        (i, name) :: read_dict ();;

```

Putting Things in Boxes
=======================

Pure function which have no side-effects. OCaml provides a construct
known as a reference which is a box in which we can store a value. we
build a reference using the built-in function ref of type a-&gt;a ref.

``` {.ocaml}
let x = ref 0;;

```

OCaml tell us that x is a **reference** of type **int ref** which
current has contents , We can extract the current contents of a
reference using the !operator, which has type a ref -&gt; a

``` {.ocaml}
let p = !x;;
```

``` {.ocaml}
x := 50

```

``` {.ocaml}
let q = !x;;

```

``` {.ocaml}
p;;

```

:= operator has a type ref -&gt; a -&gt; unit, Which means update value

Notice that p is unchanged.

``` {.ocaml}
let swap a b = 
  let t = !a in 
    a := !b; b := t

```

### Doing it again and again

``` {.ocaml}
for x = 1 to 5 do print_int x; print_newline () done 

```

1 2 3 4 5

-   ``` {.example}
    unit = ()
    ```

``` {.ocaml}
let channe_statistics in_channel = 
  let lines = ref 0 in
    try
      while true do
        let line = input_line in_channel in 
          lines := !lines + 1
      done
    with
      End_of_file ->
        print_string "There were";
        print_int !lines;
        print_string " lines.";
        print_newline ();;

let file_statistics name =
  let channel = open_in name in 
    try 
      file_statistics_channel channel;
      close_in channel
    with
      _ -> close_in channel

```

``` {.ocaml}
(* Final version of word counter *)
let print_histogram arr =
  print_string "Character frequencies:";
  print_newline ();
  for x = 0 to 255 do
    if arr.(x) > 0 then
      begin
        print_string "For character '";
        print_char (char_of_int x);
        print_string "' (character number ";
        print_int x;
        print_string ") the count is ";
        print_int arr.(x);
        print_string ".";
        print_newline ()
      end
  done

let channel_statistics in_channel =
  let lines = ref 0
  and characters = ref 0
  and words = ref 0
  and sentences = ref 0
  and histogram = Array.make 256 0 in
    try
      while true do
        let line = input_line in_channel in
          lines := !lines + 1;
          characters := !characters + String.length line;
          String.iter
            (fun c ->
               match c with
               '.' | '?' | '!' -> sentences := !sentences + 1
               | ' ' -> words := !words + 1
               | _ -> ())
            line;
          String.iter
            (fun c ->
              let i = int_of_char c in
                histogram.(i) <- histogram.(i) + 1)
            line
      done
    with
      End_of_file ->
        print_string "There were ";
        print_int !lines;
        print_string " lines, making up ";
        print_int !characters;
        print_string " characters with ";
        print_int !words;
        print_string " words in ";
        print_int !sentences;
        print_string " sentences.";
        print_newline ();
        print_histogram histogram

let file_statistics name =
  let channel = open_in name in
    try
      channel_statistics channel;
      close_in channel
    with
      _ -> close_in channel
```

``` {.ocaml}
file_statistics "gregor.txt"

```
