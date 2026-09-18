# Set variables
FONT_DIR="${HOME}/Library/Fonts"
FONT_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"
P10K_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
ZSHRC="${HOME}/.zshrc"

#######################################
# 1. Download the four MesloLGS NF styles into the user font folder (no sudo).
#    Each file is verified as TrueType before it is moved into place.
#######################################
install_fonts() {
  step "1. Installing MesloLGS NF fonts"
  mkdir -p "$FONT_DIR"

  local style file tmp
  for style in "Regular" "Bold" "Italic" "Bold Italic"; do
    file="MesloLGS NF ${style}.ttf"
    [[ -f "${FONT_DIR}/${file}" ]] && { echo "   already installed: ${file}"; continue; }

    tmp="$(mktemp)"
    curl -fsSL --proto '=https' "${FONT_URL}/${file// /%20}" -o "$tmp"
    file "$tmp" | grep -q "TrueType Font data" || { rm -f "$tmp"; die "Invalid download: ${file}"; }
    mv "$tmp" "${FONT_DIR}/${file}"
    echo "   installed: ${file}"
  done
}

#######################################
# 2. Clone powerlevel10k into oh-my-zsh custom themes (skipped if present).
#######################################
download_repo() {
  step "2. Downloading powerlevel10k"
  [[ -d "${HOME}/.oh-my-zsh" ]] || die "oh-my-zsh is not installed."

  if [[ -d "$P10K_DIR" ]]; then
    echo "   already present: ${P10K_DIR}"
  else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  fi
}

#######################################
# 3. Set ZSH_THEME by editing the existing line in place (never appending).
#    Backs up ~/.zshrc and checks syntax afterwards.
#######################################
change_zshrc() {
  step "3. Updating ~/.zshrc"
  [[ -f "$ZSHRC" ]] || die "${ZSHRC} not found."

  local count
  count="$(grep -c '^ZSH_THEME=' "$ZSHRC" || true)"
  [[ "$count" -eq 1 ]] || die "Expected 1 ZSH_THEME line in ~/.zshrc, found ${count}. Fix manually."

  cp -p "$ZSHRC" "${ZSHRC}.bak"
  # BSD sed on macOS needs the empty '' suffix after -i.
  sed -i '' 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"

  zsh -n "$ZSHRC" || die "Syntax error in ~/.zshrc. Restore with: mv ~/.zshrc.bak ~/.zshrc"
  echo "   ZSH_THEME set (backup: ~/.zshrc.bak)"
}

#######################################
# 4 + 5. Print the steps that must be done by hand.
#######################################
print_manual_steps() {
  cat <<'EOF'

==> 4. Terminal settings (manual)
   • Quit Terminal fully with ⌘Q, then reopen it
   • Terminal → Settings (⌘,) → Profiles
   • Select a theme on the left (or + to create one), then on the Text tab:
       – Background → Color & Effects: lower Opacity and raise Blur
       – Font → Change… → "MesloLGS NF" Regular, 12–14 pt
   • Click "Default" at the bottom of the profile list
   • Open a new window to check the look

==> 5. Configure the prompt (manual)
   p10k configure        # only needed if the wizard doesn't start by itself
   Answer the glyph questions based on what you actually see.
EOF
}

main() {
  install_fonts
  download_repo
  change_zshrc
  print_manual_steps
}

main "$@"
