#!/usr/bin/env bash

__typora_notebook::command()
{
    while [ $# -gt 0 ];
    do
        case ${1} in

            --debug)
                set -x
            ;;

            --open|-o)
                __typora_notebook::function::open_file_by_name
            ;;

            --open-notebook|-n)
                __typora_notebook::function::open_file_in_notebook
            ;;

            --create-note|--create|-c)
                _note_name=${2}
                __typora_notebook::function::create_new_file "$_note_name"
                shift
            ;;

            --create-notebook)
                _notebook_name=${2}
                __typora_notebook::function::create_new_notebook "$_notebook_name"
                shift
            ;;

            --duplicate-note|-d)
                __typora_notebook::function::duplicate_file
            ;;

            --rename-note|-r)
                __typora_notebook::function::rename_file
            ;;

            --search|-s)
                _search_string=${2}
                __typora_notebook::function::open_file_by_search "$_search_string"
                shift
            ;;

            --help|-h)
                __typora_notebook::command::usage
            ;;

            *)
                echo "[ERROR] Invalid option '${1}'"
                __typora_notebook::command::usage
                exit 1
            ;;
        esac
        shift
    done
}

__typora_notebook::command::usage()
{
    cat <<EOS
Usage:
    $TYPORA_NOTEBOOK_COMMAND [<options>]

Options:
    --open, -o                  open note by name
    --open-notebook, -n         choose notebook and open note in the notebook
    --create-note, -c <string>  create new note with input name
    --create-notebook <string>  create new notebook with input name
    --search, -s <string>       search all notes for input string
    --duplicate-note, -d        duplicate note
    --rename-note, -r           rename note
    --help, -h                  print this

Author: nemupm
EOS
}
