DESCRIPTION=""
HOMEPAGE="https://www.speedtest.net/apps/cli"

SRC_URI="https://install.speedtest.net/app/cli/ookla-speedtest-${PV}-linux-i386.tgz
         https://install.speedtest.net/app/cli/ookla-speedtest-${PV}-linux-x86_64.tgz"

SLOT="0"
KEYWORDS="~x86 ~amd64"


src_install() {
	exeinto /usr/bin
	doexe speedtest
	doman speedtest.5
	dodoc speedtest.md
}
