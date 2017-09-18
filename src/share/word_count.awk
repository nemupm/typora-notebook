{
    command = sprintf("grep \"%s\" -io \"%s\"|wc -l", search_string, $0);
    command | getline word_count;
    close(command);
    sub(/^[ \t]+/, "", word_count);
    if( word_count > 0 ){
        print word_count ":" $0;
    }
}
