function bash -w bash -d "start bash (without automatically re-entering fish)"
    NO_FISH_BASH="1" command bash $argv
end
