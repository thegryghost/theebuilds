EAPI="4"

inherit eutils versionator linux-mod

DESCRIPTION="Realtek USB Card Reader (rts5139) Driver"
HOMEPAGE="http://www.realtek.com"
SRC_URI="http://no_valid_link/rts5139.tar.bz2"

RESTRICT="fetch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/linux-sources"
S="${WORKDIR}/rts5139"

MODULE_NAMES="rts5139(misc:$S)"
BUILD_TARGETS="clean default"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}
