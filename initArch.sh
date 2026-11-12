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
pacman -Syu --needed --noconfirm fastfetch nano reflector bash-completion  xdg-utils man-db man-pages zram-generator ufw openssh

echo "==> Mise à jour de la liste des miroirs"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --country France,Germany --latest 5 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist

echo "==> configuration de zram"
rm -f /etc/systemd/zram-generator.conf
rm -f /etc/udev/rules.d/99-zram-swappiness.rules
bash -c "cat <<EOF > /etc/udev/rules.d/99-zram-swappiness.rules
ACTION==\"change\", KERNEL==\"zram0\", ATTR{initstate}==\"1\", SYSCTL{vm.swappiness}=\"150\", \\
    RUN+=\"/bin/sh -c 'echo N > /sys/module/zswap/parameters/enabled'\"
EOF"

bash -c "cat <<EOF > /etc/systemd/zram-generator.conf
[zram0]
compression-algorithm = zstd
zram-size = ram
swap-priority = 100
fs-type = swap
EOF"

systemctl daemon-reload
systemctl start /dev/zram0

echo "==> configuration SSH et UFW"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh   

systemctl enable --now sshd.service
systemctl enable --now ufw.service
ufw enable

echo "==> Terminé. Redémarre ou reconnecte-toi pour appliquer clavier et locale."
