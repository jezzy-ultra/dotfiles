function bash --description="Start bash (without automatically re-entering fish)" --wraps="bash"
    NO_FISH_BASH="1" command bash $argv
end
