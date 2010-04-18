EGIT_REPO_URI="git://git.sukimashita.com/ideviceinstaller.git"
inherit eutils autotools git
SRC_URI=""
KEYWORDS="~x86 ~amd64"

DESCRIPTION="iphone package installer for linux"
HOMEPAGE="http://cgit.sukimashita.com/ideviceinstaller.git/"

SLOT="0"
IUSE=""

DEPEND="dev-util/pkgconfig
        ${RDEPEND}"

RDEPEND=">=app-pda/libplist-1.2
	>=app-pda/libimobiledevice-1.0
	dev-libs/libzip
	sys-fs/fuse"

src_unpack() {
	git_src_unpack
	if use amd64; then
		cd "${S}"
		ls
		sed -e "s:wrote only %d of %d:wrote only %d of %lu:g" -i src/ideviceinstaller.c
	fi
}

src_compile() {
	./autogen.sh --prefix="/usr"
	emake all
}

src_install() {
	make DESTDIR="${D}" install || die
}

