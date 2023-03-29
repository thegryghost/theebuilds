# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

MY_PV=$(ver_rs 0-3 -)
MY_PR=${PR:1}

DESCRIPTION="Bento4"
HOMEPAGE="https://www.bento4.com/"

#KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~riscv ~x86"

SRC_URI="https://www.bok.net/Bento4/source/Bento4-SRC-${MY_PV}-${MY_PR}.zip"
S="${WORKDIR}"
BD="${WORKDIR}_build"
src_install() {
	mkdir -p "${D}/usr/include/bento4"
	mkdir -p "${D}/usr/bin"
	find "${S}/Source/C++/" -name '*.h' -exec cp {} "${D}/usr/include/bento4" \;
	find /var/tmp/portage/media-libs/bento4-1.6.0-r639/work_build/ -maxdepth 1 -executable -type f -exec cp {} "${D}/usr/bin" \;
	dolib.a "${BD}/libap4.a"
	pwd
}
