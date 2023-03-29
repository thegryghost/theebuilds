# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ENET_COMMIT=8d69c5abe4b699e7077395e01927bd102b3ba597
MOONLIGHT_COMMON_C_COMMIT=3b9d8a31763be77c921bd2581b5e75f4d40a1b11
SIMPLE_WEB_SERVER_COMMIT=898b6abd1be568ff9de4390d44288962e3fac337

inherit cmake cuda linux-info systemd

DESCRIPTION="Gamestream host for Moonlight"
HOMEPAGE="https://github.com/loki-47-6F-64/sunshine"
SRC_URI="
	https://github.com/LizardByte/Sunshine/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cgutman/enet/archive/${ENET_COMMIT}.tar.gz -> ${PN}-enet-${ENET_COMMIT}.tar.gz
	https://github.com/moonlight-stream/moonlight-common-c/archive/${MOONLIGHT_COMMON_C_COMMIT}.tar.gz -> ${PN}-moonlight-common-c-${MOONLIGHT_COMMON_C_COMMIT}.tar.gz
	https://gitlab.com/eidheim/Simple-Web-Server/-/archive/v3.1.1/Simple-Web-Server-v3.1.1.tar.bz2
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cuda kms wayland +x11"

RDEPEND="
	dev-libs/boost:=
	net-libs/miniupnpc:=
	dev-libs/openssl:=
	media-video/ffmpeg:=

	cuda? ( dev-util/nvidia-cuda-toolkit )
	kms? (
		sys-libs/libcap
		x11-libs/libdrm
	)
	wayland? ( dev-libs/wayland )
	x11? ( x11-libs/libX11 )
"
DEPEND="${RDEPEND}"


#PATCHES=(
#	"${FILESDIR}/${PN}-${PV}-packaging.patch"
#	"${FILESDIR}/${PN}-${PV}-cbs-link.patch"
#)

S=${WORKDIR}/Sunshine-${PV}

pkg_setup() {
	CONFIG_CHECK="INPUT_UINPUT"
	linux-info_pkg_setup
}

src_prepare() {
	cmake_src_prepare

	local EXTERNAL_PACKAGES=( Simple-Web-Server moonlight-common-c )
	mv 
	for package in ${EXTERNAL_PACKAGES[@]}; do
		local commit_variable="${package^^}_COMMIT"
		commit_variable="${commit_variable//-/_}"
		rm -r third-party/"${package}" || die
		ln -s ../../${package}-${!commit_variable} third-party/"${package}" || die
	done

	rm -r third-party/moonlight-common-c/enet || die
	ln -sf ../enet-${ENET_COMMIT} third-party/moonlight-common-c/enet
}

src_configure() {
	local mycmakeargs=(
		-DPACKAGE_MODE=ON
		-DSUNSHINE_ASSETS_DIR="/usr/share/${PN}/assets"
		-DSUNSHINE_CONFIG_DIR="/etc/${PN}"
		-DSUNSHINE_ENABLE_CUDA=$(usex cuda)
		-DSUNSHINE_ENABLE_DRM=$(usex kms)
		-DSUNSHINE_ENABLE_WAYLAND=$(usex wayland)
		-DSUNSHINE_ENABLE_X11=$(usex x11)
		-DSUNSHINE_EXECUTABLE_PATH="/usr/bin/${PN}"
	)

	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/${PN}"

	insinto etc/sunshine
	doins -r assets/{apps_linux.json,"${PN}.conf"}

	insinto usr/share/"${PN}"/assets
	doins -r assets/{box.png,web}

	insinto usr/share/"${PN}"/assets/shaders
	doins -r assets/shaders/opengl

	systemd_douserunit "${BUILD_DIR}/${PN}.service"
}

pkg_postinst() {
	if use cuda; then
		elog "Make sure your nvidia-drivers version is compatible with cuda-toolkit."
		elog "Refer https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html for compatibility table."
	fi
}
