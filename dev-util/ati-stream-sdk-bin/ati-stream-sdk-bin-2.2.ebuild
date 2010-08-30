# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="Enable compiling code and loading it on ATI/AMD GPU"
HOMEPAGE="http://developer.amd.com/GPU/ATISTREAMSDK/Pages/default.aspx"
SRC_URI="http://developer.amd.com/Downloads/ati-stream-sdk-v${PV}-lnx64.tgz"

# alternatively individual files, but the amd64 package contains both 
# (saves some space for digest)
#
#BASE_URI="http://developer.amd.com/Downloads/ati-stream-sdk-v${PV}"
#SRC_URI="amd64? ( ${BASE_URI}-lnx64.tgz )
#		x86? ( ${BASE_URI}-lnx32.tgz )"

LICENSE="AMD GPL-1 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples doc"
RESTRICT="strip fetch"
RDEPEND="examples? ( media-libs/glew )"

src_install() {
    local DEST=/opt/${PF}
    insinto ${DEST}

    cd ati-stream-sdk-v${PV}-lnx64 || die

    # Install executables
    insopts -m0755
    doins -r bin
    
	# Install libraries

  	doins -r lib
  	
	# There should be something like eselect opencl, to switch
	# between OpenCL implementations  	
    # we use relative symlinks here, as portage recommends

    
    if use amd64; then
        dosym ../..${DEST}/lib/x86_64/libOpenCL.so   /usr/lib64/
        dosym ../..${DEST}/lib/x86/libOpenCL.so      /usr/lib32/
        dosym ../..${DEST}/lib/x86/libatiocl32.so    /usr/lib32/
        dosym ../..${DEST}/lib/x86_64/libatiocl64.so /usr/lib64/
    else
        dosym ../..${DEST}/lib/x86/libOpenCL.so    /usr/lib/
        dosym ../..${DEST}/lib/x86/libatiocl32.so  /usr/lib/
    fi
    
    # Install includes
  	# only selected header; not  glew
	insinto ${DEST}/include
    insopts -m0644
	doins  include/cal*.h
    doins -r include/CL
    doins -r include/GL
    
    # Install examples & docs
    if use examples; then
    	insinto ${DEST}
	    doins -r samples
	fi

    if use doc; then
       	insinto ${DEST}
        doins -r docs
    fi
       
    # Create icd files; we COULD use the tar file from
    # ATI's homepage, yet this seems so unnessecary as
    # those files are VERY simple.
    dodir   /etc/OpenCL/vendors

    if use amd64; then
        echo "libatiocl64.so" > ${D}/etc/OpenCL/vendors/atiocl64.icd
    fi
    echo "libatiocl32.so" > ${D}/etc/OpenCL/vendors/atiocl32.icd

    chmod 644 ${D}/etc/OpenCL/vendors/atiocl??.icd

    # Create env file
    echo "ATISTREAMSDKROOT=${DEST}" > 99${PN}
    doenvd 99${PN}

    # issue info about gpu computing
    elog "REMEMBER: You need to install a recent version of ati-drivers to use your GPU for calculations."
}
