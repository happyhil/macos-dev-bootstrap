# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# AWS CLI V2
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
aws --version

# Brew Managed
brew bundle

# Asdf Managed
asdf install terraform 1.13.1
asdf install terraform 1.15.1
asdf install terraform latest

# Pipx Managed
pipx install --suffix="@1.6" poetry==1.6.1
pipx install --suffix="@2.4" poetry==2.4.1

# Config files
cp .gitignore_global ~/.gitignore_global
cp .gitconfig ~/.gitconfig

# Zshrc
cat .zshrc >> ~/.zshrc
