# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.5"

inherit eutils autotools subversion

inherit distutils versionator

KEYWORDS="~x86 ~amd64"

DESCRIPTION="mlbviewer (Major League Baseball Viewer) for linux"

ESVN_REPO_URI="https://mlbviewer.svn.sourceforge.net/svnroot/mlbviewer/branches/nexdef2011"
SLOT="0"
IUSE=""


RDEPEND="dev-python/suds
dev-python/pyxml
dev-python/simplejson
media-video/rtmpdump"

DEPEND="${RDEPEND}"

src_prepare(){
	distutils_src_prepare
	cp "${FILESDIR}/${P}-setup.py" setup.py || die "Copying of setup.py failed"
}

src_install() {
		distutils_src_install
}
