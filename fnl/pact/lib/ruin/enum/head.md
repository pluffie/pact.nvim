`enum` functions generally accept a sequence (`[a b]`), an assoc (`{: a : b})`
or a generator - a function which when called returns a lua iterator. Some
functions accept a `stream` (see below).

These functions will attempt to call the correct `ipairs` or `pairs` where
appropriate (generators are simply called as given).

As lua does not natively distinguish between sequences (*contiguous* numerically
indexed tables from `1` to  `n`) and tables, the table type is determined by
`seq?` and `assoc?` as defined in the `type` module.

Any table with a value for the key `1` is considered an sequence, as it's
unreasonable to exhaustively check every key in a table. This means mixed-key
tables *with a key for `1`* are iterated by `ipairs`.

```fennel
(map print {:1 :first :color :red}) ; => 1 first
```

To force a mixed-key table to iterate all values, you can pass a generator with
`pairs`.

```fennel
(map print #(pairs {:1 :first :color :red})) ; => 1 first; color red
```

This behaviour may change in the future.

Functions suffixed with `$` modify the given table "in place" and return their
first argument.

```fennel
(enum.set$ t :a 1)
;; equivalent to
(doto t
  (tset :a 1))
```

Streams allow deferred execution of computations against an enumerable. This
can be more performant as intermediary collections are not created.

```fennel
(->> [4 2 3]
     (enum.map #(* 2 $2)) ;; first sequence created => [8 4 6]
     (enum.filter #(<= 5 $2)) ;; second sequence => [8 6]
     (enum.map #(* 10 $2))) ;; third => [80 60]
```

```fennel
(->> [4 2 3]
     (enum.stream) ;; create a stream over sequence
     (enum.map #(* 2 $2)) ;; evaluates (*2 4)
     (enum.filter #(<= 5 $2)) ;; then evaulates (<= 5 8)
     (enum.map #(* 10 $2)) ;; then (* 10 8)
     ;; we must "resolve" the stream into a concrete collection
     (enum.stream->seq)) ;; then stores [80], then repeats for 2, 3, etc
```
