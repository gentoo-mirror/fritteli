# fritteli's Gentoo overlay
Gentoo overlay with some ebuilds that I found either outdated or missing in the official repository or in other overlays. Ebuilds are usually removed from this overlay whenever I find a version available in the official tree or in another overlay (provided I'm satisfied with them).

Build status of the [master branch](https://gittr.ch/linux/gentoo-overlay/src/branch/master), as seen by `pkgcheck scan --exit error,warning,style --net .`: [![Build Status](https://ci.gittr.ch/api/badges/linux/gentoo-overlay/status.svg?ref=refs/heads/master)](https://ci.gittr.ch/linux/gentoo-overlay)

## Using with plain (recent) Portage
Create a new config file under `/etc/portage/repos.conf/fritteli.conf` with the following contents:

	[fritteli]
	auto-sync = yes
	location = /usr/local/portage/overlays/fritteli
	sync-type = git
	sync-uri = https://gittr.ch/linux/gentoo-overlay.git

You may adapt the `location` attribute to your system's own setup.

If you prefer to use the overlay hostet at GitHub (which tends to be more stable but less up-to-date than the one hosted at gittr.ch), you may use `https://github.com/fritteli/gentoo-overlay.git` for the `sync-uri`.

## Using with Layman

You may also use [`layman`](https://wiki.gentoo.org/wiki/Layman) to manage this overlay. If you choose this method, you will be using the overlay hosted at GitHub.

For detailed information regarding layman, please refer to the [official documentation](https://wiki.gentoo.org/wiki/Layman). This section only covers the process in a very brief manner.

If you haven't used layman yet, just install it running this command:

	USE="git sync-plugin-portage" emerge layman

Then you can add this overlay wih:

	layman -a fritteli

You will be prompted for confirmation because this is an experimental overlay. Just continue by hitting `y`.

Keep the overlay up to date from Git:

	layman -s fritteli

## Bug reports and ebuild requests

If you find a bug in an ebuild, encounter a build error or would like me to add a new ebuild, please open an issue on [GitHub](https://github.com/fritteli/gentoo-overlay/issues) or on [gittr.ch](https://gittr.ch/linux/gentoo-overlay/issues).

## Contributing

I gladly accept pull requests for bugs or new ebuilds. Before opening a pull request, please make sure your changes don't upset [`pkgcheck`](https://wiki.gentoo.org/wiki/Pkgcheck). Run the following command and fix warnings and errors:

	pkgcheck scan --net .

## Maintainers

* [Manuel Friedli](mailto:manuel@fritteli.ch)

## Acknowledgements

Thanks go to Jakub Jirutka, the maintainer of the [CVUT Overlay](https://github.com/cvut/gentoo-overlay), from whom I shamelessly copied this README.md for a start.
