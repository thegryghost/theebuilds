# Copyright 2020 Leorize
#
# Licensed under the ISC license. For more information, please refer to the
# "license" file, included in this distribution.

EAPI=7

inherit git-r3 systemd

DESCRIPTION="The sqm-scripts traffic shaper from the CeroWrt project."
HOMEPAGE="https://github.com/tohojo/sqm-scripts"
KEYWORDS=""
SLOT=0
LICENSE="GPL-2"
IUSE=""
EGIT_REPO_URI="$HOMEPAGE"

RDEPEND="sys-apps/iproute2"

src_install() {
	emake install DESTDIR="$ED" PREFIX="/usr" \
	UNITDIR="$(systemd_get_systemunitdir)"
}
