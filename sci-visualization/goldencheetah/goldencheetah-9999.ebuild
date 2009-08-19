# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools

DESCRIPTION="Cycling Performance Software for Linux, Mac OS X, and Windows"
HOMEPAGE="http://goldencheetah.org/"

EGIT_REPO_URI="git://github.com/orangejulius/GoldenCheetah.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=x11-libs/qwt-5
	>=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"



