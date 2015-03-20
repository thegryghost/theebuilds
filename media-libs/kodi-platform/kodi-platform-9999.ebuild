EAPI="5"

if [[ ${PV} == 9999* ]]; then
    EGIT_REPO_URI="git://github.com/xbmc/kodi-platform"
    inherit autotools git-r3
fi

inherit eutils cmake-utils autotools

DESCRIPTION="kodi-platform dev library"
HOMEPAGE="https://github.com/xbmc/kodi-platform"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"

RDEPEND=">=media-tv/kodi-14.1"
DEPEND="${RDEPEND}"
