# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}
MY_PN_BIN=${PN/-bin/d}
inherit unpacker

DESCRIPTION="ready-to-use RTSP / RTMP / LL-HLS server and proxy that allows to read, publish and proxy video and audio streams"
HOMEPAGE="https://github.com/aler9/mediamtx"
SRC_URI="https://github.com/aler9/mediamtx/releases/download/v${PV}/mediamtx_v${PV}_linux_amd64.tar.gz"

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
        dodoc mediamtx.yml
        insinto /opt/${MY_PN}
        doins mediamtx
        fperms +x /opt/${MY_PN}/mediamtx
}
