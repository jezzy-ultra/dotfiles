# source /usr/share/cachyos-fish-config/cachyos-config.fish

if not functions --query fisher
    curl --silent --location https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
end

batman --export-env | source
eval (batpipe)

fzf --fish | source

zoxide init --cmd cd -- fish | source

# set -gx CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
# carapace _carapace | source

fish_config theme choose cutiepro

starship init fish | source

# oh-my-posh init fish --config ~/src/cutiepro/oh-my-posh/cutiepro.omp.toml | source

# function rerender_posh_on_dir_change --on-variable PWD
#     omp_repaint_prompt
# end

# set --global --erase POSH_JOBS
# set --global --erase POSH_SUDO_CACHED
# function set_poshcontext
#     set --global --export POSH_JOBS (jobs | count)
#     if sudo --non-interactive true 2>/dev/null
#         set --global --export POSH_SUDO_CACHED 1
#     else
#         set --global --export POSH_SUDO_CACHED 0
#     end
# end

# Define aliases in here so they don't get clobbered by /etc/fish/config.fish

alias ls "eza --color=always --classify=always --icons=always --follow-symlinks --group-directories-first --hyperlink --mounts --no-permissions --octal-permissions --smart-group --time-style=+'%Y-%m-%dx
%m-%d %H:%M'"
alias la "ls --all"
alias ll "ls --git --long"
alias lla "ll --all"
alias l lla
alias lg "ls --git-repos --long"
alias lga "lg --all"
# Be careful, tree view can easily cause slowdown and hangs
alias lt "ls --git --tree"
alias lta "lt --all"

alias cat "bat --paging=never"
