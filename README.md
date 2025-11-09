# Arch Linux From Scratch - System Configuration Set

This repository contains a curated set of configuration files used in a **from-scratch Arch Linux installation**, focused on efficiency, clean organization, and a polished GNOME user experience.

The configurations cover system localization, networking, logs, time synchronization, power management, GNOME extensions, terminal shell customization, and optional memory optimization.

---

## Contents Overview

### System and Localization
| File | Purpose |
|------|---------|
| `locale.conf` / `locale.gen` | System language and locale configuration. |
| `vconsole.conf` | Keyboard layout and font settings for TTY console. |
| `hostname` / `hosts.conf` | Machine identity and local host resolution. |
| `nsswitch.conf` | Defines lookup order for name resolution. |

### Networking and Time Sync
| File | Purpose |
|------|---------|
| `resolv.conf` / `resolved.conf` | DNS configuration via systemd-resolved. |
| `timesyncd.conf` / `chrony` | NTP-based network time synchronization. |

### System Services and Behavior
| File | Purpose |
|------|---------|
| `journald.conf` | Systemd journal behavior (storage, compression, verbosity). |
| `cups-pdf` | PDF virtual printer configuration. |
| `tlp.conf` | Battery and power optimization profiles (TLP). |
| `pacman.conf` | Audio configuration (PulseAudio / PipeWire depending on setup). |

### GNOME Desktop Environment
| Directory | Description |
|----------|-------------|
| `gnome-shell-extensions/` | Selected GNOME shell extensions for workflow enhancements. |
| `archmenu/` | Additional GNOME menu integration adjustments. |

### Shell and Terminal Environment
| File / Tool | Purpose |
|-------------|---------|
| `.zshrc` | Shell initialization and environment settings. |
| `Oh My Zsh` | Plugin and theme framework for Zsh. |
| `Powerlevel10k` | Highly customizable and performant prompt theme. |

### Memory Optimization
| File | Purpose |
|------|---------|
| `zram-generator.conf` | Enables compressed RAM swap via zram for improved performance. |

---

## Boot and System Layout

The system is structured as follows:

- **UEFI + GPT**
- **systemd-boot** as the bootloader
- **BTRFS** filesystem with manageable subvolume layout and snapshot support
- Initramfs generated using **mkinitcpio**

---

## Installation Workflow (Summary)

1. Boot into Arch Linux Live ISO.
2. Partition the disk using GPT and set up BTRFS with organized subvolumes.
3. Install the base system (`pacstrap`) including kernel and firmware.
4. Configure:
   - Hostname and locale
   - Network and time sync
   - systemd-boot bootloader
5. Install **GNOME** and the selected extensions.
6. Apply the configuration files from this repository.
7. Set up:
   - TLP for power management
   - zram-generator for compressed memory swapping
   - Oh My Zsh + Powerlevel10k for terminal experience

---

## Applying the Configurations

```bash
git clone https://github.com/ludw-archer/archer.git
cd archer

Note: Copy each configuration files to specifics directories, due to the miscellaneous archives.

...
