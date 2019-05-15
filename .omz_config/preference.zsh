# Edit and load ~/.zshrc
zr () {
    nano ${HOME}/.zshrc
    source ${HOME}/.zshrc
}

# Edit and load ~/.oh-my-zsh/custom/preference.zsh
zp () {
    nano ${HOME}/.omz_config/preference.zsh
    source ${HOME}/.omz_config/preference.zsh
}
