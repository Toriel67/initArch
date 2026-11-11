#!/usr/bin/env bash
# Configuration de base Arch Linux : clavier AZERTY FR, locale fr_FR,
# installation de fastfetch / nano / reflector et mise à jour des miroirs.
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en root (ex : sudo ./setup-arch.sh)" >&2
    exit 1
fi

echo "==> Clavier AZERTY français"
# Console (TTY)
echo "KEYMAP=fr" > /etc/vconsole.conf
loadkeys fr || true

echo "==> Locale fr_FR.UTF-8"
sed -i 's/^#\s*\(fr_FR.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf

echo "==> Installation des paquets"
pacman -Syu --needed --noconfirm fastfetch nano reflector

echo "==> Mise à jour de la liste des miroirs"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --country France,Germany --latest 5 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist

echo "==> Terminé. Redémarre ou reconnecte-toi pour appliquer clavier et locale."
