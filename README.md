# Typora-notebook

This is the scripts for especially Typora
to enable managing markdown files as notebook and cross-searching over those files.

# Requirements

- peco

# Config

Set the root directory of typora notes.

```sh
$ cat $HOME/.typora-notebook/config.sh
export TYPORA_NOTEBOOK_NOTEBOOKS_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/typora"
```

# Usage

```sh
$ source ./init.sh
$ typora -h
Usage:
    typora [<options>]

Options:
    --open, -o                  open note by name
    --open-notebook, -n         choose notebook and open note in the notebook
    --create-note, -c <string>  create new note with input name
    --create-notebook <string>  create new notebook with input name
    --search, -s <string>       search all notes for input string
    --duplicate-notebook, -d    duplicate note
    --help, -h                  print this

Author: nemupm
```

## Open note by name

```sh
$ typora -o 
```

## Cross search

```sh
$ typora -s <string to search for>
```
