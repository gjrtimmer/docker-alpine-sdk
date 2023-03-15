#!/bin/bash

build() {
	# Force sync after each action
	# This will ensure the journal is up-to-date
	# on BTRFS en ZFS filesystems

	abuild fetch
	abuild unpack
	abuild deps
	abuild prepare
	abuild build
	abuild rootpkg
	abuild index
}

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
alias ls='ls --color=auto'
alias ll='ls -la'

HISTFILE=/var/tmp/.bash_history
HISTFILESIZE=1000
HISTSIZE=1000

bind '"\e[1~": beginning-of-line' &> /dev/null
bind '"\e[4~": end-of-line' &> /dev/null

# EOF