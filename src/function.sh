#!/usr/bin/env bash

__typora_notebook::function::open_file_by_name()
{
    __typora_notebook::model::note::get_all \
        | peco \
        | __typora_notebook::util::typora
}

__typora_notebook::function::open_file_in_notebook()
{
    notes=$(__typora_notebook::model::notebook::get_all \
        | peco \
        | __typora_notebook::model::note::get)
    if [ $? -ne 0 ]; then
        return 1;
    fi
    echo -e "$notes" \
        | peco \
        | __typora_notebook::util::typora
}

__typora_notebook::function::open_file_by_search()
{
    _search_string="$1"
    __typora_notebook::util::cross_search "$_search_string" \
        | __typora_notebook::util::typora
}

__typora_notebook::function::create_new_file()
{
    _note_name="$1"
    __typora_notebook::model::note::new "$_note_name" \
        | __typora_notebook::util::typora
}

__typora_notebook::function::duplicate_file()
{
    _file_to_duplicate=$(__typora_notebook::model::note::get_all \
        | peco)
    if [ -z "$_file_to_duplicate" ]; then
        return 1;
    fi

    _new_name=$(echo "$_file_to_duplicate" \
        | __typora_notebook::util::tovim)
    if [ -z "$_new_name" ]; then
        return 1;
    fi

    __typora_notebook::model::note::copy_content \
        "$_file_to_duplicate" "$_new_name"
}

__typora_notebook::function::rename_file()
{
    _file_to_rename=$(__typora_notebook::model::note::get_all \
        | peco)
    if [ -z "$_file_to_rename" ]; then
        return 1;
    fi

    _new_name=$(echo "$_file_to_rename" \
        | __typora_notebook::util::tovim)
    if [ -z "$_new_name" ]; then
        return 1;
    fi

    __typora_notebook::model::note::rename \
        "$_file_to_rename" "$_new_name"
}

__typora_notebook::function::create_new_notebook()
{
    _notebook_name="$1"
    __typora_notebook::model::notebook::new "$_notebook_name"
}
