# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Tvheadend is a combined DVB receiver, Digital Video Recorder and Live TV streaming server"
HOMEPAGE="http://www.lonelycoder.com/hts/"
SRC_URI="http://www.lonelycoder.com/debian/dists/hts/main/source/hts-tvheadend_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi"

DEPEND="
	media-tv/linuxtv-dvb-headers
        media-video/ffmpeg"

RDEPEND="avahi? ( net-dns/avahi )"

S="${WORKDIR}/hts-tvheadend-${PV}"

pkg_setup() {
	enewuser tvheadend -1 -1 /dev/null video
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/tvheadend-ffmpeg.patch"
}

src_configure() {
	econf \
		$(use_enable avahi) \
		--release \
		|| die "Configure failed!"
}

src_install() {
	newbin build.Linux/tvheadend tvheadend
	newman man/tvheadend.1 tvheadend.1

	newinitd "${FILESDIR}/tvheadend.initd" tvheadend
	newconfd "${FILESDIR}/tvheadend.confd" tvheadend

	dodir /etc/tvheadend
	fperms 0700 /etc/tvheadend
	fowners tvheadend:video /etc/tvheadend
}

pkg_postinst() {
	elog "To start Tvheadend:"
	elog "/etc/init.d/tvheadend start"
	elog
	elog "To start Tvheadend at boot:"
	elog "rc-update add tvheadend default"
	elog
	elog "The Tvheadend web interface can be reached at:"
	elog "http://localhost:9981/"
	elog
	elog "Make sure that you change the default username"
	elog "and password via the Configuration / Access control"
	elog "tab in the web interface."
}
