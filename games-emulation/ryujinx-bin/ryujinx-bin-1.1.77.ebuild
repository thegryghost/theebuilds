# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib multiprocessing xdg

MY_PN=${PN/-bin/}
MY_PN_BIN=${PN/-bin/d}
S="${WORKDIR}/publish"

DESCRIPTION="Experimental Nintendo Switch emulator written in C#"
HOMEPAGE="https://ryujinx.org/"
SRC_URI="https://github.com/Ryujinx/release-channel-master/releases/download/${PV}/ryujinx-${PV}-linux_x64.tar.gz"

DEPEND="sys-libs/zlib"

RDEPEND="${DEPEND}
	acct-group/users
	media-libs/libsdl2
	media-libs/libsoundio"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

src_install() {
	exeinto /opt/ryujinx
	doexe Ryujinx

	dosym /opt/ryujinx/Ryujinx /usr/bin/Ryujinx || die

	keepdir /opt/ryujinx/Logs
	fperms ug+rwx /opt/ryujinx/Logs
	fowners :users /opt/ryujinx/Logs


}
