# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

EGIT_REPO_URI="https://android.googlesource.com/platform/external/svox/"

DESCRIPTION="SVOX PicoTTS text-to-speech engine"
HOMEPAGE="https://android.googlesource.com/platform/external/svox/+/master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+pipe"

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/patches")

S="${WORKDIR}/${P}/pico"

src_prepare() {
	use pipe && PATCHES+=("${FILESDIR}/patches/conditional/pipe.patch")
	default
	eautoreconf
}
