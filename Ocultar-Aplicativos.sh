#!/usr/bin/env bash

mkdir -p ~/.local/share/applications

backup_dir=~/.local/desktop_backups/applications_backup_$(date +%Y%m%d_%H%M%S)
mkdir -p "$backup_dir"

apps_to_move=(
    "avahi-discover.desktop"
    "bssh.desktop"
    "bvnc.desktop"
    "nvtop.desktop"
    "qv4l2.desktop"
    "qvidcap.desktop"
)

for app in "${apps_to_move[@]}"; do
    src="/usr/share/applications/$app"
    dest_local="$HOME/.local/share/applications/$app"
    dest_backup="$backup_dir/$app"

    if [ -f "$src" ]; then
        cp "$src" "$dest_backup"
        cp "$src" "$dest_local"
        sed -i 's/^NoDisplay=.*/NoDisplay=true/; t; $aNoDisplay=true' "$dest_local"
        sudo rm -f "$src"
    else
        echo "Arquivo $app não encontrado em /usr/share/applications, ignorando."
    fi
done

update-desktop-database ~/.local/share/applications/

echo "Todos os arquivos foram movidos, ocultados e backup criado em $backup_dir com sucesso!"

