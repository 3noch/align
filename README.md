align
=======

A command-line tool that aligns columns of tabular input.

Usage
-----

Use `align --help` for details about arguments. All input is through `stdin`.


For example, if `test.dat` contains this

```
col1|col2|col3
1|2|3
10|20|30
100|200|300
10000|20000|30000
```

then piping `test.dat` through `align` produces aligned data like this

```
$ cat test.dat | align -d "|"
col1 |col2 |col3
1    |2    |3
10   |20   |30
100  |200  |300
10000|20000|30000
```


Building
--------

You must have

  * [Glasgow Haskell Compiler](http://www.haskell.org/ghc/)
  * [Cabal](http://www.haskell.org/cabal/) (which comes with the [Haskell Platform](http://www.haskell.org/platform/))

Then you can

```bash
$ cd align
$ cabal install
```


License
-------

Copyright &copy; Covenant Eyes 2014

This package is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php)
(see `LICENSE.txt`).
