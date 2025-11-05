#!/bin/bash
set -e

echo "==> Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando dependências básicas..."
sudo pacman -S zsh git ttf-meslo-nerd --noconfirm

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Instalando Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  [[ -f ~/.zshrc ]] || cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi

if [ "$SHELL" != "/bin/zsh" ]; then
  echo "==> Alterando shell padrão para ZSH..."
  chsh -s /bin/zsh
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "==> Instalando tema Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if grep -q "^ZSH_THEME=" ~/.zshrc; then
  sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi

echo "==> Atualizando cache de fontes..."
fc-cache -fv >/dev/null

echo
echo "✅ Instalação concluída com sucesso!"
echo "➡ Reinicie o terminal para aplicar o tema Powerlevel10k."
echo "   Caso o tema não carregue corretamente,"
echo "   verifique se o terminal usa a fonte: 'MesloLGS NF'."

