# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=4

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""

inherit toolchain-funcs eutils ${VCS_ECLASS}

DESCRIPTION="CrystalHD lib"
HOMEPAGE=""
#SRC_URI="http://cetoncorp.com/downloads/ceton_infinitv_linux_driver_1_7.tar.gz"
EGIT_REPO_URI="git://git.linuxtv.org/jarod/crystalhd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	S="${WORKDIR}/crystalhd-lib-9999/linux_lib/libcrystalhd"
}
