EAPI="5"
SLOT="0"
inherit eutils

DESCRIPTION="transparent and scalable SSL/TLS interception"
HOMEPAGE="https://www.roe.ch/SSLsplit"
SRC_URI="http://mirror.roe.ch/rel/sslsplit/sslsplit-${PV}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
LICENSE="BSD-2"

COMMON_DEPEND="
    >=dev-libs/libevent-2.0.10
	dev-libs/openssl"

DEPEND="${COMMON_DEPEND}
		virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}"


src_compile()
{
	FEATURES="" emake
}


src_install()
{
	FEATURES="" emake PREFIX="${D}/usr/" install
}
