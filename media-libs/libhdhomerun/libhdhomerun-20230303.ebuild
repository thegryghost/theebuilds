# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

GUI_PN="hdhomerun_config_gui"

DESCRIPTION="SiliconDust HDHomeRun Utilties"
HOMEPAGE="https://www.silicondust.com/support/linux/"
SRC_URI="https://download.silicondust.com/hdhomerun/${PN}_${PV}.tgz
         http://download.silicondust.com/hdhomerun/${GUI_PN}_${PV}.tgz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+gui"

DEPEND="gui? (
                        x11-libs/gtk+:2
                        media-libs/fontconfig
                        media-libs/freetype
                        x11-libs/gdk-pixbuf
                        )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/20190621-use_shared_library.patch"
)

S="${WORKDIR}/${PN}"
S_GUI="${WORKDIR}/$GUI_PN"

src_prepare() {
	default
	# Remove forced optimization from Makefile
	sed -i 's:-O2::' Makefile || die "Was the Makefile changed?"
	if use gui; then
		unpack ${GUI_PN}_${PV}.tgz
	fi
}

src_configure() {
	if use gui; then
		cd $S_GUI
		econf
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" STRIP=:
	if use gui; then
		cd "$S_GUI/src"
		emake
	fi
}

src_install() {
	dobin hdhomerun_config
	dolib.so libhdhomerun.so

	insinto /usr/include/hdhomerun
	doins *.h

	if use gui; then
		dobin "$S_GUI/src/$GUI_PN"
	fi
}
