# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs linux-info

MY_P="${PN}-${PV/_/~}"
PATCHV="1"

DESCRIPTION="Blocks connections from/to hosts listed in a file in peerguardian format using iptables."
HOMEPAGE="http://moblock-deb.sourceforge.net/"
SRC_URI="http://moblock-deb.sourceforge.net/debian/pool/main/m/moblock/${MY_P/-/_}.orig.tar.gz
	http://www.gentoo.org/~dev-zero/distfiles/${PN}-patches-${PV}-${PATCHV}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	net-firewall/iptables"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
CONFIG_CHECK="NETFILTER NETFILTER_XTABLES NETFILTER_XT_TARGET_NFQUEUE IP_NF_IPTABLES IP_NF_FILTER"

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/patches"
	EPATCH_SUFFIX="patch"
	epatch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dosbin moblock
	dodoc Changelog README

	newsbin "${FILESDIR}/${PV}-moblock-update" moblock-update

	newinitd "${FILESDIR}/${PV}-init.d" moblock
	newconfd "${FILESDIR}/${PV}-conf.d" moblock

	keepdir /var/db/moblock
	keepdir /var/cache/moblock
	touch "${D}/var/db/moblock/guarding.p2p"
}

pkg_postinst() {
	elog "Run moblock-update to update your block list."
	elog "You can set moblock to update daily with the command"
	elog "  ln -s /usr/sbin/moblock-update /etc/cron.daily/moblock-update"
	elog "Or weekly with"
	elog "  ln -s /usr/sbin/moblock-update /etc/cron.weekly/moblock-update"
}

pkg_postrm() {
	if ! has_version ${CATEGORY}/${PN} && [[ -d "${ROOT}/var/cache/moblock" ]] ; then
		einfo "Removing leftover cache..."
		rm -rf "${ROOT}/var/cache/moblock"
	fi
}

