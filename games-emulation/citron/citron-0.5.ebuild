# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV=${tag_name}

LINKERNSBYPASS_SHA="aa3975893d83ef1bc84c321ec60c65fbf1287887"
CUBEB_SHA="48689ae7a73caeb747953f9ed664dc71d2f918d8"
VULKAN_HEADERS_SHA="234c4b7370a8ea3239a214c9e871e4b17c89f4ab"
TZ_SHA="16ce126a87c5f130cde8b8dce73b38952a19f085"
BREAKPAD_SHA="c89f9dddc793f19910ef06c13e4fd240da4e7a59"
VULKANMEMORYALLOCATOR_SHA="c788c52156f3ef7bc7ab769cb03c110a53ac8fcb"
SDL_SHA="cc016b0046d563287f0aa9f09b958b5e70d43696"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
SPIRV_HEADERS_SHA="c214f6f2d1a7253bb0e9f195c2dc5b0659dc99ef"
VULKAN_UTILITY_LIBRARIES_SHA="fe7a09b13899c5c77d956fa310286f7a7eb2c4ed"
OAKNUT_SHA="94c726ce0338b054eb8cb5ea91de8fe6c19f4392"
SIRIT_SHA="ab75463999f4f3291976b079d42d52ee91eebf3f"
ENET_SHA="657eaf97d9d335917c58484a4a4b5e03838ebd8e"
OPUS_SHA="734aed05d09af3d2690f8cb5aafa97f052746daf"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
SIMPLEINI_SHA="6048871ea9ee0ec24be5bd099d161a10567d7dc2"
TZDB_TO_NX_SHA="97929690234f2b4add36b33657fe3fe09bd57dfd"
CPP_JWT_SHA="4a970bc302d671476122cbc6b43cc89fbf4a96ec"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
VCPKG_SHA="37d46edf0f2024c3d04997a2d432d59278ca1dff"
CPP_HTTPLIB_SHA="39a64fb4e7e42216f14f0ec51ccc5fa85e651432"
DYNARMIC_SHA="ba8192d89078af51ae6f97c9352e3683612cdff1"
DISCORD_RPC_SHA="20cc99aeffa08a4834f156b6ab49ed68618cf94a"
LIBADRENOTOOLS_SHA="8fae8ce254dfc1344527e05301e43f37dea2df80"
FFMPEG_SHA="9c1294eaddb88cb0e044c675ccae059a85fc9c6c"

SRC_URI="https://git.citron-emu.org/Citron/Citron/archive/v0.5-canary-refresh.tar.gz -> ${P}.tar.gz
	https://github.com/bylaws/liblinkernsbypass//archive/${LINKERNSBYPASS_SHA}.tar.gz -> ${PN}-linkernsbypass-${LINKERNSBYPASS_SHA:0:7}.tar.gz
	https://github.com/mozilla/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SHA}.tar.gz -> ${PN}-Vulkan-Headers-${VULKAN_HEADERS_SHA:0:7}.tar.gz
	https://github.com/eggert/tz/archive/${TZ_SHA}.tar.gz -> ${PN}-tz-${TZ_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/breakpad/archive/${BREAKPAD_SHA}.tar.gz -> ${PN}-breakpad-${BREAKPAD_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${VULKANMEMORYALLOCATOR_SHA}.tar.gz -> ${PN}-VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-SDL-${SDL_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-SPIRV-Headers-${SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Utility-Libraries/archive/${VULKAN_UTILITY_LIBRARIES_SHA}.tar.gz -> ${PN}-Vulkan-Utility-Libraries-${VULKAN_UTILITY_LIBRARIES_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/oaknut/archive/${OAKNUT_SHA}.tar.gz -> ${PN}-oaknut-${OAKNUT_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/lsalzman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/xiph/opus/archive/${OPUS_SHA}.tar.gz -> ${PN}-opus-${OPUS_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/brofield/simpleini/archive/${SIMPLEINI_SHA}.tar.gz -> ${PN}-simpleini-${SIMPLEINI_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/archive/${TZDB_TO_NX_SHA}.tar.gz -> ${PN}-tzdb_to_nx-${TZDB_TO_NX_SHA:0:7}.tar.gz
	https://github.com/arun11299/cpp-jwt/archive/${CPP_JWT_SHA}.tar.gz -> ${PN}-cpp-jwt-${CPP_JWT_SHA:0:7}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_CMAKE_SHA}.tar.gz -> ${PN}-sanitizers-cmake-${SANITIZERS_CMAKE_SHA:0:7}.tar.gz
	https://github.com/microsoft/vcpkg/archive/${VCPKG_SHA}.tar.gz -> ${PN}-vcpkg-${VCPKG_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://git.citron-emu.org/Citron/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
	https://github.com/bylaws/libadrenotools/archive/${LIBADRENOTOOLS_SHA}.tar.gz -> ${PN}-libadrenotools-${LIBADRENOTOOLS_SHA:0:7}.tar.gz
	https://github.com/FFmpeg/FFmpeg/archive/${FFMPEG_SHA}.tar.gz -> ${PN}-ffmpeg-${FFMPEG_SHA:0:7}.tar.gz
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord +earlyaccess qt5 qt6"

DEPEND=">=app-arch/lz4-1.8
	app-eselect/eselect-yuzu
	>=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	dev-util/glslang
	dev-build/cmake
	>=dev-libs/libfmt-9.0
	dev-libs/libzip
	dev-libs/hidapi
	net-libs/mbedtls
	media-libs/alsa-lib
	x11-libs/libXext
	dev-libs/openssl
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtmultimedia:5
		dev-qt/qtconcurrent:5
		dev-qt/linguist:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,widgets]
		dev-qt/qtmultimedia:6
	)
	>=media-libs/libsdl2-2.26.4
	>=media-libs/opus-1.3
	>=media-libs/nv-codec-headers-12
	>=sys-libs/zlib-1.2
	>=dev-cpp/nlohmann_json-3.8
	virtual/libusb:="

RDEPEND="${DEPEND}
	app-arch/zstd
	media-libs/vulkan-loader"

BDEPEND="dev-cpp/catch
	dev-cpp/nlohmann_json
	dev-util/vulkan-headers"

S="${WORKDIR}/${PN}"


src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/cubeb"
	if [ -e "${WORKDIR}/cubeb-${CUBEB_SHA}" ]; then
		mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	else
		mv "${WORKDIR}/cubeb" "${S}/externals/cubeb" || die
	fi
	rmdir "${S}/externals/Vulkan-Headers"
	if [ -e "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" ]; then
		mv "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" "${S}/externals/Vulkan-Headers" || die
	else
		mv "${WORKDIR}/Vulkan-Headers" "${S}/externals/Vulkan-Headers" || die
	fi
	rmdir "${S}/externals/breakpad"
	if [ -e "${WORKDIR}/breakpad-${BREAKPAD_SHA}" ]; then
		mv "${WORKDIR}/breakpad-${BREAKPAD_SHA}" "${S}/externals/breakpad" || die
	else
		mv "${WORKDIR}/breakpad" "${S}/externals/breakpad" || die
	fi
	rmdir "${S}/externals/VulkanMemoryAllocator"
	if [ -e "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA}" ]; then
		mv "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA}" "${S}/externals/VulkanMemoryAllocator" || die
	else
		mv "${WORKDIR}/VulkanMemoryAllocator" "${S}/externals/VulkanMemoryAllocator" || die
	fi
	rmdir "${S}/externals/SDL"
	if [ -e "${WORKDIR}/SDL-${SDL_SHA}" ]; then
		mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	else
		mv "${WORKDIR}/SDL" "${S}/externals/SDL" || die
	fi
	rmdir "${S}/externals/mbedtls"
	if [ -e "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" ]; then
		mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	else
		mv "${WORKDIR}/mbedtls" "${S}/externals/mbedtls" || die
	fi
	rmdir "${S}/externals/Vulkan-Utility-Libraries"
	if [ -e "${WORKDIR}/Vulkan-Utility-Libraries-${VULKAN_UTILITY_LIBRARIES_SHA}" ]; then
		mv "${WORKDIR}/Vulkan-Utility-Libraries-${VULKAN_UTILITY_LIBRARIES_SHA}" "${S}/externals/Vulkan-Utility-Libraries" || die
	else
		mv "${WORKDIR}/Vulkan-Utility-Libraries" "${S}/externals/Vulkan-Utility-Libraries" || die
	fi
	rmdir "${S}/externals/oaknut"
	if [ -e "${WORKDIR}/oaknut-${OAKNUT_SHA}" ]; then
		mv "${WORKDIR}/oaknut-${OAKNUT_SHA}" "${S}/externals/oaknut" || die
	else
		mv "${WORKDIR}/oaknut" "${S}/externals/oaknut" || die
	fi
	rmdir "${S}/externals/sirit"
	if [ -e "${WORKDIR}/sirit-${SIRIT_SHA}" ]; then
		mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	else
		mv "${WORKDIR}/sirit" "${S}/externals/sirit" || die
	fi
	rmdir "${S}/externals/enet"
	if [ -e "${WORKDIR}/enet-${ENET_SHA}" ]; then
		mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/externals/enet" || die
	else
		mv "${WORKDIR}/enet" "${S}/externals/enet" || die
	fi
	rmdir "${S}/externals/opus"
	if [ -e "${WORKDIR}/opus-${OPUS_SHA}" ]; then
		mv "${WORKDIR}/opus-${OPUS_SHA}" "${S}/externals/opus" || die
	else
		mv "${WORKDIR}/opus" "${S}/externals/opus" || die
	fi
	rmdir "${S}/externals/xbyak"
	if [ -e "${WORKDIR}/xbyak-${XBYAK_SHA}" ]; then
		mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	else
		mv "${WORKDIR}/xbyak" "${S}/externals/xbyak" || die
	fi
	rmdir "${S}/externals/simpleini"
	if [ -e "${WORKDIR}/simpleini-${SIMPLEINI_SHA}" ]; then
		mv "${WORKDIR}/simpleini-${SIMPLEINI_SHA}" "${S}/externals/simpleini" || die
	else
		mv "${WORKDIR}/simpleini" "${S}/externals/simpleini" || die
	fi
	rmdir "${S}/externals/nx_tzdb/tzdb_to_nx"
	if [ -e "${WORKDIR}/tzdb_to_nx-${TZDB_TO_NX_SHA}" ]; then
		mv "${WORKDIR}/tzdb_to_nx-${TZDB_TO_NX_SHA}" "${S}/externals/nx_tzdb/tzdb_to_nx" || die
	else
		mv "${WORKDIR}/tzdb_to_nx" "${S}/externals/nx_tzdb/tzdb_to_nx" || die
	fi
	rmdir "${S}/externals/cpp-jwt"
	if [ -e "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" ]; then
		mv "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" "${S}/externals/cpp-jwt" || die
	else
		mv "${WORKDIR}/cpp-jwt" "${S}/externals/cpp-jwt" || die
	fi
	rmdir "${S}/externals/vcpkg"
	if [ -e "${WORKDIR}/vcpkg-${VCPKG_SHA}" ]; then
		mv "${WORKDIR}/vcpkg-${VCPKG_SHA}" "${S}/externals/vcpkg" || die
	else
		mv "${WORKDIR}/vcpkg" "${S}/externals/vcpkg" || die
	fi
	rmdir "${S}/externals/cpp-httplib"
	if [ -e "${WORKDIR}/cpp-httplib-${CPP_HTTPLIB_SHA}" ]; then
		mv "${WORKDIR}/cpp-httplib-${CPP_HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	else
		mv "${WORKDIR}/cpp-httplib" "${S}/externals/cpp-httplib" || die
	fi
	rmdir "${S}/externals/dynarmic"
	if [ -e "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" ]; then
		mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	else
		mv "${WORKDIR}/dynarmic" "${S}/externals/dynarmic" || die
	fi
	rmdir "${S}/externals/discord-rpc"
	if [ -e "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" ]; then
		mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	else
		mv "${WORKDIR}/discord-rpc" "${S}/externals/discord-rpc" || die
	fi
	rmdir "${S}/externals/libadrenotools"
	if [ -e "${WORKDIR}/libadrenotools-${LIBADRENOTOOLS_SHA}" ]; then
		mv "${WORKDIR}/libadrenotools-${LIBADRENOTOOLS_SHA}" "${S}/externals/libadrenotools" || die
	else
		mv "${WORKDIR}/libadrenotools" "${S}/externals/libadrenotools" || die
	fi
	rmdir "${S}/externals/ffmpeg/ffmpeg"
	if [ -e "${WORKDIR}/FFmpeg-${FFMPEG_SHA}" ]; then
		mv "${WORKDIR}/FFmpeg-${FFMPEG_SHA}" "${S}/externals/ffmpeg/ffmpeg" || die
	else
		mv "${WORKDIR}/FFmpeg" "${S}/externals/ffmpeg/ffmpeg" || die
	fi
	rmdir "${S}/externals/libadrenotools/lib/linkernsbypass"
	if [ -e "${WORKDIR}/liblinkernsbypass-${LINKERNSBYPASS_SHA}" ]; then
		mv "${WORKDIR}/liblinkernsbypass-${LINKERNSBYPASS_SHA}" "${S}/externals/libadrenotools/lib/linkernsbypass" || die
	else
		mv "${WORKDIR}/liblinkernsbypass" "${S}/externals/libadrenotools/lib/linkernsbypass" || die
	fi
	rmdir "${S}/externals/nx_tzdb/tzdb_to_nx/externals/tz/tz"
	if [ -e "${WORKDIR}/tz-${TZ_SHA}" ]; then
		mv "${WORKDIR}/tz-${TZ_SHA}" "${S}/externals/nx_tzdb/tzdb_to_nx/externals/tz/tz" || die
	else
		mv "${WORKDIR}/tz" "${S}/externals/nx_tzdb/tzdb_to_nx/externals/tz/tz" || die
	fi
	rmdir "${S}/externals/cubeb/googletest"
	if [ -e "${WORKDIR}/googletest-${GOOGLETEST_SHA}" ]; then
		mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	else
		mv "${WORKDIR}/googletest" "${S}/externals/cubeb/googletest" || die
	fi
	rmdir "${S}/externals/sirit/externals/SPIRV-Headers"
	if [ -e "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_SHA}" ]; then
		mv "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_SHA}" "${S}/externals/sirit/externals/SPIRV-Headers" || die
	else
		mv "${WORKDIR}/SPIRV-Headers" "${S}/externals/sirit/externals/SPIRV-Headers" || die
	fi
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	if [ -e "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" ]; then
		mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	else
		mv "${WORKDIR}/sanitizers-cmake" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	fi
	mkdir -p "${S}_build/externals/nx_tzdb/"
		eapply "${FILESDIR}/tz_fix.patch"
	#sed -e 's/-Werror=uninitialized/#-Werror=uninitialized/g' -i src/CMakeLists.txt
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
		-DYUZU_USE_BUNDLED_FFMPEG=ON
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


