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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

