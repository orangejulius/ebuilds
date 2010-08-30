# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cvs games

DESCRIPTION="Freespace 2 Source Code Project"
HOMEPAGE="http://scp.indiegames.us/"

ECVS_SERVER="warpcore.org:/home/fs2source/cvsroot"
ECVS_MODULE=${PN}
ECVS_USER="anonymous"
ECVS_PASS="anonymous"

# Pack list: http://www.hard-light.net/forums/index.php/topic,37272.0.html
# Contains improved graphics & audio
MVP="http://fs2source.warpcore.org/mvp368zeta"
SRC_URI="${MVP}/mv_core.zip
	${MVP}/mv_music.zip
	${MVP}/mv_textures.zip
	${MVP}/mv_models.zip
	${MVP}/mv_effects.zip
	${MVP}/mv_cell.zip
	${MVP}/mv_adveffects.zip"

# See COPYING file
LICENSE="Freespace2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=dev-libs/DirectFB-0.9.22
	media-libs/alsa-lib
	>=media-libs/libogg-1.1.2
	>=media-libs/libsdl-1.2.8-r1
	>=media-libs/libvorbis-1.1.0
	media-libs/openal
	virtual/opengl
	|| (
		(
			media-libs/mesa
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
		virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/freespace2

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv readme.txt mediavp.txt

	cvs_src_unpack
}

src_compile() {
	./autogen.sh || die "autogen failed"
	emake -j1 || die "emake failed"
}

src_install() {
	newgamesbin code/${PN}_r ${PN}.bin || die "newgamesbin failed"
	games_make_wrapper ${PN} ${PN}.bin "${dir}"

	insinto "${dir}"
	doins "${WORKDIR}"/*.vp || die "doins vp failed"

	dodoc AUTHORS ChangeLog NEWS README "${WORKDIR}"/*.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "Copy the data files from a Freespace 2 Windows full installation"
	einfo "into ${dir} (can be installed using wine)."
	einfo
	einfo "  Example: cp -r /mnt/winc/Games/FreeSpace2/* ${dir}"
	einfo
	einfo "You can change resolution from (640x480)x16 to (1024x768)x32 if you edit"
	einfo "~/.fs2open/fs2_open.ini (created on the first run). The command is:"
	einfo
	einfo "  sed -i \"s:(640x480)x16:(1024x768)x32:\" ~/.fs2_open/fs2_open.ini"
	einfo
	einfo "The Gentoo forum thread for help is:"
	einfo "http://forums.gentoo.org/viewtopic-p-2977565.html"
	echo
}
