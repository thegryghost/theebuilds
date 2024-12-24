# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 desktop xdg-utils

DESCRIPTION="Chromium fork focused on high performance and security"
HOMEPAGE="https://github.com/Alex313031/Thorium"
SRC_URI="https://github.com/Alex313031/Thorium/releases/download/M${PV}/thorium-browser_${PV}_amd64.zip"

RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="${CDEPEND}
	virtual/opengl
	virtual/ttf-fonts
	x11-misc/xdg-utils
"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
Some web pages may require additional fonts to display properly.
Try installing some of the following packages if some characters
are not displayed properly:
- media-fonts/arphicfonts
- media-fonts/droid
- media-fonts/ipamonafont
- media-fonts/noto
- media-fonts/noto-emoji
- media-fonts/ja-ipafonts
- media-fonts/takao-fonts
- media-fonts/wqy-microhei
- media-fonts/wqy-zenhei

To fix broken icons on the Downloads page, you should install an icon
theme that covers the appropriate MIME types, and configure this as your
GTK+ icon theme.

For native file dialogs in KDE, install kde-apps/kdialog.
"

QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	declare THORIUM_HOME="/opt/thorium-browser"

	dodir ${THORIUM_HOME%/*}

	insinto ${THORIUM_HOME}
		doins -r *

	exeinto ${THORIUM_HOME}
		doexe thorium \
		chrome-sandbox \
		chrome-management-service \
		chrome_crashpad_handler \
		chromedriver \
		thorium_shell \
		*.so

	dosym ${THORIUM_HOME}/thorium /usr/bin/${PN} || die

	#newicon "${D}/opt/thorium-browser/thorium_shell.png" "${PN}.png" || die
	newicon -s 256 "${D}/opt/thorium-browser/product_logo_256.png" "${PN}.png" || die

	# install-xattr doesnt approve using domenu or doins from FILESDIR
	cp  "${D}/opt/thorium-browser/thorium-portable.desktop" "${S}/${PN}.desktop"
	sed -e s#Exec=./thorium-browser#Exec=/opt/thorium-browser/thorium#g -i "${S}/${PN}.desktop"
	sed -e s#Icon=product_logo_256.png#Icon=thorium-browser-bin#g -i "${S}/${PN}.desktop"
	domenu "${S}"/${PN}.desktop

	rm ${D}/opt/thorium-browser/THORIUM-SHELL
	rm ${D}/opt/thorium-browser/THORIUM-PORTABLE
	rm ${D}/opt/thorium-browser/product_logo_*
	rm ${D}/opt/thorium-browser/*.desktop
	rm ${D}/opt/thorium-browser/xdg-settings
	rm ${D}/opt/thorium-browser/xdg-mime

}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

