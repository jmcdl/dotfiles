autoload -Uz compinit
compinit

### CONFIGURE ALIASES
alias l="ls -alG"
alias j="jump"
alias lg="lazygit"

### LOAD PLUGINS
source ~/.zsh/git.plugin.zsh
source ~/.zsh/jump.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Remove superfluous blanks from each command line being added to the history
# list
setopt histreduceblanks
# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading space
setopt histignorespace
# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt histignorealldups
# Switching directories for lazy people
setopt autocd
# See: http://zsh.sourceforge.net/Intro/intro_6.html
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
# Try to correct the spelling of commands
setopt correct


### CONFIGURE ZSH PROMPT
# setup git information
autoload -Uz vcs_info
precmd_functions+=( vcs_info )
setopt prompt_subst


# %b: branch
# %u: unstaged changes
zstyle ':vcs_info:git:*' formats '%F{green}(%b%u)%f '
# this makes %u work, but also the prompt is clearly slower in git dirs when this is on
zstyle ':vcs_info:*' check-for-changes true
# what string to use for %u when there are unstaged changes
zstyle ':vcs_info:*' unstagedstr '%F{red}*%f'
# vcs_info supports multiple version control systems, but I need just git
zstyle ':vcs_info:*' enable git

# Explaining prompt:
# %B / %F{n}: begin bold / color
# %b / %f: end bold / color
# %n~: display n latest directories of current directory
# %#: display a '%' (or '#' when root)
# %(..): conditional expression (see docs)
# %?: exit code of last process
# %n@%m: user@host
PROMPT='%B%F{blue}%2~%f ${vcs_info_msg_0_}%# %b'
# rprompt is located on the right side of the terminal
RPROMPT='%F{yellow}%D{%f/%m/%y %L:%M:%S}%f'

### PATH extensions
# add Sublime Text to path
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
# depot_tools are git enhancing tools provided by the chromium codebase and used for pulling the V8 repo
export PATH=~/code/depot_tools:$PATH

### Added by nvm installation script 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/Users/jmcdl/.ghcup/env" ] && source "/Users/jmcdl/.ghcup/env" # ghcup-env
