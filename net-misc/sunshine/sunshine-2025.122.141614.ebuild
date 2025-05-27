# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fcaps flag-o-matic systemd toolchain-funcs udev xdg

DESCRIPTION="Sunshine - Self-hosted game stream host for Moonlight"
HOMEPAGE="https://github.com/LizardByte/Sunshine"

MY_PV=${tag_name}
BOOST_VER="1.86.0"
MY_BOOST_PV="${BOOST_VER//./_}"

GCC_MAX_VER="14"

NVAPI_OPEN_SOURCE_SDK_SHA="cce4e90b629f712ae6eebafac97739bd1196cdef"
NANORS_SHA="19f07b513e924e471cadd141943c1ec4adc8d0e0"
WAYLAND_PROTOCOLS_SHA="c7b582cb71ec145026a547dcd8abb9dfeba40541"
GOOGLETEST_SHA="6910c9d9165801d8827d628cb72eb7ea9dd538c5"
TPCIRCULARBUFFER_SHA="8833b3a73fab6530cc51e2063a85cced01714cfb"
SHARED_MODULES_SHA="1f8e591b263eef8a0dc04929f2da135af59fac3c"
VIGEMCLIENT_SHA="8d71f6740ffff4671cdadbca255ce528e3cd3fef"
GOOGLETEST_SHA="f8d7d77c06936315286eb55f8de22cd23c188571"
ENET_SHA="44c85e16279553d9c052e572bcbfcd745fb74abf"
GOOGLETEST_SHA="f8d7d77c06936315286eb55f8de22cd23c188571"
BUILD_DEPS_SHA="b567d3c47927c42c33ca86e87892269c354abc02"
DOXYCONFIG_SHA="4501c7b191170cd2adcc12336821b65449186d85"
DOXYCONFIG_SHA="4501c7b191170cd2adcc12336821b65449186d85"
LIBDISPLAYDEVICE_SHA="591387c58465376540fc9f505e938860e08fd47e"
MOONLIGHT_COMMON_C_SHA="e95feaf4951b8dc774671a5d6a1c31d76d78e3ac"
DOXYGEN_AWESOME_CSS_SHA="98dd024a650e71d8afd1215c27134aa779bdbbd7"
INPUTTINO_SHA="fd136cfe492b4375b4507718bcca1f044588fc6f"
DOXYCONFIG_SHA="4501c7b191170cd2adcc12336821b65449186d85"
TRAY_SHA="d45306e686c90a18f5792a1541783d7bc8555bc6"
NV_CODEC_HEADERS_SHA="22441b505d9d9afc1e3002290820909846c24bdc"
WLR_PROTOCOLS_SHA="2ec67ebd26b73bada12f3fa6afdd51563b656722"
FLATPAK_BUILDER_TOOLS_SHA="aac65cf44cd4e008594a9d9ac1db08e2025067a6"
SIMPLE_WEB_SERVER_SHA="187f798d54a9c6cee742f2eb2c54e9ba26f5a385"

SRC_URI="https://github.com/lizardbyte/sunshine/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/LizardByte/nvapi-open-source-sdk/archive/${NVAPI_OPEN_SOURCE_SDK_SHA}.tar.gz -> ${PN}-nvapi-open-source-sdk-${NVAPI_OPEN_SOURCE_SDK_SHA:0:7}.tar.gz
	https://github.com/sleepybishop/nanors/archive/${NANORS_SHA}.tar.gz -> ${PN}-nanors-${NANORS_SHA:0:7}.tar.gz
	https://github.com/LizardByte-infrastructure/wayland-protocols/archive/${WAYLAND_PROTOCOLS_SHA}.tar.gz -> ${PN}-wayland-protocols-${WAYLAND_PROTOCOLS_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/michaeltyson/TPCircularBuffer/archive/${TPCIRCULARBUFFER_SHA}.tar.gz -> ${PN}-TPCircularBuffer-${TPCIRCULARBUFFER_SHA:0:7}.tar.gz
	https://github.com/flathub/shared-modules/archive/${SHARED_MODULES_SHA}.tar.gz -> ${PN}-shared-modules-${SHARED_MODULES_SHA:0:7}.tar.gz
	https://github.com/LizardByte/Virtual-Gamepad-Emulation-Client/archive/${VIGEMCLIENT_SHA}.tar.gz -> ${PN}-ViGEmClient-${VIGEMCLIENT_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/cgutman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/LizardByte/build-deps/archive/${BUILD_DEPS_SHA}.tar.gz -> ${PN}-build-deps-${BUILD_DEPS_SHA:0:7}.tar.gz
	https://github.com/LizardByte/doxyconfig/archive/${DOXYCONFIG_SHA}.tar.gz -> ${PN}-doxyconfig-${DOXYCONFIG_SHA:0:7}.tar.gz
	https://github.com/LizardByte/libdisplaydevice/archive/${LIBDISPLAYDEVICE_SHA}.tar.gz -> ${PN}-libdisplaydevice-${LIBDISPLAYDEVICE_SHA:0:7}.tar.gz
	https://github.com/moonlight-stream/moonlight-common-c/archive/${MOONLIGHT_COMMON_C_SHA}.tar.gz -> ${PN}-moonlight-common-c-${MOONLIGHT_COMMON_C_SHA:0:7}.tar.gz
	https://github.com/jothepro/doxygen-awesome-css/archive/${DOXYGEN_AWESOME_CSS_SHA}.tar.gz -> ${PN}-doxygen-awesome-css-${DOXYGEN_AWESOME_CSS_SHA:0:7}.tar.gz
	https://github.com/games-on-whales/inputtino/archive/${INPUTTINO_SHA}.tar.gz -> ${PN}-inputtino-${INPUTTINO_SHA:0:7}.tar.gz
	https://github.com/LizardByte/doxyconfig/archive/${DOXYCONFIG_SHA}.tar.gz -> ${PN}-doxyconfig-${DOXYCONFIG_SHA:0:7}.tar.gz
	https://github.com/LizardByte/tray/archive/${TRAY_SHA}.tar.gz -> ${PN}-tray-${TRAY_SHA:0:7}.tar.gz
	https://github.com/FFmpeg/nv-codec-headers/archive/${NV_CODEC_HEADERS_SHA}.tar.gz -> ${PN}-nv-codec-headers-${NV_CODEC_HEADERS_SHA:0:7}.tar.gz
	https://github.com/LizardByte-infrastructure/wlr-protocols/archive/${WLR_PROTOCOLS_SHA}.tar.gz -> ${PN}-wlr-protocols-${WLR_PROTOCOLS_SHA:0:7}.tar.gz
	https://github.com/flatpak/flatpak-builder-tools/archive/${FLATPAK_BUILDER_TOOLS_SHA}.tar.gz -> ${PN}-flatpak-builder-tools-${FLATPAK_BUILDER_TOOLS_SHA:0:7}.tar.gz
	https://github.com/LizardByte-infrastructure/Simple-Web-Server/archive/${SIMPLE_WEB_SERVER_SHA}.tar.gz -> ${PN}-Simple-Web-Server-${SIMPLE_WEB_SERVER_SHA:0:7}.tar.gz
	https://github.com/boostorg/boost/releases/download/boost-${BOOST_VER}/boost-${BOOST_VER}-cmake.tar.xz
	ttps://dev.gentoo.org/~chewi/distfiles/${PN}-assets-${PV}.tar.xz
"

#	https://archives.boost.io/release/${BOOST_VER}/source/boost_${MY_BOOST_PV}.tar.gz

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda debug libdrm svt-av1 trayicon vaapi wayland X x264 x265 static-libs"


CDEPEND="
	sys-process/numactl
	dev-libs/libevdev
	dev-libs/openssl:=
	media-libs/opus
	net-libs/miniupnpc:=
	net-misc/curl
	|| (
		media-libs/libpulse
		media-sound/apulse[sdk]
	)
	libdrm? (
		sys-libs/libcap
		x11-libs/libdrm
	)
	svt-av1? ( media-libs/svt-av1:= )
	trayicon? (
		dev-libs/libayatana-appindicator
		x11-libs/libnotify
	)
	vaapi? ( media-libs/libva:=[wayland?,X?] )
	wayland? ( dev-libs/wayland )
	X? ( x11-libs/libX11 )
	x264? ( media-libs/x264:= )
	x265? ( media-libs/x265:= )
"


RDEPEND="
	${CDEPEND}
	<sys-devel/gcc-$(( GCC_MAX_VER + 1 ))_pre[cxx]
	media-libs/mesa[vaapi?]
	X? (
		x11-libs/libxcb
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXtst
	)
"


DEPEND="
	${CDEPEND}
	media-libs/amf-headers
	=media-libs/nv-codec-headers-12*
	wayland? ( dev-libs/wayland-protocols )
"

BDEPEND="
	net-libs/nodejs[npm]
	virtual/pkgconfig
	cuda? ( dev-util/nvidia-cuda-toolkit )
	wayland? ( dev-util/wayland-scanner )
"

# Make this mess a bit simpler.
CMAKE_IN_SOURCE_BUILD=1

# Make npm behave.
export npm_config_audit=false
export npm_config_color=false
export npm_config_foreground_scripts=true
export npm_config_loglevel=verbose
export npm_config_optional=false
export npm_config_progress=false
export npm_config_save=false

S="${WORKDIR}/${P^}"
CC="gcc-14"
CXX="g++-14"


src_unpack() {
	default
	rm $S/.gitmodules || die

	rmdir "${S}/third-party/nvapi-open-source-sdk"
	if [ -e "${WORKDIR}/nvapi-open-source-sdk-${NVAPI_OPEN_SOURCE_SDK_SHA}" ]; then
		ln -s "${WORKDIR}/nvapi-open-source-sdk-${NVAPI_OPEN_SOURCE_SDK_SHA}" "${S}/third-party/nvapi-open-source-sdk" || die
	else
		ln -s "${WORKDIR}/nvapi-open-source-sdk" "${S}/third-party/nvapi-open-source-sdk" || die
	fi
	rmdir "${S}/third-party/nanors"
	if [ -e "${WORKDIR}/nanors-${NANORS_SHA}" ]; then
		ln -s "${WORKDIR}/nanors-${NANORS_SHA}" "${S}/third-party/nanors" || die
	else
		ln -s "${WORKDIR}/nanors" "${S}/third-party/nanors" || die
	fi
	rmdir "${S}/third-party/wayland-protocols"
	if [ -e "${WORKDIR}/wayland-protocols-${WAYLAND_PROTOCOLS_SHA}" ]; then
		ln -s "${WORKDIR}/wayland-protocols-${WAYLAND_PROTOCOLS_SHA}" "${S}/third-party/wayland-protocols" || die
	else
		ln -s "${WORKDIR}/wayland-protocols" "${S}/third-party/wayland-protocols" || die
	fi
	rmdir "${S}/third-party/googletest"
	if [ -e "${WORKDIR}/googletest-${GOOGLETEST_SHA}" ]; then
		ln -s "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/third-party/googletest" || die
	else
		ln -s "${WORKDIR}/googletest" "${S}/third-party/googletest" || die
	fi
	rmdir "${S}/third-party/TPCircularBuffer"
	if [ -e "${WORKDIR}/TPCircularBuffer-${TPCIRCULARBUFFER_SHA}" ]; then
		ln -s "${WORKDIR}/TPCircularBuffer-${TPCIRCULARBUFFER_SHA}" "${S}/third-party/TPCircularBuffer" || die
	else
		ln -s "${WORKDIR}/TPCircularBuffer" "${S}/third-party/TPCircularBuffer" || die
	fi
	rmdir "${S}/packaging/linux/flatpak/deps/shared-modules"
	if [ -e "${WORKDIR}/shared-modules-${SHARED_MODULES_SHA}" ]; then
		ln -s "${WORKDIR}/shared-modules-${SHARED_MODULES_SHA}" "${S}/packaging/linux/flatpak/deps/shared-modules" || die
	else
		ln -s "${WORKDIR}/shared-modules" "${S}/packaging/linux/flatpak/deps/shared-modules" || die
	fi
	rmdir "${S}/third-party/ViGEmClient"
	if [ -e "${WORKDIR}/Virtual-Gamepad-Emulation-Client-${VIGEMCLIENT_SHA}" ]; then
		ln -s "${WORKDIR}/Virtual-Gamepad-Emulation-Client-${VIGEMCLIENT_SHA}" "${S}/third-party/ViGEmClient" || die
	else
		ln -s "${WORKDIR}/Virtual-Gamepad-Emulation-Client" "${S}/third-party/ViGEmClient" || die
	fi
	rmdir "${S}/third-party/build-deps"
	if [ -e "${WORKDIR}/build-deps-${BUILD_DEPS_SHA}" ]; then
		ln -s "${WORKDIR}/build-deps-${BUILD_DEPS_SHA}" "${S}/third-party/build-deps" || die
	else
		ln -s "${WORKDIR}/build-deps" "${S}/third-party/build-deps" || die
	fi
	rmdir "${S}/third-party/doxyconfig"
	if [ -e "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" ]; then
		ln -s "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" "${S}/third-party/doxyconfig" || die
	else
		ln -s "${WORKDIR}/doxyconfig" "${S}/third-party/doxyconfig" || die
	fi
	rmdir "${S}/third-party/libdisplaydevice"
	if [ -e "${WORKDIR}/libdisplaydevice-${LIBDISPLAYDEVICE_SHA}" ]; then
		ln -s "${WORKDIR}/libdisplaydevice-${LIBDISPLAYDEVICE_SHA}" "${S}/third-party/libdisplaydevice" || die
	else
		ln -s "${WORKDIR}/libdisplaydevice" "${S}/third-party/libdisplaydevice" || die
	fi
	rmdir "${S}/third-party/moonlight-common-c"
	if [ -e "${WORKDIR}/moonlight-common-c-${MOONLIGHT_COMMON_C_SHA}" ]; then
		ln -s "${WORKDIR}/moonlight-common-c-${MOONLIGHT_COMMON_C_SHA}" "${S}/third-party/moonlight-common-c" || die
	else
		ln -s "${WORKDIR}/moonlight-common-c" "${S}/third-party/moonlight-common-c" || die
	fi
	rmdir "${S}/third-party/inputtino"
	if [ -e "${WORKDIR}/inputtino-${INPUTTINO_SHA}" ]; then
		ln -s "${WORKDIR}/inputtino-${INPUTTINO_SHA}" "${S}/third-party/inputtino" || die
	else
		ln -s "${WORKDIR}/inputtino" "${S}/third-party/inputtino" || die
	fi
	rmdir "${S}/third-party/tray"
	if [ -e "${WORKDIR}/tray-${TRAY_SHA}" ]; then
		ln -s "${WORKDIR}/tray-${TRAY_SHA}" "${S}/third-party/tray" || die
	else
		ln -s "${WORKDIR}/tray" "${S}/third-party/tray" || die
	fi
	rmdir "${S}/third-party/nv-codec-headers"
	if [ -e "${WORKDIR}/nv-codec-headers-${NV_CODEC_HEADERS_SHA}" ]; then
		ln -s "${WORKDIR}/nv-codec-headers-${NV_CODEC_HEADERS_SHA}" "${S}/third-party/nv-codec-headers" || die
	else
		ln -s "${WORKDIR}/nv-codec-headers" "${S}/third-party/nv-codec-headers" || die
	fi
	rmdir "${S}/third-party/wlr-protocols"
	if [ -e "${WORKDIR}/wlr-protocols-${WLR_PROTOCOLS_SHA}" ]; then
		ln -s "${WORKDIR}/wlr-protocols-${WLR_PROTOCOLS_SHA}" "${S}/third-party/wlr-protocols" || die
	else
		ln -s "${WORKDIR}/wlr-protocols" "${S}/third-party/wlr-protocols" || die
	fi
	rmdir "${S}/packaging/linux/flatpak/deps/flatpak-builder-tools"
	if [ -e "${WORKDIR}/flatpak-builder-tools-${FLATPAK_BUILDER_TOOLS_SHA}" ]; then
		ln -s "${WORKDIR}/flatpak-builder-tools-${FLATPAK_BUILDER_TOOLS_SHA}" "${S}/packaging/linux/flatpak/deps/flatpak-builder-tools" || die
	else
		ln -s "${WORKDIR}/flatpak-builder-tools" "${S}/packaging/linux/flatpak/deps/flatpak-builder-tools" || die
	fi
	rmdir "${S}/third-party/Simple-Web-Server"
	if [ -e "${WORKDIR}/Simple-Web-Server-${SIMPLE_WEB_SERVER_SHA}" ]; then
		ln -s "${WORKDIR}/Simple-Web-Server-${SIMPLE_WEB_SERVER_SHA}" "${S}/third-party/Simple-Web-Server" || die
	else
		ln -s "${WORKDIR}/Simple-Web-Server" "${S}/third-party/Simple-Web-Server" || die
	fi
	rmdir "${S}/third-party/libdisplaydevice/third-party/googletest"
	if [ -e "${WORKDIR}/googletest-${GOOGLETEST_SHA}" ]; then
		ln -s "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/third-party/libdisplaydevice/third-party/googletest" || die
	else
		ln -s "${WORKDIR}/googletest" "${S}/third-party/libdisplaydevice/third-party/googletest" || die
	fi
	rmdir "${S}/third-party/moonlight-common-c/enet"
	if [ -e "${WORKDIR}/enet-${ENET_SHA}" ]; then
		ln -s "${WORKDIR}/enet-${ENET_SHA}" "${S}/third-party/moonlight-common-c/enet" || die
	else
		ln -s "${WORKDIR}/enet" "${S}/third-party/moonlight-common-c/enet" || die
	fi
	rmdir "${S}/third-party/tray/third-party/googletest"
	if [ -e "${WORKDIR}/googletest-${GOOGLETEST_SHA}" ]; then
		ln -s "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/third-party/tray/third-party/googletest" || die
	else
		ln -s "${WORKDIR}/googletest" "${S}/third-party/tray/third-party/googletest" || die
	fi
	rmdir "${S}/third-party/libdisplaydevice/third-party/doxyconfig"
	if [ -e "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" ]; then
		ln -s "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" "${S}/third-party/libdisplaydevice/third-party/doxyconfig" || die
	else
		ln -s "${WORKDIR}/doxyconfig" "${S}/third-party/libdisplaydevice/third-party/doxyconfig" || die
	fi
	rmdir "${S}/third-party/doxyconfig/doxygen-awesome-css"
	if [ -e "${WORKDIR}/doxygen-awesome-css-${DOXYGEN_AWESOME_CSS_SHA}" ]; then
		ln -s "${WORKDIR}/doxygen-awesome-css-${DOXYGEN_AWESOME_CSS_SHA}" "${S}/third-party/doxyconfig/doxygen-awesome-css" || die
	else
		ln -s "${WORKDIR}/doxygen-awesome-css" "${S}/third-party/doxyconfig/doxygen-awesome-css" || die
	fi
	rmdir "${S}/third-party/tray/third-party/doxyconfig"
	if [ -e "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" ]; then
		ln -s "${WORKDIR}/doxyconfig-${DOXYCONFIG_SHA}" "${S}/third-party/tray/third-party/doxyconfig" || die
	else
		ln -s "${WORKDIR}/doxyconfig" "${S}/third-party/tray/third-party/doxyconfig" || die
	fi


	sed -e "s#0.0.0#${PV}#g" -i "$S/CMakeLists.txt"
	sed -e "s#https://github.com/boostorg/boost/releases/download/boost-${BOOST_VER}/boost-${BOOST_VER}-cmake.tar.xz#file://${DISTDIR}/boost-${BOOST_VER}-cmake.tar.xz#g" -i "$S/cmake/dependencies/Boost_Sunshine.cmake"

	sed -e "s/set(CMAKE_CXX_STANDARD 20)/set(CMAKE_CXX_STANDARD 20)\nset(BUILD_SHARED_LIBS OFF)\n/g" -i "${S}/third-party/libdisplaydevice/CMakeLists.txt" || die
	sed -e "s/add_library(libinputtino)/set(BUILD_SHARED_LIBS OFF)\nadd_library(libinputtino)/g" -i "${S}/third-party/inputtino/CMakeLists.txt" || die
	sed -e "s/include_guard(GLOBAL)/include_guard(GLOBAL)\nset(BUILD_SHARED_LIBS OFF)\n/g" -i "${S}/cmake/dependencies/Boost_Sunshine.cmake" || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_WERROR=ON
		-DCMAKE_BUILD_TYPE=Release
		-DBOOST_USE_STATIC=$(usex static-libs)
		-DBoost_USE_STATIC_LIBS=$(usex static-libs)
		-DBUILD_DOCS=OFF
		-DBUILD_TESTS=no
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=yes
		-DSUNSHINE_ASSETS_DIR=share/${PN}
		-DSUNSHINE_ENABLE_CUDA=$(usex cuda)
		-DSUNSHINE_ENABLE_DRM=$(usex libdrm)
		-DSUNSHINE_ENABLE_VAAPI=$(usex vaapi)
		-DSUNSHINE_ENABLE_WAYLAND=$(usex wayland)
		-DSUNSHINE_ENABLE_X11=$(usex X)
		-DSUNSHINE_ENABLE_TRAY=$(usex trayicon)
		-DSUNSHINE_SYSTEM_WAYLAND_PROTOCOLS=yes
		-DSYSTEMD_USER_UNIT_INSTALL_DIR=$(systemd_get_userunitdir)
		-DUDEV_RULES_INSTALL_DIR=$(get_udevdir)/rules.d
	)
	[[ ${PV} = 9999* ]] || mycmakeargs+=( -DNPM="${BROOT}"/bin/true )
	CMAKE_USE_DIR="${S}" cmake_src_configure
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst
	use libdrm && fcaps cap_sys_admin+p usr/bin/"$(readlink "${EROOT}"/usr/bin/${PN})"
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}


