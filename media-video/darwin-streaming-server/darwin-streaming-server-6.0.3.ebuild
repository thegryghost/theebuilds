# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: darwin-streaming-server-6.0.3.ebuild 2008-06-05 bpkroth $

inherit eutils

MY_P="DarwinStreamingSrvr${PV}-Source"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Darwin Streaming Server allows you to send streaming media across the internet using the industry standard RTP and RTSP protocols."
HOMEPAGE="http://dss.macosforge.org/"
SRC_URI="http://dss.macosforge.org/downloads/${MY_P}.tar"

LICENSE="APSL-2"

[ "${ARCH}" == "amd64" ] && M32="+m32"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ssl ${M32}"

DEPEND="virtual/libc"

RDEPEND="${DEPEND}
	 dev-lang/perl
	 !media-video/darwin-streaming-server-bin
	 ssl? ( dev-perl/Net-SSLeay )"

DEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	#Apply the patch to set proper FHS paths
	cd ${WORKDIR}
	epatch ${FILESDIR}/${P}-gentoo.patch

	# A patch to make things build nicely in linux:
	# http://dss.macosforge.org/trac/ticket/6
	epatch ${FILESDIR}/${P}-linux.patch

	# Apply the patch to allow PPC64 w/ 32bit-UL to build as if it were i686.
	# http://bugs.gentoo.org/show_bug.cgi?id=84011#c36
	# Warning: this is a hack.
	if [ "${ARCH}" == "ppc" ] || [ ${ARCH} == "ppc64" ]; then
		epatch ${FILESDIR}/${P}-ppc64.patch
	fi
	
	# Apply patch to build on x86_64
	# http://dss.macosforge.org/trac/ticket/10
	if [ "${ARCH}" == "amd64" ]; then
		epatch ${FILESDIR}/${P}-x86_64.patch
		if use m32; then
			epatch ${FILESDIR}/${P}-x86_64-m32.patch
		else
			ewarn "This package is currently unstable when builing 64-bit code."
			ewarn "Please consider setting USE=\"m32\" to force 32-bit code."
			ewarn "See: http://dss.macosforge.org/trac/ticket/10"
		fi
	fi
}

src_compile() {
	# run the included build script
	./Buildit || die "Darwin build script failed"
}

src_install() {
	# NOTE: Apple's custom build scripts makes it a real PITA
	# to install to useful and expected locations. Consequently,
	# the built binaries and configuration files are to be moved
	# manually into their respective directories which correspond to
	# the changed locations in the -gentoo.patch.

	# binaries go in here 
	(
		into /usr
		dosbin DarwinStreamingServer
		dobin PlaylistBroadcaster.tproj/PlaylistBroadcaster
		dobin MP3Broadcaster/MP3Broadcaster
		dobin StreamingLoadTool/StreamingLoadTool
		dobin qtpasswd.tproj/qtpasswd
		dobin WebAdmin/src/streamingadminserver.pl
		dobin StreamingProxy.tproj/StreamingProxy
	) || die "failure!"

	# streaming server modules go in here
	keepdir /usr/lib/dss

	# configuration files go in here
	dodir /etc/dss
	insinto /etc/dss
	newins streamingserver.xml-POSIX streamingserver.xml-sample
	newins streamingserver.xml-POSIX streamingserver.xml
	doins relayconfig.xml-Sample
	doins StreamingLoadTool/streamingloadtool.conf
	doins qtusers
	doins qtgroups
	doins qtaccess
	fowners root:nobody /etc/dss/qtusers
	fowners root:nobody /etc/dss/qtgroups
	fperms 0640 /etc/dss/qtusers
	fperms 0640 /etc/dss/qtgroups
	doins WebAdmin/streamingadminserver.conf
	doins StreamingProxy.tproj/streamingproxy.conf
	newins WebAdmin/streamingadminserver.pem streamingadminserver.pem-sample

	# server rc scripts go in here
	insinto /etc/init.d
	newins ${FILESDIR}/dss.rc dss
	newins ${FILESDIR}/dss-admin.rc dss-admin
	fperms +x /etc/init.d/dss
	fperms +x /etc/init.d/dss-admin

	# log files are generated in here
	keepdir /var/log/dss
	fowners nobody:nobody /var/log/dss

	# admin web application goes in here
	dodir /var/lib/dss/admin
	cp -ax WebAdmin/WebAdminHtml/* ${D}/var/lib/dss/admin
	dodir /var/lib/dss/media
	cp -ax sample* ${D}/var/lib/dss/media
	keepdir /var/lib/dss/media/http
	keepdir /var/lib/dss/media/playlists
	fowners nobody:nobody /var/lib/dss/media/playlists

	#Documentation goes in here
	dodoc ReleaseNotes.txt
	dodoc StreamingProxy.tproj/StreamingProxy.html
}

# -gentoo.patch sets up the run_as creds as nobody:nobody
# there's no need to create this user.
#pkg_setup() {
#	einfo "creating qtss group and user"
#	enewgroup qtss 
#	enewuser qtss -1 /dev/null /bin/false "qtss" 
#}

pkg_postinst() {
    # alert user that they need to create an user in the admin group
    # before starting up the server.
    einfo "If you intend on using the web-based admin interface you"
    einfo "need to run 'qtpasswd -A admin <username>' before"
    einfo "starting up the admin server. If you do not plan on"
    einfo "using the admin interface you can just start the Darwin"
    einfo "Streaming Server."
}
