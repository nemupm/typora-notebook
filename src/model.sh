#!/usr/bin/env bash

__typora_notebook::model::notebook::get_all()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    find . -type d -mindepth 1 \
        | awk '{gsub("^./", "", $0); print $0}'
}


__typora_notebook::model::note::get()
{
    IFS='\n'
    if [[ -n $1 ]] && [[ -f $1 ]]; then
        cd $(cat "$1")
    else
        cd $(cat <&0)
    fi
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    ls -1 -t
}

__typora_notebook::model::note::get_all()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    find . -name "*.md" -type f -mindepth 1 \
        | awk '{gsub("^./", "", $0); print $0}'
}
