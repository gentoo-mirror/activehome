# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild is a modified version of ebuild from java overlay.

EAPI="6"
inherit eutils

MY_PN="SweetHome3D"

DESCRIPTION="Sweet Home 3D is a free interior design application."
HOMEPAGE="http://sweethome3d.com/"
SRC_URI="
	amd64? ( mirror://sourceforge/sweethome3d/${MY_PN}-${PV}-linux-x64.tgz )
	x86? ( mirror://sourceforge/sweethome3d/${MY_PN}-${PV}-linux-x86.tgz )
"
LICENSE="GPL-3"
IUSE="+system-java"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	system-java? ( app-eselect/eselect-java )
"

RDEPEND="
	system-java? ( virtual/jre:* )
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	if use system-java && [ ! -f "$JAVA_HOME"/bin/java]; then
		die 'Your Java VM installation is broken. Please, select proper system vm through eselect.'
	fi
}

src_prepare() {
	rm THIRDPARTY-LICENSE-* LICENSE.TXT COPYING.TXT
	if use system-java; then
		rm -rf jre*
		sed -r \
			-e 's@^(exec.*/bin/java)@exec "$JAVA_HOME"/bin/java@' \
			-e 's@:"\$PROGRAM_DIR"/[^/]*/(lib/javaws.jar) @:"$JAVA_HOME"/jre/\1:"$JAVA_HOME"/\1 @' \
			-i SweetHome3D
	fi
	default
}

src_install() {
	dodir /usr/share/sweethome3d
	cp -r "${S}"/* "${D}"/usr/share/sweethome3d/
	dosym /usr/share/sweethome3d/"${MY_PN}" /usr/bin/"${MY_PN}"
	make_desktop_entry "${MY_PN}" "${MY_PN}"
}
