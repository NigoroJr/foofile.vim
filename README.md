# foofile.vim

## Motivation

```
$ find ~ -maxdepth=1 -type f ! -name '.*'
a.out
bar.pl
baz.pl
foo.c
foo.cpp
foo.go
foo.pl
foo.rb
Foo.class
Foo.java
...
```

Not very pretty-looking, eh?

## What it does
When you do `:FooFile`, this plugin creates a file in which you can write
programs that you're not sure whether you want to keep it or not. For example,
if you want to test out how an STL function you just learned works, you can
`:FooFile cpp` and it'll let you write a sample program without making your
"home" dirty.

## Example Configurations

```vim
let g:foofiles_path = expand('~/tmp/')

" Split vertically
let g:foofiles_split = 2
```

## TODO
* `:FooFileSaveAs [filename]`
* `:FooFileNext`
* `:FooFilePrev`
* Determine filetype from file extension
* Unite.vim source might be useful?
* `:FooFileHome [filename]`
