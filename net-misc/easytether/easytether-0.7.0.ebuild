DESCRIPTION=""
HOMEPAGE="http://www.mobile-stream.com/easytether/android.html"

SRC_URI="http://www.mobile-stream.com/beta/easytether-${PV}_i386.deb
         http://www.mobile-stream.com/beta/easytether-${PV}_amd64.deb"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-libs/libusb
	app-arch/deb2targz"

RDEPEND="${DEPEND}"

FILENAME="easytether-${PV}_i386"

src_unpack() {
	if use amd64; then
		FILENAME="easytether-${PV}_amd64"
	fi

	deb2targz ${DISTDIR}/$FILENAME.deb
	unpack $FILENAME.tar.gz
}

src_install() {
	exeinto /usr/bin
	doexe usr/bin/easytether
}

