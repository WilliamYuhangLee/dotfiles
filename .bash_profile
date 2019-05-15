## Load common profile for shells
source ~/.common_profile

## Signature Formatting
PS1='\[\033[32;1m\][\u@\h \w]\n$ \[\033[0m\]'
PS2='> '
PS4='+ '

## Command Shortcuts
alias afc='ls -R . | wc -l'
alias la='ls -a'
alias ll='ls -lah'

## Functions

# Edit and load ~/.bash_profile
bp () {
    nano ~/.bash_profile
    source ~/.bash_profile
}

# mkdir and cd into the newly created directory
mkcdir ()
{
    mkdir -p -- "$1" && cd -P -- "$1"
}
