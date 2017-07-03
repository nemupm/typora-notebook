#!/usr/bin/env bash

__typora_notebook::function::open_file_by_name()
{
    __typora_notebook::model::note::get_all \
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

__typora_notebook::function::create_new_notebook()
{
    _notebook_name="$1"
    __typora_notebook::model::notebook::new "$_notebook_name"
}