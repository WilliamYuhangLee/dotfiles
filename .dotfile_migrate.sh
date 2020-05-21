## Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
  echo 'Warning: Homebrew is not installed.'
  echo 'Installing Homebrew now...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

## Install git
if ! [ -x "$(command -v git)" ]; then
  echo 'Warning: Git is not installed.'
  echo 'Installing Git now...'
  brew install git
  echo 'Git is installed by Homebrew.'
fi

zshrc_dirty=false
## Install Oh My Zsh
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  echo 'Warning: Oh My Zsh is not installed.'
  echo 'Installing Oh My Zsh now...'
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo 'Oh My Zsh is installed now.'
  zshrc_dirty=true
fi

## Download custom Oh My Zsh plugins
# Oh My Zsh zsh-autosuggestions plugin
if ! [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo "Warning: Oh My Zsh zsh-autosuggestions plugin is not installed."
  echo "Installing Oh My Zsh zsh-autosuggestions plugin now..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo 'Oh My Zsh zsh-autosuggestions plugin is installed now.'
fi
# Oh My Zsh zsh-syntax-highlighting plugin
if ! [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  echo "Warning: Oh My Zsh zsh-syntax-highlighting plugin is not installed."
  echo "Installing Oh My Zsh zsh-syntax-highlighting plugin now..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo 'Oh My Zsh zsh-syntax-highlighting plugin is installed now.'
fi

## Install yadm and pull dotfiles
if ! [ -x "$(command -v yadm)" ]; then
  echo 'Warning: yadm is not installed.'
  echo 'Installing yadm now...'
  brew install yadm
  echo 'yadm is installed by Homebrew.'
  dotfile_repo='https://github.com/WilliamYuhangLee/dotfiles.git'
  echo "yadm is pulling down dotfiles from $dotfile_repo"
  yadm clone $dotfile_repo
fi

## Restore .zshrc if it is dirty (overwritten by OMZ)
if [ "$zshrc_dirty" = true ]; then
  yadm checkout $HOME/.zshrc
fi

## Install iTerm2
# function whichapp is defined in .zshrc (requires syncing dotfiles in advance)
if ! [ -x "$(whichapp iterm2)" ]; then
  echo 'Warning: iTerm2 is not installed.'
  echo 'Installing iTerm2 now...'
  brew cask install iterm2
  echo 'iTerm2 is installed by Homebrew Cask.'
fi

## Configure iTerm2
# Download and install Powerline fonts if haven't
font_dir="$HOME/Library/Fonts"
if [ ! -f "$font_dir/.powerline_installed" ]; then
  echo 'Warning: Powerline fonts are not installed. (these fonts are required by your iTerm2 profile)'
  echo 'Installing Powerline fonts now...'
  # clone
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts
  # make a marker
  touch $font_dir/.powerline_installed
  echo "A marker is created in $font_dir to signify the fonts are installed."
fi

# Sync iTerm2 profile
profile_name="Oh-my-zsh Agnoster.json"
iterm_config_dir="$HOME/.config/iterm"
iterm_profile_dir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
if [ ! -f "$iterm_profile_dir/$profile_name" -o "$iterm_config_dir/$profile_name" -nt "$iterm_profile_dir/$profile_name" ]; then
  echo "Warning: The iTerm2 profile [$profile_name] has a newer version in $iterm_config_dir"
  read -k 1 -r -s "?Do you want to overwrite the profile with the newer version? [y/n] "
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$iterm_config_dir/$profile_name" "$iterm_profile_dir/$profile_name"
    echo "Copied profile from $iterm_config_dir to $iterm_profile_dir..."
    echo "Parsing $iterm_profile_dir/$profile_name into the correct format..."
    # Call parser script
    $iterm_config_dir/iterm_profile_wrapper.sh "$iterm_profile_dir/$profile_name"
    echo "Profile [$profile_name] has been updated."
  fi
fi
