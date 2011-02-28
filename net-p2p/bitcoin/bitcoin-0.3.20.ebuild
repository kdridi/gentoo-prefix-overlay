EAPI="2"

inherit autotools base

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://bitcoin.sourceforge.net/"
SRC_URI="mirror://sourceforge/bitcoin/${P}-linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-libs/db-2.0
	dev-libs/libjsonspirit
	dev-libs/libcryptopp
	>=x11-libs/wxGTK-2.9.1.1"

src_prepare() {
	cd "${S}/src"

	rm -rf cryptopp json makefile.unix
	cp "${FILESDIR}"/Makefile Makefile

	sed -e 's,#include "json/\(.\+\)"$,#include <\1>,' -i rpc.cpp 

	mkdir -p obj/nogui
}

src_compile () {
	cd "${S}/src"

	emake PREFIX=${EPREFIX} all || die "make failed"
	emake PREFIX=${EPREFIX} bitcoind || die "make failed"
}

src_install() {
	mkdir -p ${ED}usr/bin

	cp src/bitcoin ${ED}usr/bin
	cp src/bitcoind ${ED}usr/bin
}


