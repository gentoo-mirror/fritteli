# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="A Matrix-WhatsApp puppeting bridge."
HOMEPAGE="https://docs.mau.fi/bridges/go/whatsapp/index.html"
SRC_URI="https://github.com/mautrix/whatsapp/releases/download/v${PV}/mautrix-whatsapp-amd64 -> ${P}"

IUSE="+ffmpeg postgres"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/mautrix-whatsapp-bin"
RDEPEND="${DEPEND}
	ffmpeg? ( media-video/ffmpeg[opus] )
	postgres? ( >=dev-db/postgresql-10 )
	!postgres? ( dev-db/sqlite )"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}" "${S}/mautrix-whatsapp"
}

src_compile() {
	:
}

src_install() {
	exeinto /opt/mautrix-whatsapp
	doexe mautrix-whatsapp

	insinto /opt/mautrix-whatsapp
	newins "${FILESDIR}/example-config.yaml" config.yaml

	systemd_dounit "${FILESDIR}"/mautrix-whatsapp.service

	fowners mautrix-whatsapp-bin:mautrix-whatsapp-bin /opt/mautrix-whatsapp/mautrix-whatsapp
	fowners mautrix-whatsapp-bin:mautrix-whatsapp-bin /opt/mautrix-whatsapp/config.yaml
	fperms 0640 /opt/mautrix-whatsapp/config.yaml
}
