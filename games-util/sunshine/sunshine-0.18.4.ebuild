# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake cuda

DESCRIPTION="Gamestream host for Moonlight"
HOMEPAGE="https://github.com/LizardByte/Sunshine"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cuda kms wayland +x11"


NANORS_SHA="395e5ada44dd8d5974eaf6bb6b17f23406e3ca72"
MINIUPNP_SHA="014c9df8ee7a36e5bf85aa619062a2d4b95ec8f6"
TPCIRCULARBUFFER_SHA="8833b3a73fab6530cc51e2063a85cced01714cfb"
VIGEMCLIENT_SHA="9e842ba1c3a6efbb90d9b7e9346a55b1a3d10494"
ENET_SHA="4cde9cc3dcc5c30775a80da1de87f39f98672a31"
MOONLIGHT_COMMON_C_SHA="07beb0f0a520106c49fda7664369b29e6938ea6e"
FFMPEG_LINUX_X86_64_SHA="d8f29a064caabdeb78f263a5017a5dbdaa454eb6"
NV_CODEC_HEADERS_SHA="2055784e5d5bfb3df78d4d3645f345f19062dce2"
SIMPLE_WEB_SERVER_SHA="2f29926dbbcd8a0425064d98c24f37ac50bd0b5b"

SRC_URI="https://github.com/LizardByte/Sunshine/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sleepybishop/nanors/archive/${NANORS_SHA}.tar.gz -> ${PN}-nanors-${NANORS_SHA:0:7}.tar.gz
	https://github.com/miniupnp/miniupnp/archive/${MINIUPNP_SHA}.tar.gz -> ${PN}-miniupnp-${MINIUPNP_SHA:0:7}.tar.gz
	https://github.com/michaeltyson/TPCircularBuffer/archive/${TPCIRCULARBUFFER_SHA}.tar.gz -> ${PN}-TPCircularBuffer-${TPCIRCULARBUFFER_SHA:0:7}.tar.gz
	https://github.com/ViGEm/ViGEmClient/archive/${VIGEMCLIENT_SHA}.tar.gz -> ${PN}-ViGEmClient-${VIGEMCLIENT_SHA:0:7}.tar.gz
	https://github.com/cgutman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/moonlight-stream/moonlight-common-c/archive/${MOONLIGHT_COMMON_C_SHA}.tar.gz -> ${PN}-moonlight-common-c-${MOONLIGHT_COMMON_C_SHA:0:7}.tar.gz
	https://github.com/LizardByte/build-deps/archive/${FFMPEG_LINUX_X86_64_SHA}.tar.gz -> ${PN}-ffmpeg-linux-x86_64-${FFMPEG_LINUX_X86_64_SHA:0:7}.tar.gz
	https://github.com/FFmpeg/nv-codec-headers/archive/${NV_CODEC_HEADERS_SHA}.tar.gz -> ${PN}-nv-codec-headers-${NV_CODEC_HEADERS_SHA:0:7}.tar.gz
	https://gitlab.com/eidheim/Simple-Web-Server/archive/${SIMPLE_WEB_SERVER_SHA}.tar.gz -> ${PN}-Simple-Web-Server-${SIMPLE_WEB_SERVER_SHA:0:7}.tar.gz
"


MY_HASH="0dfbcfdbc4a996fc6431387fd227525e7ec57684"
LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"


RDEPEND="
	dev-libs/boost:=
	net-libs/miniupnpc:=
	dev-libs/openssl:=
	media-video/ffmpeg:=
	>=media-libs/intel-mediasdk-22.3.0
	cuda? ( dev-util/nvidia-cuda-toolkit )
	kms? (
		sys-libs/libcap
		x11-libs/libdrm
	)
	wayland? ( dev-libs/wayland )
	x11? ( x11-libs/libX11 )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Sunshine-${PV}"


src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/third-party/nanors"
	mv "${WORKDIR}/nanors-${NANORS_SHA}" "${S}/third-party/nanors" || die
	rmdir "${S}/third-party/miniupnp"
	mv "${WORKDIR}/miniupnp-${MINIUPNP_SHA}" "${S}/third-party/miniupnp" || die
	rmdir "${S}/third-party/TPCircularBuffer"
	mv "${WORKDIR}/TPCircularBuffer-${TPCIRCULARBUFFER_SHA}" "${S}/third-party/TPCircularBuffer" || die
	rmdir "${S}/third-party/ViGEmClient"
	mv "${WORKDIR}/ViGEmClient-${VIGEMCLIENT_SHA}" "${S}/third-party/ViGEmClient" || die
	rmdir "${S}/third-party/moonlight-common-c"
	mv "${WORKDIR}/moonlight-common-c-${MOONLIGHT_COMMON_C_SHA}" "${S}/third-party/moonlight-common-c" || die
	rmdir "${S}/third-party/ffmpeg-linux-x86_64"
	mv "${WORKDIR}/build-deps-${FFMPEG_LINUX_X86_64_SHA}" "${S}/third-party/ffmpeg-linux-x86_64" || die
	rmdir "${S}/third-party/nv-codec-headers"
	mv "${WORKDIR}/nv-codec-headers-${NV_CODEC_HEADERS_SHA}" "${S}/third-party/nv-codec-headers" || die
	rmdir "${S}/third-party/Simple-Web-Server"
	mv "${WORKDIR}/Simple-Web-Server-${SIMPLE_WEB_SERVER_SHA}" "${S}/third-party/Simple-Web-Server" || die
	rmdir "${S}/third-party/moonlight-common-c/enet"
	mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/third-party/moonlight-common-c/enet" || die
	#sed -e 's/-Werror=uninitialized/#-Werror=uninitialized/g' -i src/CMakeLists.txt
	cmake_src_prepare
}


