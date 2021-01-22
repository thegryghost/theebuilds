# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

URELEASE="focal"
inherit cmake-utils

# Handle version strings here so as not to use 'ubuntu-versionator' eclass #
MY_PV="${PV:0:5}"
MY_P="${PN}-${MY_PV}"
UVER="-${PVR_PL_MINOR}"

DESCRIPTION="Simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://launchpad.net/properties-cpp"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="mirror"

DEPEND="dev-libs/boost
	doc? ( app-doc/doxygen )
        test? ( >=dev-cpp/gtest-1.8.1 )"

S="${WORKDIR}/${MY_P}"
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	use !doc && truncate -s0 doc/CMakeLists.txt
	use !test && truncate -s0 tests/CMakeLists.txt
	cmake-utils_src_prepare
}
