#!/usr/bin/env bash

__typora_notebook::util::typora()
{
    if [[ -n $1 ]] && [[ -f $1 ]]; then
        _file=$(cat "$1")
    else
        _file=$(cat <&0)
    fi
    if [ -z "$_file" ]; then
        return 1;
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

__typora_notebook::util::tovim()
{
    _tmpfile=/tmp/.typora_notebook_tmp_`date +%Y-%m-%d_%H-%M-%S.txt`
    trap 'rm $_tmpfile' ERR

    if [[ -n $1 ]] && [[ -f $1 ]]; then
        _input=$(cat "$1")
    else
        _input=$(cat <&0)
    fi
    if [ -z "$_input" ]; then
        return 1;
    fi
    echo "$_input" > $_tmpfile
    vim $_tmpfile < /dev/tty > /dev/tty
    cat $_tmpfile
    rm $_tmpfile
}

__typora_notebook::util::cross_search()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    _search_string="$1" \
        | __typora_notebook::model::note::get_all \
        | awk \
            -f $TYPORA_NOTEBOOK_ROOT/src/share/word_count.awk \
            -v search_string="$_search_string" \
        | sort -t":" -k1 -nr \
        | peco \
        | __typora_notebook::util::get_filename
}
