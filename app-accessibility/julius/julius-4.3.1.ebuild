# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MAGIC=60273

inherit eutils

DESCRIPTION="High-performance, two-pass large vocabulary continuous speech recognition"
HOMEPAGE="http://julius.sourceforge.jp/en_index.php"
SRC_URI="mirror://sourceforge.jp/${PN}/${MAGIC}/${P}.tar.gz"

LICENSE="julius"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

LANGS="ja"

DOCS=( 00readme.txt Release.txt )

for LNG in ${LANGS}; do
	IUSE="${IUSE} l10n_${LNG}"
done

DEPEND="
	>=sys-libs/readline-4.1
	media-libs/alsa-lib
	media-libs/libsndfile
	sys-libs/zlib
"
RDEPEND=${DEPEND}

src_install() {
	local l
	for l in ${LINGUAS}; do
		DOCS+=( 00readme-${l}.txt Release-${l}.txt )
	done
	default
}
