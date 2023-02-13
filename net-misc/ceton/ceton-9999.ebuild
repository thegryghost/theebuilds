EAPI=7

#inherit linux-info linux-mod git-r3
#inherit autotools dist-kernel-utils flag-o-matic linux-mod toolchain-funcs git-r3
inherit eutils linux-mod git-r3
#autotools dist-kernel-utils flag-o-matic linux-mod toolchain-funcs git-r3
DESCRIPTION="A linux kernel module for Ceton"
HOMEPAGE="https://github.com/ceton/infinitv_pcie"
EGIT_REPO_URI="https://github.com/ceton/infinitv_pcie.git"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64 ~x86"
MODULE_NAMES="ctn91xx(misc:${S})"
BUILD_TARGETS="ctn91xx"


pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR} KERNEL_VERSION=${KV_FULL}"
}

src_prepare() {
	default
        cd "${S}"
        sed -e 's:KERNEL_VERSION \:=:#KERNEL_VERSION \:=:g' -i Makefile
        sed -e 's:KERNEL_DIR\t\:= :#KERNEL_DIR\t\:= :g' -i Makefile
}


src_compile() {
        cd "${S}"
	ARCH=x86 make ${BUILD_PARAMS}
}

#src_install() {
#        linux-mod_src_install
#        insinto /etc/udev/rules.d/
#        doins 98-ctn91xx.rules
#}
