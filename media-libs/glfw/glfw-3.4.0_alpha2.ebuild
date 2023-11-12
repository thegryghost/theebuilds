# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="Portable OpenGL FrameWork"
HOMEPAGE="https://www.glfw.org/"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~riscv ~x86"
IUSE="wayland-only"

MY_PV="mainline-${PV/./-}"

GLFW_SHA="3eaf1255b29fdf5c2895856c7be7d7185ef2b241"

SRC_URI="https://github.com/glfw/glfw/archive/${GLFW_SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${GLFW_SHA}"

RDEPEND="
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	wayland-only? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	!wayland-only? (
		media-libs/libglvnd[X]
		x11-libs/libX11[${MULTILIB_USEDEP}]
	)"
DEPEND="
	${RDEPEND}
	wayland-only? (
		dev-libs/wayland-protocols
		x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	)
	!wayland-only? (
		x11-base/xorg-proto
		x11-libs/libXcursor[${MULTILIB_USEDEP}]
		x11-libs/libXi[${MULTILIB_USEDEP}]
		x11-libs/libXinerama[${MULTILIB_USEDEP}]
		x11-libs/libXrandr[${MULTILIB_USEDEP}]
	)"
BDEPEND="
	wayland-only? (
		dev-util/wayland-scanner
		kde-frameworks/extra-cmake-modules
	)"

PATCHES=(
	"${FILESDIR}/glfw.patch"
)


src_configure() {
	local mycmakeargs=(
		-DGLFW_BUILD_EXAMPLES=no
		-DGLFW_USE_WAYLAND=$(usex wayland-only)
	)

	cmake-multilib_src_configure
}
