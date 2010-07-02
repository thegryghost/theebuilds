# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder XBMC streaming plugin"
ESVN_REPO_URI=${XBMC_ESVN_REPO_URI:-https://xbmc.svn.sourceforge.net/svnroot/xbmc/branches/pvr-testing2/xbmc/pvrclients/vdr-vnsi/vdr-plugin-vnsiserver/}

ESVN_PROJECT=${ESVN_REPO_URI##*/svnroot/}
ESVN_PROJECT=${ESVN_PROJECT%/*}
if [[ ${PV} == "9999" ]] ; then
	inherit subversion autotools
	KEYWORDS=""
else
	inherit autotools
	MY_P=${P/_/-}
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.7.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

src_prepare() {
	vdr-plugin_src_prepare
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
		cd "${S}"
		rm -f configure
		sed -i receiver.c \
                	-e "s:<libsi/section.h>:<vdr/libsi/section.h>:"

	else
		unpack ${A}
		cd "${S}"
	fi
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"
	insinto /etc/vdr/plugins/vnsi-server
	doins vnsi-server/allowed_hosts.conf
	insinto /etc/vdr/plugins/vnsi-server
	doins vnsi-server/noSignal.mpg
	chown vdr:vdr "${D}"/etc/vdr -R
}
