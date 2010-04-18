EGIT_REPO_URI="git://github.com/dgiagio/ipheth.git"
#EGIT_VERSION="199aace5d04684bf4a83cd8548ea0c442d1aa23c"
#EGIT_VERSION="c2d066811addb3f693e42be01131757e880bc0a3"
inherit linux-mod eutils autotools git
SRC_URI=""
KEYWORDS="~x86 ~amd64"

DESCRIPTION="iphone ethernet driver for linux"
HOMEPAGE="http://giagio.com/wiki/moin.cgi/iPhoneEthernetDriver"

SLOT="0"
IUSE=""

DEPEND="dev-util/pkgconfig
        ${RDEPEND}"

RDEPEND=">=app-pda/libplist-1.2
        >=app-pda/libimobiledevice-1.0
        =dev-libs/glib-2*
        dev-libs/libgcrypt
        net-libs/gnutls
        sys-fs/fuse
        dev-python/pyasn1
        dev-python/m2crypto"

MODULE_NAMES="ipheth(misc:${S}/ipheth-driver)"
BUILD_TARGETS="all"

src_unpack() {
	git_src_unpack
	cd ${S}
}

src_install() {
	linux-mod_src_install
}
