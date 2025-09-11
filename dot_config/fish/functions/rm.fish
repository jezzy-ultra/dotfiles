function rm --description="Prevent `rm` from being used carelessly" --wraps="rm"
    set color --bold red
    echo -n "Are you sure?"
    set color normal
    echo -n " Prefix with `command` to "
    set color --bold
    echo -n permanently
    set color normal
    echo " erase"
end
