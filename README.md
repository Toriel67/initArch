# setup-arch.sh

🇫🇷 [Français](#-français) · 🇬🇧 [English](#-english)

---

## 🇫🇷 Français

Script Bash de configuration de base pour une installation d'**Arch Linux**.

> ⚠️ **Script de test.** Il a été écrit à des fins d'expérimentation et d'apprentissage. Il modifie la configuration du système (locale, miroirs, swap, pare-feu, SSH). Lis-le entièrement avant de l'exécuter, et teste-le de préférence dans une machine virtuelle. Utilisation à tes propres risques.

### Ce que fait le script

1. **Clavier** : AZERTY français (`KEYMAP=fr`) pour la console (TTY). Aucune configuration X11/Wayland n'est incluse.
2. **Locale** : active et définit `fr_FR.UTF-8`.
3. **Paquets** : installe `fastfetch`, `nano`, `reflector`, `bash-completion`, `xdg-utils`, `man-db`, `man-pages`, `zram-generator`, `ufw` et `openssh`.
4. **Miroirs** : sauvegarde `/etc/pacman.d/mirrorlist` en `.bak`, puis lance :
   ```bash
   reflector --country France,Germany --latest 5 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist
   ```
5. **zram** : configure un swap compressé (`zstd`, taille = RAM) avec une règle udev pour `vm.swappiness`.
6. **SSH et pare-feu** : configure UFW (entrant refusé, sortant autorisé, SSH autorisé), puis active `sshd` et `ufw`.

### Utilisation

```bash
git clone <url-du-depot>
cd <nom-du-depot>
chmod +x setup-arch.sh
sudo ./setup-arch.sh
```

Redémarre ou reconnecte-toi ensuite pour appliquer le clavier et la locale.

### Prérequis

- Arch Linux (ou installation en cours via `arch-chroot`)
- Accès root
- Connexion Internet

---

## 🇬🇧 English

Basic configuration **Bash script** for an **Arch Linux** installation.

> ⚠️ **Test script.** It was written for experimentation and learning purposes. It changes system configuration (locale, mirrors, swap, firewall, SSH). Read it fully before running it, and preferably test it in a virtual machine. Use at your own risk.

### What the script does

1. **Keyboard**: French AZERTY (`KEYMAP=fr`) for the console (TTY). No X11/Wayland configuration is included.
2. **Locale**: enables and sets `fr_FR.UTF-8`.
3. **Packages**: installs `fastfetch`, `nano`, `reflector`, `bash-completion`, `xdg-utils`, `man-db`, `man-pages`, `zram-generator`, `ufw` and `openssh`.
4. **Mirrors**: backs up `/etc/pacman.d/mirrorlist` as `.bak`, then runs:
   ```bash
   reflector --country France,Germany --latest 5 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist
   ```
5. **zram**: sets up compressed swap (`zstd`, size = RAM) with a udev rule for `vm.swappiness`.
6. **SSH and firewall**: configures UFW (incoming denied, outgoing allowed, SSH allowed), then enables `sshd` and `ufw`.

### Usage

```bash
git clone <repository-url>
cd <repository-name>
chmod +x setup-arch.sh
sudo ./setup-arch.sh
```

Reboot or log in again afterwards for the keyboard layout and locale to take effect.

### Requirements

- Arch Linux (or an ongoing install via `arch-chroot`)
- Root access
- Internet connection
