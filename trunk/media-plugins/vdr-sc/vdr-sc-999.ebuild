# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils mercurial flag-o-matic versionator vdr-plugin

EHG_REPO_URI="http://85.17.209.13:6100/sc"
#EHG_REVISION="641db65ec8ac" #<< works with updating the card

DESCRIPTION="vdr-sc from the hg repo"
HOMEPAGE="http://85.17.209.13:6100/sc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="seca irdeto conax viaccess cryptoworks nagra constcw
      shl vg2 cardclient nocache optimize nds iks debug old_card"

RESTRICT="strip"

OPT_MODE=${VDRSC_OPT_MODE:-PARALLEL_128_SSE2}
DVB_DIR=${DVB_DIR:-/usr/include}


pkg_setup() {
	vdr-plugin_pkg_setup
	use debug && append-flags -g
}


src_unpack() {
	if use iks
	then
		EHG_REVISION="86d76957aad5" # <--- IKS
	else
		if use old_card; then
				EHG_REVISION="641db65ec8ac" #<< works with updating the card
		else
			EHG_REVISION="fa524a3311c8" #<< works with updating the card
		fi
	fi

        mercurial_src_unpack

	cd ${WORKDIR}
	ln -s sc sc-${PV}

	cd ${WORKDIR}/sc-${PV}

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


	MARCH=$(get-flag "march")

	M_LEN=`echo ${#MARCH}`
	if [ "$M_LEN" -eq 0 ]; then
		MARCH="native"
	fi
	einfo "Using march=$MARCH"

	if use optimize
	then
		epatch ${FILESDIR}/FF_update.patch
		sh configure
		sed -i -e "s:ARCH=\"pentium\":ARCH=\"${MARCH}\":g" configure
	else
		sed -i -e "s:PARALLEL   ?= PARALLEL_32_INT:PARALLEL   ?= ${OPT_MODE}:g" Makefile
	fi

	sed -i -e "s:CPUOPT     ?= pentium:CPUOPT     ?= ${MARCH}:g" Makefile
	sed -i -e "s:\$(COMPILER) \$(FLAGS) -DPARALLEL_MODE=\$(PARALLEL_MODE) -c:\$(COMPILER) \$(FLAGS) -c:g" FFdecsa/Makefile

	epatch ${FILESDIR}/why_is_this_broken.diff

	if [ "$EHG_REVISION" = "641db65ec8ac" ]; then
		epatch ${FILESDIR}/newcamd_test.patch
	elif use iks; then
		epatch ${FILESDIR}/sc_iks-public.diff
	fi

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

src_install() {
	vdr-plugin_src_install

	insinto usr/$(get_libdir)/vdr/plugins
	doins ${S}/libsc*

	diropts -gvdr -ovdr
	keepdir /etc/vdr/plugins/sc

	einfo "To AU keys while scanning for EPG, set PrestartAU=1"
}
