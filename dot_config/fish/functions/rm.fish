function rm -w rm -d "prevent `rm` from being used carelessly"
    set color --bold red
    echo -n "Are you sure?"
    set color normal
    echo -n " Prefix with `command` to "
    set color --bold
    echo -n permanently
    set color normal
    echo " erase"
end
