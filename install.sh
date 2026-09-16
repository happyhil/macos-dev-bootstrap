# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# AWS CLI V2
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
aws --version
rm "AWSCLIV2.pkg"

# Brew Managed
brew bundle

# Asdf Managed
asdf plugin add terraform
asdf install terraform 1.13.1
asdf install terraform 1.15.1
asdf install terraform latest

# Pipx Managed
pipx install --suffix="@1.6" poetry==1.6.1
pipx install --suffix="@2.4" poetry==2.4.1

# Config files
cp ./.dotfiles/.gitignore_global ~/.gitignore_global
cp ./.dotfiles/.gitconfig ~/.gitconfig

# Zshrc
cat ./.dotfiles/.zshrc >> ~/.zshrc
