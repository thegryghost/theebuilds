# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}
MY_PN_BIN=${PN/-bin/d}
inherit unpacker

DESCRIPTION="nudl (Navigation Update Downloader) is an unofficial tool for downloading firmware images for HMG infotainment systems."
HOMEPAGE="https://github.com/chenxiaolong/nudl"
SRC_URI="https://github.com/chenxiaolong/nudl/releases/download/v${PV}/nudl-${PV}-x86_64-unknown-linux-musl.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}

RESTRICT="mirror bindist"

src_unpack() {
	unpack ${A}
}

src_install() {
	insinto /opt/bin
	doins nudl
	fperms +x /opt/bin/nudl
}
