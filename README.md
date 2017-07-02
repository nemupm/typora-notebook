# Typora-notebook

the CLI for typora to manage notebooks and search functions.

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
```

## Open note by name

```sh
$ typora -o 
```

## Cross search

```sh
$ typora -s <string to search for>
```
