#!/usr/bin/env bash

export TYPORA_NOTEBOOK_APP=${TYPORA_NOTEBOOK_APP:-/Applications/Typora.app}
export TYPORA_NOTEBOOK_ROOT
export TYPORA_NOTEBOOK_DIR=${TYPORA_NOTEBOOK_DIR:-$HOME/.typora-notebook}
export TYPORA_NOTEBOOK_NOTEBOOKS_DIR=${TYPORA_NOTEBOOK_NOTEBOOKS_DIR:-$HOME/.typora-notebook/notebooks}
export TYPORA_NOTEBOOK_COMMAND=${TYPORA_NOTEBOOK_COMMAND:-typora}

TYPORA_NOTEBOOK_ROOT="$(builtin cd "$(dirname "$BASH_SOURCE")" && pwd)"

__typora_notebook::init::init()
{
    if [ ! -d "$TYPORA_NOTEBOOK_DIR" ]; then
        mkdir -p "$TYPORA_NOTEBOOK_DIR"
    fi
    if [ -e "$TYPORA_NOTEBOOK_DIR/config.sh" ]; then
        source "$TYPORA_NOTEBOOK_DIR/config.sh"
    fi
    if [ ! -d "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR" ]; then
        mkdir -p "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    fi

    for src in "$TYPORA_NOTEBOOK_ROOT/src"/*.sh; do
        source "$src"
    done

    eval "alias $TYPORA_NOTEBOOK_COMMAND=__typora_notebook::command"
}

__typora_notebook::init::init
