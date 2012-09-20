# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod eutils multilib versionator linux-info

S="${WORKDIR}/${PN}_${PV}"

DESCRIPTION="AVLD is a V4L dummy video device base built to simulate an input video device like a webcam or a video capture card."
HOMEPAGE="http://allonlinux.free.fr/Projets/AVLD/"
SRC_URI="http://allonlinux.free.fr/Projets/AVLD/src/${PN}_${PV}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="avld(video:)"
BUILD_TARGETS="all"

DEPEND=">=sys-kernel/linux-headers-2.6.36.1"
RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	cd ${S}
#	epatch ${FILESDIR}/makefile.patch
	epatch ${FILESDIR}/avld_0.1.4.patch
	epatch ${FILESDIR}/bad.patch
	sed -i 's/<linux\/\(videodev.h\)>/"libv4l1-\1"/' video_device.c
	sed -i '347,350d;358,361d' video_device.c
	cp ${FILESDIR}/libv4l1-videodev.h .
	sed -e "22a#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)" -e "22a#include <linux/module.h>\n#endif" -i video_device.c
}

pkg_setup() {
	ABI=${KERNEL_ABI}
	set_arch_to_kernel
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
}


src_install() {
	linux-mod_src_install

	dodoc README Changelog
	insinto /usr/share/doc/${PF}
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst

	echo
	einfo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	einfo "Using:"
	einfo "# modprobe avld width=640 height=480 fps=25"
	einfo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
}
