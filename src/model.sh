#!/usr/bin/env bash

__typora_notebook::model::notebook::get_all()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    find . -type d -mindepth 1 \
        | awk '{gsub("^./", "", $0); print $0}'
}

__typora_notebook::model::note::get()
{
    if [[ -n $1 ]] && [[ -f $1 ]]; then
        _notebook=$(cat "$1")
    else
        _notebook=$(cat <&0)
    fi
    if [ -z "$_notebook" ]; then
        return 1
    fi
    ls -1 -t "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_notebook/" \
        | awk -v notebook="$_notebook" '{print notebook "/" $0}'
}

__typora_notebook::model::note::get_all()
{
    cd "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR"
    find . -name "*.md" -type f -mindepth 1 -print0 \
        | xargs -0 ls -t \
        | awk '{gsub("^./", "", $0); print $0}'
}

__typora_notebook::model::note::new()
{
    _note_name="$1"
    _notebook=$(__typora_notebook::model::notebook::get_all \
        | peco)
    if [ -z "$_notebook" ]; then
        return 1
    fi
    _note="$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_notebook/$_note_name.md"
    touch "$_note"
    if [ ! -s "$_note" ]; then
        echo "# $_note_name\n" > "$_note"
    fi
    echo "$_notebook/$_note_name.md"
}

__typora_notebook::model::notebook::new()
{
    _notebook_name="$1"
    mkdir -p "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_notebook_name"
}

__typora_notebook::model::note::copy_content()
{
    _copy_from="$1"
    _copy_to="$2"

    cat "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_copy_from" \
        > "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_copy_to"

    _note_name_copy_to=$(echo "$_copy_to" \
        | awk -F'/' '{gsub(".md", ""); print $NF}')

    sed -i -e "1s/.*/# $_note_name_copy_to/g" "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_copy_to"
}

__typora_notebook::model::note::rename()
{
    _rename_from="$1"
    _rename_to="$2"

    mv "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_rename_from" \
        "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_rename_to"

    _note_name_rename_to=$(echo "$_rename_to" \
        | awk -F'/' '{gsub(".md", ""); print $NF}')

    sed -i -e "1s/.*/# $_note_name_rename_to/g" "$TYPORA_NOTEBOOK_NOTEBOOKS_DIR/$_rename_to"
}
