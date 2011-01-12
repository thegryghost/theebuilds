
# Copyright 1999-2010 Warez Incorporated
# Distributed under the terms of the GNU General Public License v2
# $Header: $

RESTRICT="mirror strip"

inherit vdr-plugin mercurial

: ${EHG_REPO_URI:=http://85.17.209.13:6100/sc}

DESCRIPTION="VDR plugin: softcam HG-Version"
HOMEPAGE="http://vdr.bluox.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="seca irdeto conax viaccess cryptoworks nagra constcw
      shl vg2 cardclient nocache optimize nds debug"

DEPEND=">=media-video/vdr-1.4.6
		dev-libs/openssl"

S="${WORKDIR}/sc"

OPT_MODE=${VDRSC_OPT_MODE:-PARALLEL_128_SSE2}
DVB_DIR=${DVB_DIR:-/usr/include}

src_unpack() {
	mercurial_src_unpack
	vdr-plugin_src_unpack all_but_unpack

	fix_vdr_libsi_include systems/viaccess/tps.c
	fix_vdr_libsi_include systems/viaccess/viaccess.c

	cd "${S}"
	mkdir ${S}/include

	sed -i Makefile.system \
		-e "s:^LIBDIR.*$:LIBDIR = ${S}:"

	sed -i Makefile \
		-e "s:/include/vdr/config.h:/config.h:" \
		-e "s:-march=\$(CPUOPT)::" \
		-e "s:\$(CSAFLAGS):\$(CXXFLAGS):" \
		-e "s:ci.c:ci.h:" \
		-e "s:include/vdr/i18n.h:i18n.h:" \
		-e "s:^LIBDIR.*$:LIBDIR = ${S}:" \
		-e "s:^LOCALEDIR.*$:LOCALEDIR = ${S}/include:"

	MARCH=$(get-flag "march")

	M_LEN=`echo ${#MARCH}`
	if [ "$M_LEN" -eq 0 ]; then
		MARCH="native"
	fi
	einfo "Using march=$MARCH"

	sed -i -e "s:PARALLEL   ?= PARALLEL_32_INT:PARALLEL   ?= ${OPT_MODE}:g" Makefile

	epatch ${FILESDIR}/na_emm_upd-0.9.3.patch

	if use nocache
        then
                epatch ${FILESDIR}/no_cache.patch
        fi

	if ! use seca
	then
		einfo "Not using seca"
		rm -rf systems/seca
		rm -rf systems/sc-seca
	fi

	if ! use irdeto
	then
		einfo "Not using irdeto"
		rm -rf systems/irdeto
		rm -rf systems/sc-irdeto
	fi

	if ! use conax
	then
		einfo "Not using conax"
		rm -rf systems/conax
		rm -rf systems/sc-conax
	fi

	if ! use viaccess
	then
		einfo "Not using sc-viaccess"
		rm -rf systems/viaccess
		rm -rf systems/sc-viaccess
	fi

	if ! use cryptoworks
	then
		einfo "Not using cryptoworks"
		rm -rf systems/cryptoworks
		rm -rf systems/sc-cryptoworks
	fi

	if ! use nagra
	then
		einfo "Not using nagra"
		rm -rf systems/nagra
		rm -rf systems/sc-nagra
	fi

	if ! use constcw
	then
		einfo "Not using constcw"
		rm -rf systems/constcw
	fi

	if ! use shl
	then
		einfo "Not using shl"
		rm -rf systems/shl
	fi

	if ! use cardclient
	then
		einfo "Not using cardclient"
		rm -rf systems/cardclient
	fi

	if ! use vg2
	then
		einfo "Not using VideoGuard2"
		rm -rf systems/sc-videoguard2
	fi

	if ! use nds
	then
		einfo "Not using NDS"
		rm -rf systems/nds
	fi
}

src_compile() {
	make -j1
}

src_install() {
	vdr-plugin_src_install

	insinto /usr/$(get_libdir)/vdr/plugins
	doins "${S}"/libsc*

	insinto /usr/include/vdr
	cp -r "${S}"/include/* "${D}"/usr/include/vdr

	diropts -gvdr -ovdr
	keepdir /etc/vdr/plugins/sc
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "This software might be illegal in some countries or violate"
	elog "rules of your DVB provider"
	elog "Please respect these rules."
	echo
	elog "We do not offer support of any kind"
	elog "Asking for keys or for installation help will be is ignored by gentoo developers!"
	echo
}
