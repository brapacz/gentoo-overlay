# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

PYTHON_COMPAT=( python3_4 )
PYTHON_REQ_USE='threads(+)'

inherit bzr gnome2-utils vala python-single-r1 waf-utils

DESCRIPTION="Cloud music integration for your Linux desktop"
HOMEPAGE="https://launchpad.net/nuvola-player"

EBZR_REPO_URI="lp:nuvola-player"
EBZR_REVISION="${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/libgee:0
	dev-libs/json-glib
	net-libs/webkit-gtk:3[gstreamer]
	media-libs/gstreamer:1.0
	media-plugins/gst-plugins-mad:1.0
	dev-libs/libunique:3
	>=net-libs/libsoup-2.34
	x11-libs/gdk-pixbuf[jpeg]
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	dev-vcs/bzr
"

src_unpack() {
	bzr_src_unpack
}

src_prepare() {
	bzr_src_prepare

	# 0 fails the test in configure, so it fails if the code isnt under bzr
	sed -i 's#revision = 0#revision = "0"#' ./nuvolamergejs.py || die

	# Fix build failure by using our own vapi file... I know
	cp -v "${FILESDIR}/libnotify.vapi" "${S}/vapi" || die

	vala_src_prepare --ignore-use
}

src_configure() {
	waf-utils_src_configure --allow-fuzzy-build
}

src_compile() {
	waf-utils_src_install --skip-tests
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
