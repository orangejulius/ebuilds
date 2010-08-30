# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils games

DESCRIPTION="FreeSpace2 - The Source Code Project"
HOMEPAGE="http://scp.indiegames.us/"
SRC_URI="http://icculus.org/~taylor/fso/releases/${P}.tar.bz2"

#LICENSE="FS2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug mve"

RDEPEND="virtual/x11
	media-libs/libsdl
	media-libs/openal
	virtual/opengl"

src_unpack() {
	unpack ${A}

	# configure
	cd ${S}

	econf
}

src_compile() {
	emake || die "make error"
}

src_install() {
	dir=${GAMES_PREFIX_OPT}/${PN}

	dodir ${dir}
	exeinto ${dir}
	docinto ${dir}

	doexe code/fs2_open_r
	dodoc README AUTHORS ChangeLog NEWS INSTALL
	games_make_wrapper fs2open ./fs2_open_r ${dir}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Copy the data files from a FreeSpace2 Windows full installation"
	einfo "into ${dir}"
	einfo " Example: cp -r /mnt/winc/Games/FreeSpace2/* ${dir}"
	echo
	einfo "You can change resolution from (640x480)x16 to (1024x768)x32 if you edit"
	einfo " ~/.fs2open/fs2_open.ini (created on the first run)"
}
