## My dotfiles

```
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install neovim
brew install ripgrep
brew install delve
brew install lazygit
brew install bat

cd ~
git clone git@github.com:hellotheremike/dotfiles.git

ln -s ~/dotfiles/bash/rgfzf ~/.local/bin
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/.tmux.conf ~/
ln -s ~/dotfiles/.zshrc ~/
```
