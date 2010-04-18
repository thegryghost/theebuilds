# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vdr-plugin

RESTRICT="nomirror"

DESCRIPTION="Video Disk Recorder Softcam Plugin"
HOMEPAGE="http://vdr.bluox.org"
# SRC_URI="http://vdr.bluox.org/download/vdr-sc/${P}.tar.gz"
SRC_URI="http://207.44.152.197/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE="seca irdeto conax viaccess cryptoworks nagra constcw shl \
      cardclient smartcard vg2 nds nocache au_idle optimize"

DEPEND=">=media-video/vdr-1.5.0
	dev-libs/openssl"

OPT_MODE=${VDRSC_OPT_MODE:-PARALLEL_128_SSE2}
DVB_DIR=${DVB_DIR:-/usr/include}

src_unpack() {
	vdr-plugin_src_unpack

	fix_vdr_libsi_include systems/viaccess/tps.c
 	fix_vdr_libsi_include systems/viaccess/viaccess.c

	sed -i Makefile.system \
	-e "s:^LIBDIR.*$:LIBDIR = ${S}:"

	sed -i Makefile \
	-e "s:/include/vdr/config.h:/config.h:" \
	-e "s:\$(CSAFLAGS):\$(CXXFLAGS):" \
	-e "s:ci.c:ci.h:" \
	-e "s:include/vdr/i18n.h:i18n.h:"

        if use optimize
        then
                epatch ${FILESDIR}/FF_update.patch
                sh configure
                sed -i -e "s:ARCH=\"pentium\":ARCH=\"${MARCH}\":g" configure
        else
                sed -i -e "s:PARALLEL   ?= PARALLEL_32_INT:PARALLEL   ?= ${OPT_MODE}:g" Makefile
        fi

	MARCH=$(get-flag "march")
	M_LEN=`echo ${#MARCH}`
	if [ "$M_LEN" -eq 0 ]; then
		MARCH="native"
	fi
	einfo "Using march=$MARCH"
        sed -i -e "s:CPUOPT     ?= pentium:CPUOPT     ?= ${MARCH}:g" Makefile
        sed -i -e "s:\$(COMPILER) \$(FLAGS) -DPARALLEL_MODE=\$(PARALLEL_MODE) -c:\$(COMPILER) \$(FLAGS) -c:g" FFdecsa/Makefile

	epatch ${FILESDIR}/why_is_this_broken.diff
	epatch ${FILESDIR}/newcamd_test.patch
	#epatch ${FILESDIR}/0.9.1/newcamd_fix.patch
	#epatch ${FILESDIR}/newcamd_force_emm.patch

	if use nocache
	then
		epatch ${FILESDIR}/no_cache.patch
	fi

	if use au_idle
	then
		epatch ${FILESDIR}/0.9.0/au_idle_0.9.0.patch
	fi

	if ! use seca
	then
		einfo "Not using seca"
		rm -rf "${S}"/systems/seca
		rm -rf "${S}"/systems/sc-seca
	fi

	if ! use irdeto
	then
		einfo "Not using irdeto"
		rm -rf "${S}"/systems/irdeto
		rm -rf "${S}"/systems/sc-irdeto
	fi

	if ! use conax
	then
		einfo "Not using conax"
		rm -rf "${S}"/systems/conax
		rm -rf "${S}"/systems/sc-conax
	fi

	if ! use viaccess
	then
		einfo "Not using sc-viaccess"
		rm -rf "${S}"/systems/viaccess
		rm -rf "${S}"/systems/sc-viaccess
	fi

	if ! use cryptoworks
	then
		einfo "Not using cryptoworks"
		rm -rf "${S}"/systems/cryptoworks
		rm -rf "${S}"/systems/sc-cryptoworks
	fi

	if ! use nagra
	then
		einfo "Not using nagra"
		rm -rf "${S}"/systems/nagra
	fi

	if ! use constcw
	then
		einfo "Not using constcw"
		rm -rf "${S}"/systems/constcw
	fi

	if ! use shl
	then
		einfo "Not using shl"
		rm -rf "${S}"/systems/shl
	fi

	if ! use cardclient
	then
		einfo "Not using cardclient"
		rm -rf "${S}"/systems/cardclient
	fi

	if ! use vg2
	then
		einfo "Not using videoguard2"
		rm -rf "${S}"/systems/sc-videoguard2
	fi

	if ! use nds
	then
		einfo "Not using NDS"
		rm -rf "${S}"/systems/nds
	fi
}

src_install() {
	vdr-plugin_src_install

	insinto usr/$(get_libdir)/vdr/plugins
	doins ${S}/libsc*

	diropts -gvdr -ovdr
	keepdir /etc/vdr/plugins/sc
}

