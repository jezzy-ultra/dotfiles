function fish_title
    set max_depth 3
    set max_len 20

    function trunc -a str max
        set -l len (string length -- "$str")
        if test "$len" -gt "$max"
            echo -n (string sub -l (math "$max" - 1) -- "$str")…
        else
            echo -n "$str"
        end
    end

    function trunc_pwd -a max
        set -l pwd (prompt_pwd -d 0 -D 3)
        set -l parts (string split "/" -- "$pwd")
        set -l len (count $parts)

        if test "$len" -gt "$max"
            if test "$len" -eq (math "$max" + 1)
                if test (string sub -l 1 "$pwd") = "~"
                    echo -n "~/"
                end
            else
                echo -n "…/"
            end
            set -l start_idx (math "$len - $max + 1")
            for i in (seq $start_idx $len)
                echo -n "$parts[$i]"
                if test "$i" -lt "$len"
                    echo -n /
                end
            end
        else if test "$pwd" = /
            echo -n /
        else if test "$pwd" = "~"
            echo -n "~"
        else
            echo -n "$pwd"
        end
    end

    set -l ssh
    if set -q SSH_TTY
        set -l prompt_hostname (prompt_hostname)
        set ssh "["(trunc "$prompt_hostname" "$max_len" | string collect)"]"
    end

    if set -q argv[1]
        echo -- $ssh (trunc $argv[1] "$max_len") (trunc_pwd "$max_depth")
    else
        set -l cmd (status current-command)
        if test "$cmd" = fish
            set cmd
        end
        echo -- $ssh (trunc "$cmd" "$max_len") (trunc_pwd "$max_depth")
    end
end

# Default

# function fish_title
#     # If we're connected via ssh, we print the hostname.
#     set -l ssh
#     set -q SSH_TTY
#     and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
#     # An override for the current command is passed as the first parameter.
#     # This is used by `fg` to show the true process name, among others.
#     if set -q argv[1]
#         echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
#     else
#         # Don't print "fish" because it's redundant
#         set -l command (status current-command)
#         if test "$command" = fish
#             set command
#         end
#         echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
#     end
# end
