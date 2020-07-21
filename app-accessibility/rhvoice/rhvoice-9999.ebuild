# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8,9})

inherit python-any-r1 scons-utils eutils toolchain-funcs multilib git-r3

SRC_URI=""

DESCRIPTION="A speech synthesizer for Russian (and similar) language"
HOMEPAGE="https://github.com/Olga-Yakovleva/RHVoice"
EGIT_REPO_URI="https://github.com/Olga-Yakovleva/RHVoice"
LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="
	${RDEPEND}
	app-accessibility/flite
	dev-libs/libunistring
	dev-libs/expat
	dev-libs/libpcre
	media-sound/sox
	dev-util/scons
"

DOCS=(README.md NEWS doc)

# TODO: multilib support (just in case)

src_compile() {
	escons DESTDIR="${D}" prefix=/usr sysconfdir=/etc libdir="/usr/$(get_libdir)"
}

src_install() {
	escons DESTDIR="${D}" prefix=/usr sysconfdir=/etc libdir="/usr/$(get_libdir)" install
	einstalldocs
	dosym "/usr/bin/sd_${PN}" "/usr/$(get_libdir)/speech-dispatcher-modules/sd_${PN}"
}
