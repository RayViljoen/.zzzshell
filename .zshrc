# $PATH tuning
# export PATH="/usr/local/opt/php@7.4/bin:$PATH"
# export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/rayviljoen/.pyenv/versions/2.7.18/bin:$PATH"
# Fix % bug when terminal starts
unsetopt PROMPT_SP

# Configure autocomplete
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
autoload -U compinit && compinit

# Configure history completion
autoload -U history-search-end
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# TERMINAL PRMOPT
PROMPT=$'\n'"%B%F{black}%~ "$'\n'"%B%F{green}>%f%b "

##########################################
# DO ANY REPEAT SETUPS HERE

# Add keys to SSH agent
ssh-add

##########################################

#################################################################
# ALIASES
#################################################################

alias zzzshelledit="e ~/.zshrc"
alias zzzshellreload="source ~/.zshrc"
alias zzzshellgoto="cd ~/.zzzshell/"

# Make brew work in x86 mode (Not ARM)
# Be sure to install brew for x86 also
# See https://gist.github.com/progrium/b286cd8c82ce0825b2eb3b0b3a0720a0
# alias brew="arch -x86_64 brew"

# Allow application past gatekeeper
alias gatekeeperallow="spctl --add"

alias atom="/Applications/Atom.app/Contents/Resources/app/atom.sh"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias e="code"
alias ..="cd .."
alias o="open"
alias oo="open ."
alias b="cd -"
alias t="tree"
alias mo="makeopen"
alias lib="cd ~/Library/ && open ."
alias del="saferm"
alias cb="copytoclipboard"

# Git
alias g="git status"
alias gl="git log --graph --color --pretty=format:'%x1b[31m%h%x1b[0m%x20- %s %x1b[32m%d'"
alias gd="git diff --color | diff-so-fancy"
alias gi="git init"
alias ga="bd_git_add"
alias gc="git commit -v -m"
alias gm="git merge"
alias gb="git branch"
alias gco="git checkout"
alias gp="git push"
alias gpl="git pull --rebase"
alias gr="git reset HEAD"
alias gamend="git commit --amend -m"

# Apache
alias hosts="sudo vi /etc/hosts"
alias vhosts="e /opt/homebrew/etc/nginx/"

# Processes
alias pfind="ps aux | grep"
alias pmem="top -o vsize"
alias pcpu="top -o cpu"
alias pkill="kill -9 "

# List all files colorized in long format
alias l="ls -Glh"

# Show hidden
alias la="ls -Glha"

# Only dirs
alias ld='ls -lh | grep "^d"'

# Always use color output for `ls`
alias ls="command ls -G"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# File size
alias size="stat -f \"%z bytes\""

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

#################################################################
# FUNCTIONS
#################################################################

# Git add
function bd_git_add() {
	if [ "$1" ]; then # Check if argument passed
		git add $1
	else # Default to -A
		git add -A :/
	fi
}

# Check git dirty
function git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

# Return current branch
function git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Create a base64 data URL from an image
dataurl() {
	echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Formats unix timestamp
function todate {
    perl -e "require 'ctime.pl'; print &ctime($1);"
}

# Creates new dir and cd's into it
function makeopen {
	mkdir $1 && cd $1
}

# Continue a download using curl ( args: from[src] - to[dst] )
function download {
	curl -L -o $2 -C - $1
}
# Trash file or dir to user .Trash
function saferm {
	mv -f "$@" ~/.Trash
}

# Copy file to clipboard
function copytoclipboard {
	cat $1 | pbcopy
}

