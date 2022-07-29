EAPI="7"

inherit systemd

DESCRIPTION="openNDS"
HOMEPAGE="https://github.com/openNDS/openNDS"
SRC_URI="https://github.com/openNDS/openNDS/archive/refs/tags/v${PV}.tar.gz"

SLOT="0"
LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="net-libs/libmicrohttpd"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	ln -s "openNDS-${PV}" "opennds-${PV}"
}

src_install() {
	mkdir -p "${D}/etc/systemd/system"
	default
	systemd_dounit "${WORKDIR}/opennds-${PV}"/resources/opennds.service
}
