## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply ~/.config/fish/profile
if test -f ~/.config/fish/profile
  source ~/.config/fish/profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add ~/.local/share/go/bin to PATH
if test -d ~/.local/share/go/bin
    if not contains -- ~/.local/share/go/bin $PATH
	    set -p PATH ~/.local/share/go/bin
    end
end

# Add $CARGO_HOME/bin to PATH
if test -d $CARGO_HOME/bin
    if not contains -- $CARGO_HOME/bin $PATH
	    set -p PATH $CARGO_HOME/bin
    end
end

# Add ~/.config/emacs/bin to PATH
if test -d ~/.config/emacs/bin
    if not contains -- ~/.config/emacs/bin $PATH
	    set -p PATH ~/.config/emacs/bin
    end
end

# Add flutter PATH
if test -d ~/apps/flutter/bin
    if not contains -- ~/apps/flutter/bin $PATH
        set -p PATH ~/apps/flutter/bin
    end
end

# Android SDK related changes
set -x ANDROID_HOME ~/apps/android
# if test -d $ANDROID_HOME/tools
#     if not contains -- $ANDROID_HOME/tools $PATH
#         set -p PATH $ANDROID_HOME/tools
#     end
# end
if test -d $ANDROID_HOME/tools/bin
    if not contains -- $ANDROID_HOME/tools/bin $PATH
        set -p PATH $ANDROID_HOME/tools/bin
    end
end
if test -d $ANDROID_HOME/platform-tools
    if not contains -- $ANDROID_HOME/platform-tools $PATH
        set -p PATH $ANDROID_HOME/platform-tools
    end
end
if test -d $ANDROID_HOME/emulator
    if not contains -- $ANDROID_HOME/emulator $PATH
        set -p PATH $ANDROID_HOME/emulator
    end
end
# for aapt/aapt2
if test -d $ANDROID_HOME/build-tools/31.0.0
    if not contains -- $ANDROID_HOME/build-tools/31.0.0 $PATH
        set -p PATH $ANDROID_HOME/build-tools/31.0.0
    end
end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Import colorscheme from 'wal' asynchronously
if type "wal" >> /dev/null 2>&1
   cat ~/.cache/wal/sequences
end

## Useful aliases
# Replace ls with exa
alias ls='exa --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

# Replace some more things with better alternatives
alias cat='bat --style header --style rules --style snip --style changes --style header'

# Common use
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#
# Arch related
#
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias rmpkg="sudo pacman -Rdd"
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions && sudo updatedb'

# Get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist" 

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'

