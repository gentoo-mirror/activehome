# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A speech synthesizer for Russian (and similar) language"
HOMEPAGE="https://github.com/Olga-Yakovleva/RHVoice"
EGIT_REPO_URI="https://github.com/Olga-Yakovleva/RHVoice"
EGIT_SUBMODULES=(
	'*'
	-src/third-party/cldr
	-external/libs/boost/libs/'*'
	-bin/msi
)
LICENSE="mage? ( GPL-3 ) !mage? ( LGPL-2.1 )"
SLOT="0"

IUSE="ao +client +data +mage pulseaudio portaudio +server +speech-dispatcher +testapp +utils"

RDEPEND="
	dev-cpp/glibmm
	dev-cpp/tclap
	dev-libs/dbus-glib
	dev-libs/glib
	dev-libs/libsigc++
	ao? ( media-libs/libao )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="
	${RDEPEND}
"

DOCS=(README.md doc)

src_prepare() {
	sed -r \
		-e '/pkg_check.*dbus\)/s@dbus@dbus-1@' \
		-i src/{,bin/}CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DENABLE_MAGE=$(usex mage ON OFF)"
		"-DWITH_DATA=$(usex data ON OFF)"
		"-DWITH_LIBAO=$(usex ao ON OFF)"
		"-DWITH_PULSE=$(usex pulseaudio ON OFF)"
		"-DWITH_PORTAUDIO=$(usex portaudio ON OFF)"

		"-DBUILD_CLIENT=$(usex client ON OFF)"
		"-DBUILD_SERVICE=$(usex server ON OFF)"
		"-DBUILD_SPEECHDISPATCHER_MODULE=$(usex speech-dispatcher ON OFF)"
		"-DBUILD_TESTS=$(usex testapp ON OFF)"
		"-DBUILD_UTILS=$(usex utils ON OFF)"

		#"-DWITH_CLI11=ON"

		"-Denable_xp_compat=OFF"
		"-Dcommon_doc_dir=/usr/share/doc/${PF}" \
		"-DSPEECH_DISPATCHER_MODULES_DIR=/usr/$(get_libdir)/speech-dispatcher-modules"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
