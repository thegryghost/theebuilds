# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.adaptive.git"
SRC_URI=""

KODI_BENTO_VER="1.6.0-641-Omega"

case ${PV} in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/xbmc/inputstream.adaptive.git"
	EGIT_BRANCH="Omega"
	inherit git-r3
	;;
*)
	KEYWORDS="~amd64 ~x86"
	CODENAME="Omega"
	SRC_URI="https://github.com/xbmc/inputstream.adaptive/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz
		https://github.com/xbmc/Bento4/archive/refs/tags/${KODI_BENTO_VER}.tar.gz -> ${PN}-bento-${KODI_BENTO_VER}.tar.gz"
	S="${WORKDIR}/inputstream.adaptive-${PV}-${CODENAME}"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
RESTRICT="!test? ( test )"
IUSE="test"

COMMON_DEPEND="
	dev-libs/expat
	dev-libs/pugixml
	=media-tv/kodi-21*
	"
DEPEND="
	${COMMON_DEPEND}
	test? ( dev-cpp/gtest )
	"
RDEPEND="
	${COMMON_DEPEND}
	"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DBENTO4_URL="${DISTDIR}/${PN}-bento-${KODI_BENTO_VER}.tar.gz"
		-DENABLE_INTERNAL_BENTO4=TRUE
	)
	cmake_src_configure
}
