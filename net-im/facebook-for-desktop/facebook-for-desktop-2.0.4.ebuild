# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker multilib

DESCRIPTION="Beautiful desktop client for Facebook Messenger. Chat without being distracted by your feed or notifications."
HOMEPAGE="http://messengerfordesktop.com/"
SRC_URI="
	x86? ( https://github.com/Aluxian/Messenger-for-Desktop/releases/download/v2.0.4/messengerfordesktop-2.0.4-linux-i386.deb )
	amd64? ( https://github.com/Aluxian/Messenger-for-Desktop/releases/download/v2.0.4/messengerfordesktop-2.0.4-linux-amd64.deb  )
"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs
		x11-libs/cairo
		x11-libs/gtk+:2
		gnome-base/gconf
		x11-libs/libnotify
		"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	unpack ./data.tar.gz
	rm -v control.tar.gz data.tar.gz debian-binary
}

src_install(){
	insinto ${EPREFIX}/
	doins -r usr
	doins -r opt

	# insinto ${EPREFIX}/usr/share/applications
	# doins usr/share/applications/messengerfordesktop.desktop

	fperms +x ${EPREFIX}/opt/messengerfordesktop/messengerfordesktop

}
