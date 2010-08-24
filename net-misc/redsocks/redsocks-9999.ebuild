EGIT_REPO_URI="http://github.com/darkk/redsocks.git"

inherit eutils autotools git

SRC_URI=""
KEYWORDS="~x86 ~amd64"

DESCRIPTION="redirect any TCP connection to SOCKS or HTTPS proxy"
HOMEPAGE="http://darkk.net.ru/redsocks/"

SLOT="0"
IUSE=""

DEPEND="dev-util/pkgconfig
        ${RDEPEND}"

RDEPEND="dev-libs/libevent
	net-firewall/iptables"

src_install() {
	doexe redsocks
	dodoc README doc/*
	insinto /etc/redsocks
	doins redsocks.conf.example
}
