EAPI="4"

RESTRICT="mirror strip"
inherit vdr-plugin eutils mercurial autotools

DESCRIPTION="VDR plugin: HDHomerun"
SRC_URI=""
EHG_REPO_URI="http://mercurial.intuxication.org/hg/hdhomerun"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=media-video/vdr-1.7.12"

