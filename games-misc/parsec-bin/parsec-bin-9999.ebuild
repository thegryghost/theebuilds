EAPI=7


inherit desktop pax-utils unpacker xdg-utils

DESCRIPTION=""
HOMEPAGE="http://www.mobile-stream.com/easytether/android.html"

SRC_URI="https://builds.parsecgaming.com/package/parsec-linux.deb"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/deb2targz"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	doicon usr/share/icons/hicolor/256x256/apps/parsecd.png
	domenu usr/share/applications/parsecd.desktop

	exeinto /usr/bin
	doexe usr/bin/parsecd

	insinto usr/share
	doins -r usr/share/parsec
	fperms -w /usr/share/parsec/skel/parsecd-150-28.so
}

