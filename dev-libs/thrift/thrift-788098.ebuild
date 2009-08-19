# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A software framework for scalable cross-language services
development."
HOMEPAGE="http://incubator.apache.org/thrift/"
SRC_URI="http://gitweb.thrift-rpc.org/?p=thrift.git;a=snapshot;h=a79d33b6ea57d9a54956b36428630883f9efe5dc;sf=tgz -> ${P}.tar.gz"

LICENSE="Apache-2.9"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ruby perl java"

DEPEND=">=sys-devel/gcc-3.3.5
>=dev-libs/boost-1.34.0
>=sys-devel/autoconf-2.60
dev-libs/libevent
sys-libs/zlib"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	ewarn ${S}
	cd "${S}"

	./bootstrap.sh
}

src_configure() {
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf \
			$(use_with ruby) \
			$(use_with perl) \
			$(use_with java)
	fi
}


src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}


