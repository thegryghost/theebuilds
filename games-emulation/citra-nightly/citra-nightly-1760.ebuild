# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo 3DS Emulator"
HOMEPAGE="https://github.com/citra-emu/citra-nightly"


CUBEB_SHA="1d66483ad2b93f0e00e175f9480c771af90003a7"
FMT_SHA="cc09f1a6798c085c325569ef466bcdcffdc266d4"
CRYPTOPP_SHA="f2102243e6fdd48c0b2a393a0993cca228f20573"
LODEPNG_SHA="31d9704fdcca0b68fb9656d4764fa0fb60e460c2"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
LIBYUV_SHA="19d71f6b351fe992ae34b114eebd872c383a6bdb"
ZSTD_SHA="97a3da1df009d4dc67251de0c4b1c9d7fe286fc1"
NIHSTRO_SHA="fd69de1a1b960ec296cc67d32257b0f9e2d89ac6"
ENET_SHA="498b9e3571c2e096d7143c3c76852c5ec28d7885"
BOOST_SHA="36603a1e665e849d29b1735a12c0a51284a10dd0"
XBYAK_SHA="c306b8e5786eeeb87b8925a8af5c3bf057ff5a90"
CATCH_SHA="c4e3767e265808590986d5db6ca1b5532a7f3d13"
CPP_JWT_SHA="6e27aa4c8671e183f11e327a2e1f556c64fdc4a9"
LIBRESSL_SHA="039d945419205f34581db23b408c08f5b21d6354"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
TEAKRA_SHA="01db7cdd00aabcce559a8dddce8798dabb71949b"
DYNARMIC_SHA="af0d4a7c18ee90d544866a8cf24e6a0d48d3edc4"
DISCORD_RPC_SHA="963aa9f3e5ce81a4682c6ca3d136cddda614db33"

SRC_URI="https://github.com/citra-emu/citra-nightly/archive/refs/tags/nightly-${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/kinetiknz/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_SHA}.tar.gz -> ${PN}-fmt-${FMT_SHA:0:7}.tar.gz
	https://github.com/weidai11/cryptopp/archive/${CRYPTOPP_SHA}.tar.gz -> ${PN}-cryptopp-${CRYPTOPP_SHA:0:7}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/lemenkov/libyuv/archive/${LIBYUV_SHA}.tar.gz -> ${PN}-libyuv-${LIBYUV_SHA:0:7}.tar.gz
	https://github.com/facebook/zstd/archive/${ZSTD_SHA}.tar.gz -> ${PN}-zstd-${ZSTD_SHA:0:7}.tar.gz
	https://github.com/neobrain/nihstro/archive/${NIHSTRO_SHA}.tar.gz -> ${PN}-nihstro-${NIHSTRO_SHA:0:7}.tar.gz
	https://github.com/lsalzman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-boost/archive/${BOOST_SHA}.tar.gz -> ${PN}-boost-${BOOST_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/catchorg/Catch2/archive/${CATCH_SHA}.tar.gz -> ${PN}-catch-${CATCH_SHA:0:7}.tar.gz
	https://github.com/arun11299/cpp-jwt/archive/${CPP_JWT_SHA}.tar.gz -> ${PN}-cpp-jwt-${CPP_JWT_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-libressl-portable/archive/${LIBRESSL_SHA}.tar.gz -> ${PN}-libressl-${LIBRESSL_SHA:0:7}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_CMAKE_SHA}.tar.gz -> ${PN}-sanitizers-cmake-${SANITIZERS_CMAKE_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/wwylele/teakra/archive/${TEAKRA_SHA}.tar.gz -> ${PN}-teakra-${TEAKRA_SHA:0:7}.tar.gz
	https://github.com/citra-emu/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/discord/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord"

DEPEND=">=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	>=dev-libs/libfmt-8.0.1
	dev-libs/libzip
	>=dev-libs/openssl-1.1
	media-libs/libsdl2
	dev-qt/qtgui
	dev-qt/qtcore
	dev-qt/qtmultimedia
	dev-qt/qtnetwork
	dev-qt/qtopengl
	dev-qt/qtwidgets
	app-eselect/eselect-citra
	>=media-libs/opus-1.3
	media-video/ffmpeg
	>=sys-libs/zlib-1.2
	>=dev-cpp/nlohmann_json-3.8
	virtual/libusb:="

RDEPEND="${DEPEND}
	app-arch/zstd
	media-libs/vulkan-loader"

BDEPEND="dev-cpp/catch
	dev-cpp/nlohmann_json
	dev-util/vulkan-headers"

S="${WORKDIR}/${PN}-nightly-${PV}"


PATCHES=(
	"${FILESDIR}/001-hotkeys.patch"
	"${FILESDIR}/cmake.patch"
	"${FILESDIR}/citra-inih.patch"
)

src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/cubeb"
	mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	rmdir "${S}/externals/fmt"
	mv "${WORKDIR}/fmt-${FMT_SHA}" "${S}/externals/fmt" || die
	rmdir "${S}/externals/cryptopp/cryptopp"
	mv "${WORKDIR}/cryptopp-${CRYPTOPP_SHA}" "${S}/externals/cryptopp/cryptopp" || die
	rmdir "${S}/externals/lodepng/lodepng"
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	rmdir "${S}/externals/libyuv"
	mv "${WORKDIR}/libyuv-${LIBYUV_SHA}" "${S}/externals/libyuv" || die
	rmdir "${S}/externals/zstd"
	mv "${WORKDIR}/zstd-${ZSTD_SHA}" "${S}/externals/zstd" || die
	rmdir "${S}/externals/nihstro"
	mv "${WORKDIR}/nihstro-${NIHSTRO_SHA}" "${S}/externals/nihstro" || die
	rmdir "${S}/externals/enet"
	mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/externals/enet" || die
	rmdir "${S}/externals/boost"
	mv "${WORKDIR}/ext-boost-${BOOST_SHA}" "${S}/externals/boost" || die
	rmdir "${S}/externals/xbyak"
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	rmdir "${S}/externals/catch"
	mv "${WORKDIR}/Catch2-${CATCH_SHA}" "${S}/externals/catch" || die
	rmdir "${S}/externals/cpp-jwt"
	mv "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" "${S}/externals/cpp-jwt" || die
	rmdir "${S}/externals/libressl"
	mv "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" "${S}/externals/libressl" || die
	rmdir "${S}/externals/soundtouch"
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	rmdir "${S}/externals/teakra"
	mv "${WORKDIR}/teakra-${TEAKRA_SHA}" "${S}/externals/teakra" || die
	rmdir "${S}/externals/dynarmic"
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	rmdir "${S}/externals/discord-rpc"
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	rmdir "${S}/externals/cubeb/googletest"
	mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	cmake_src_prepare
}

CMAKE_BUILD_TYPE="Release"
BUILD_SHARED_LIBS="OFF"

src_configure() {
	local mycmakeargs=(
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
		-DENABLE_QT=ON
		-DENABLE_QT_TRANSLATION=OFF
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DENABLE_CUBEB=$(usex cubeb)
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DCOMPILE_WITH_DWARF=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DCITRA_USE_BUNDLED_SDL2=OFF
		-DCITRA_USE_BUNDLED_QT=OFF
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DUSE_SYSTEM_INIH=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect citra update ifunset
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect citra update ifunset
}

src_install() {
	cmake_src_install
	mv "${D}/usr/bin/citra" "${D}/usr/bin/citra-nightly"
	mv "${D}/usr/bin/citra-qt" "${D}/usr/bin/citra-qt-nightly"
	mv "${D}/usr/bin/citra-room" "${D}/usr/bin/citra-room-nightly"
}


