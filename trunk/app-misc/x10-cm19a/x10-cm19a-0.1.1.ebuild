EAPI="2"

inherit eutils linux-mod

DESCRIPTION="X10 cm19a usb driver for linux"
HOMEPAGE="http://m.lemays.org/projects/x10-cm19a-linux-driver"
SRC_URI="http://m.lemays.org/projects/x10-cm19a-linux-driver/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT=""
DEPEND="virtual/linux-sources"
RDEPEND=""

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="x10-cm19a(misc:${S})"

src_prepare() {
	sed -i 's/usb_buffer_alloc/usb_alloc_coherent/g' ./drivers/usb/comm/x10-cm19a.c
	sed -i 's/usb_buffer_free/usb_free_coherent/g' ./drivers/usb/comm/x10-cm19a.c
	epatch ${FILESDIR}/fix.patch
}

#pkg_setup() {
#	linux-mod_pkg_setup
#	BUILD_PARAMS="KDIR=${KV_DIR}"
#}

src_install() {
	linux-mod_src_install
}
