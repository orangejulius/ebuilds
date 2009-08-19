# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git qt4

DESCRIPTION="Cycling Performance Software for Linux, Mac OS X, and Windows"
HOMEPAGE="http://goldencheetah.org/"

EGIT_REPO_URI="git://github.com/orangejulius/GoldenCheetah.git"
EGIT_PROJECT="goldencheetah"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=x11-libs/qwt-5
	>=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}
src_compile () {
	cd "${S}/src"
	eqmake4 GoldenCheetah.pro

	emake || die "emake failed"
}

src_install () {
cd "${S}/src"
dobin GoldenCheetah
}
