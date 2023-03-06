# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3 linux-mod flag-o-matic

DESCRIPTION="Non-fuse kernel driver for exFat and VFat file systems"
HOMEPAGE="https://github.com/dorimanx/exfat-nofuse"
EGIT_REPO_URI="git://github.com/dorimanx/exfat-nofuse.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

MODULE_NAMES="exfat(kernel/fs:${S})"
BUILD_TARGETS="all"

src_prepare(){
	sed -i -e "/^KREL/d" Makefile || die
	sed -e 's/$(MAKE) -C $(KDIR) M=$(PWD) modules/$(MAKE) -C $(KDIR) M=$(PWD) -Wno-error modules/g' -i Makefile
}

src_compile(){
	append-flags -Wno-error
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S} -Wno-error"
	linux-mod_src_compile
}
