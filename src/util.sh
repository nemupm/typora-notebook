#!/usr/bin/env bash

__typora_notebook::util::typora()
{
    if [[ -n $1 ]] && [[ -f $1 ]]; then
        _file=$(cat "$1")
    else
        _file=$(cat <&0)
    fi
    open -a $TYPORA_NOTEBOOK_APP "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_file"
}

__typora_notebook::util::get_filename()
{
    if [[ -n $1 ]] && [[ -f $1 ]]; then
        cat "$1"
    else
        cat <&0
    fi \
        | awk -F":" '{print $NF}'
}

__typora_notebook::util::cross_search()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    _search_string="$1" \
        | __typora_notebook::model::note::get_all \
        | awk \
            -f $TYPORA_NOTEBOOK_ROOT/src/share/word_count.awk \
            -v search_string=$_search_string \
        | sort -t":" -k1 -nr \
        | peco \
        | __typora_notebook::util::get_filename
}
