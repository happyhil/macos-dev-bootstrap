# Created by `pipx`
export PATH="$PATH:/Users/simonvreugdenhil/.local/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ASDF Version Manager Setup
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$HOME/.asdf/shims:$PATH"

# Nano editing
export EDITOR="nano"
export VISUAL="nano"

# Disable tracking
export HOMEBREW_NO_ANALYTICS=1
export CHECKPOINT_DISABLE=1
export DO_NOT_TRACK=1
