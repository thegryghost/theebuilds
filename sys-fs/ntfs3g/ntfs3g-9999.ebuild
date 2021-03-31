# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 linux-mod flag-o-matic

DESCRIPTION="Paragon ntfs3g"
HOMEPAGE=""
EGIT_REPO_URI="git://git.edng.net:ntfs3g.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

MODULE_NAMES="ntfs3g(kernel/fs:${S})"
BUILD_TARGETS="all"

src_compile(){
	BUILD_PARAMS="KVERSION=${KV_OUT_DIR}"
	linux-mod_src_compile
}
