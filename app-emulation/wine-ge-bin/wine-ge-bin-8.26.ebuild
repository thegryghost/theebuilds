# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WINE_GECKO=2.47.4
WINE_MONO=9.2.0

MY_PV=${PV/./-}
MY_PN=${PN/-bin/}
MY_PN_BIN=${PN/-bin/d}
inherit unpacker

DESCRIPTION="wine-ge-custom"
HOMEPAGE="https://github.com/GloriousEggroll/wine-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton${MY_PV}/wine-lutris-GE-Proton${MY_PV}-x86_64.tar.xz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/lutris-GE-Proton${MY_PV}-x86_64"

RESTRICT="mirror bindist"

src_unpack() {
        unpack ${A}
}

src_install() {
	insinto /opt/${P}
	doins -r bin
	fperms -R +x /opt/${P}/bin/

	doins -r lib
	fperms +x /opt/${P}/lib/
	fperms -R +x /opt/${P}/lib/wine/i386-unix/
	fperms -R +x /opt/${P}/lib/gstreamer-1.0/

	doins -r lib64
	fperms +x /opt/${P}/lib64/
	fperms -R +x /opt/${P}/lib64/wine/x86_64-unix/
	fperms -R +x /opt/${P}/lib64/gstreamer-1.0/

	insinto /opt/${P}
	doins -r share
}
