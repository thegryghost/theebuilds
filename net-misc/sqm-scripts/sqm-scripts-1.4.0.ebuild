# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-r3

DESCRIPTION="sqm-scripts traffic shaper"
HOMEPAGE="https://github.com/tohojo/sqm-scripts"
EGIT_COMMIT="v1.4.0"
EGIT_REPO_URI="https://github.com/tohojo/sqm-scripts.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake install PLATFORM=linux DESTDIR=$D
	rm -rf $D/usr/lib/systemd $D/usr/lib/tmpfiles.d
	newinitd "${FILESDIR}"/sqm sqm
}
