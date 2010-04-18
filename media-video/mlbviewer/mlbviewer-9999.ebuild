inherit eutils autotools subversion
SRC_URI=""
KEYWORDS=""

DESCRIPTION="mlbviewer for linux"
HOMEPAGE="~x86 ~amd64"

ESVN_REPO_URI="https://mlbviewer.svn.sourceforge.net/svnroot/mlbviewer/trunk"
SLOT="0"
IUSE=""


RDEPEND="dev-python/suds
         dev-python/pyxml
         dev-python/simplejson
         media-libs/rtmpdump"

DEPEND="${RDEPEND}"

