# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV="mainline-${PV/./-}"

LINKERNSBYPASS_SHA="700fd357b912d6907ae3f9344ac2d8c4b48f262e"
CUBEB_SHA="48689ae7a73caeb747953f9ed664dc71d2f918d8"
VULKAN_HEADERS_SHA="ed857118e243fdc0f3a100f00ac9919e874cfe63"
TZ_SHA="ce4d77644d2793027bb27f095dec7b530edcd947"
VULKANMEMORYALLOCATOR_SHA="9b0fc3e7b02afe97895eb3e945fe800c3a7485ac"
SDL_SHA="031912c4b6c5db80b443f04aa56fec3e4e645153"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
SPIRV_HEADERS_SHA="c214f6f2d1a7253bb0e9f195c2dc5b0659dc99ef"
INIH_SHA="1e80a47dffbda813604f0913e2ad68c7054c14e4"
SIRIT_SHA="ab75463999f4f3291976b079d42d52ee91eebf3f"
ENET_SHA="39a72ab1990014eb399cee9d538fd529df99c6a0"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
TZDB_TO_NX_SHA="212afa2394a74226dcf1b7996a570aae17debb69"
CPP_JWT_SHA="e12ef06218596b52d9b5d6e1639484866a8e7067"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
VCPKG_SHA="cbf56573a987527b39272e88cbdd11389b78c6e4"
CPP_HTTPLIB_SHA="6d963fbe8d415399d65e94db7910bbd22fe3741c"
DYNARMIC_SHA="7da378033a7764f955516f75194856d87bbcd7a5"
DISCORD_RPC_SHA="20cc99aeffa08a4834f156b6ab49ed68618cf94a"
LIBADRENOTOOLS_SHA="5cd3f5c5ceea6d9e9d435ccdd922d9b99e55d10b"

SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/bylaws/liblinkernsbypass//archive/${LINKERNSBYPASS_SHA}.tar.gz -> ${PN}-linkernsbypass-${LINKERNSBYPASS_SHA:0:7}.tar.gz
	https://github.com/mozilla/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SHA}.tar.gz -> ${PN}-Vulkan-Headers-${VULKAN_HEADERS_SHA:0:7}.tar.gz
	https://github.com/eggert/tz/archive/${TZ_SHA}.tar.gz -> ${PN}-tz-${TZ_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${VULKANMEMORYALLOCATOR_SHA}.tar.gz -> ${PN}-VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-SDL-${SDL_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-SPIRV-Headers-${SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/benhoyt/inih/archive/${INIH_SHA}.tar.gz -> ${PN}-inih-${INIH_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/lsalzman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/archive/${TZDB_TO_NX_SHA}.tar.gz -> ${PN}-tzdb_to_nx-${TZDB_TO_NX_SHA:0:7}.tar.gz
	https://github.com/arun11299/cpp-jwt/archive/${CPP_JWT_SHA}.tar.gz -> ${PN}-cpp-jwt-${CPP_JWT_SHA:0:7}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_CMAKE_SHA}.tar.gz -> ${PN}-sanitizers-cmake-${SANITIZERS_CMAKE_SHA:0:7}.tar.gz
	https://github.com/microsoft/vcpkg/archive/${VCPKG_SHA}.tar.gz -> ${PN}-vcpkg-${VCPKG_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/merryhime/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
	https://github.com/bylaws/libadrenotools/archive/${LIBADRENOTOOLS_SHA}.tar.gz -> ${PN}-libadrenotools-${LIBADRENOTOOLS_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/releases/download/220816/220816.zip -> nx_tzdb_220816.zip
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord +earlyaccess"

DEPEND=">=app-arch/lz4-1.8
	app-eselect/eselect-yuzu
	>=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	>=dev-libs/libfmt-9.0
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtconcurrent
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtmultimedia
	>=media-libs/libsdl2-2.26.4
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

S="${WORKDIR}/${PN}-mainline-${MY_PV}"


src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/cubeb"
	mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	rmdir "${S}/externals/Vulkan-Headers"
	mv "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" "${S}/externals/Vulkan-Headers" || die
	rmdir "${S}/externals/VulkanMemoryAllocator"
	mv "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA}" "${S}/externals/VulkanMemoryAllocator" || die
	rmdir "${S}/externals/SDL"
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	rmdir "${S}/externals/mbedtls"
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	rmdir "${S}/externals/inih/inih"
	mv "${WORKDIR}/inih-${INIH_SHA}" "${S}/externals/inih/inih" || die
	rmdir "${S}/externals/sirit"
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	rmdir "${S}/externals/enet"
	mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/externals/enet" || die
	rmdir "${S}/externals/xbyak"
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	rmdir "${S}/externals/nx_tzdb/tzdb_to_nx"
	mv "${WORKDIR}/tzdb_to_nx-${TZDB_TO_NX_SHA}" "${S}/externals/nx_tzdb/tzdb_to_nx" || die
	rmdir "${S}/externals/cpp-jwt"
	mv "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" "${S}/externals/cpp-jwt" || die
	rmdir "${S}/externals/vcpkg"
	mv "${WORKDIR}/vcpkg-${VCPKG_SHA}" "${S}/externals/vcpkg" || die
	rmdir "${S}/externals/cpp-httplib"
	mv "${WORKDIR}/cpp-httplib-${CPP_HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	rmdir "${S}/externals/dynarmic"
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	rmdir "${S}/externals/discord-rpc"
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	rmdir "${S}/externals/libadrenotools"
	mv "${WORKDIR}/libadrenotools-${LIBADRENOTOOLS_SHA}" "${S}/externals/libadrenotools" || die
	rmdir "${S}/externals/libadrenotools/lib/linkernsbypass"
	mv "${WORKDIR}/liblinkernsbypass-${LINKERNSBYPASS_SHA}" "${S}/externals/libadrenotools/lib/linkernsbypass" || die
	rmdir "${S}/externals/nx_tzdb/tzdb_to_nx/externals/tz/tz"
	mv "${WORKDIR}/tz-${TZ_SHA}" "${S}/externals/nx_tzdb/tzdb_to_nx/externals/tz/tz" || die
	rmdir "${S}/externals/cubeb/googletest"
	mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	rmdir "${S}/externals/sirit/externals/SPIRV-Headers"
	mv "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_SHA}" "${S}/externals/sirit/externals/SPIRV-Headers" || die
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	mkdir -p "${S}_build/externals/nx_tzdb/"
	cp "${DISTDIR}/nx_tzdb_220816.zip" "${S}_build/externals/nx_tzdb/220816.zip" || die
	if use earlyaccess; then
		eapply "${FILESDIR}/0.1551/10519.diff"
		eapply "${FILESDIR}/0.1551/11225.diff"
		eapply "${FILESDIR}/0.1551/11385.diff"
		eapply "${FILESDIR}/0.1551/11402.diff"
		eapply "${FILESDIR}/0.1551/11435.diff"
		eapply "${FILESDIR}/0.1551/11436.diff"
		eapply "${FILESDIR}/0.1551/11450.diff"
		eapply "${FILESDIR}/0.1551/11459.diff"
		eapply "${FILESDIR}/0.1551/4042.diff"
	fi
	#sed -e 's/-Werror=uninitialized/#-Werror=uninitialized/g' -i src/CMakeLists.txt
	eapply "${FILESDIR}/fix_tzdb.patch"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DYUZU_USE_QT_WEB_ENGINE=OFF
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=ON
		-DYUZU_TESTS=OFF
	)
        cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf "${D}/usr/include" "${D}/usr/share/cmake" "${D}/usr/lib64"
	mv "${D}/usr/bin/yuzu" "${D}/usr/bin/yuzu-mainline"
	mv "${D}/usr/bin/yuzu-cmd" "${D}/usr/bin/yuzu-cmd-mainline"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect yuzu update ifunset
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect yuzu update ifunset
}

