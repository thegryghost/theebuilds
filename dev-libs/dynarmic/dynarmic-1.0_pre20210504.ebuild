# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
COMMIT_SHA="f8d8ea0debbdbcebbddcb31b560ef266dd68c2b0"

inherit cmake vcs-snapshot

DESCRIPTION="An ARM dynamic recompiler"
HOMEPAGE="https://github.com/MerryMage/dynarmic"
SRC_URI="https://github.com/MerryMage/${PN}/archive/${COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-libs/boost:="
DEPEND="${RDEPEND}
	dev-cpp/robin-map
	dev-libs/mp
	dev-cpp/catch:0
	dev-libs/libfmt:=
	dev-libs/xbyak
"

PATCHES=(
	"${FILESDIR}/dynarmic-skip-bundled-dependencies.patch"
)

src_prepare() {
	cmake_src_prepare
	rm -r externals/{catch,fmt,xbyak} || die
}

src_configure() {
	local mycmakeargs=(
		-DDYNARMIC_SKIP_EXTERNALS=ON
		-DDYNARMIC_TESTS=$(usex test)
		-DDYNARMIC_WARNINGS_AS_ERRORS=OFF
	)
	cmake_src_configure
}

src_install() {
	insinto /usr/include
	doins -r "include/${PN}"

	dolib.so "${BUILD_DIR}/src/lib${PN}.so"
}
