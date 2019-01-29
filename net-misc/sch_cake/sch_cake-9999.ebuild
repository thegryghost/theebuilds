# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 linux-mod

DESCRIPTION="sch_cake out of tree module"
HOMEPAGE="https://github.com/dtaht/sch_cake"
EGIT_REPO_URI="https://github.com/dtaht/sch_cake.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

MODULE_NAMES="sch_cake(kernel/net/sched:${S})"
BUILD_TARGETS="default"

#src_prepare(){
#	sed -i -e "/^KREL/d" Makefile || die
#}

#src_compile(){
#	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
#	linux-mod_src_compile
#}
