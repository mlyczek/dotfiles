# Arch linux specific dotfiles

This directory contains dotfiles, scripts ans all useful information from the first installation of Arch linux.

# Important things configured

## Printing

Used the documentation on https://wiki.archlinux.org/title/CUPS.

Also configured Avahi daemon as described on https://wiki.archlinux.org/title/Avahi. This was important, because without it the IPP version of the printer URL was not discovered. The `nss-mdns`
package was also needed to be installed and the `/etc/nsswitch.conf` file modified.

Also, it is required to enable the `avahi-daemon.socket` in systemd if not enabled:

```bash
systemctl enable avahi-daemon.socet
```

The selected printer was the one with IPP protocol and IPP Everywhere

In order for the Avahi Daemon to work across reboot, the `avahi-daemon.service` itself also needed to be enabled:

```bash
systemctl enable avahi-daemon.service
```

## Notifications

Currently installed [Mako](https://github.com/emersion/mako)

## Dolphin

### Empty dialog with "Open with..." applications

Install `archlinux-xdg-menu`, then run

```bash
$ XDG_MENU_PREFIX=arch- kbuildsycoca6
```

It may be required to rename `/etx/xdg/menus/arch-applications.menu` to `/etc/xdg/menus/applications.menu`.
Source: https://github.com/prasanthrangan/hyprdots/issues/1406

## NPM installing global packages

Source: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally

Instead of installing global packages into `/usr/local` directory and require `sudo` to do so, we can
configure NPM to install them into `~/.local` instead.

This requires to run:

```bash
npm config set prefix '~/.local'
```

And then making sure that `~/.local/bin` is added to PATH
