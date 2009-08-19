# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A software framework for scalable cross-language services
development."
HOMEPAGE="http://incubator.apache.org/thrift/"
SRC_URI="http://developers.facebook.com/thrift/download_thrift.php -> ${P}.tar.gz"

LICENSE="Apache-2.9"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ruby perl"

DEPEND=">=sys-devel/gcc-3.3.5
>=dev-libs/boost-1.34.0
>=sys-devel/autoconf-2.60
dev-libs/libevent
sys-libs/zlib"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-instant-r${PV}"

src_unpack() {
	unpack ${A}
	ewarn ${S}
	cd "${S}"

	./bootstrap
}

src_configure() {
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf \
			$(use_with ruby) \
			$(use_with perl)
	fi
}


src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}


