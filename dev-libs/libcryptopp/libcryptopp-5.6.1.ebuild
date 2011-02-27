EAPI="3"
PYTHON_DEPEND="python? 2"

inherit eutils

MY_PV=${PV/_p*}
MY_P=${PN}-${MY_PV}
PLEVEL=${PV/*p}
DESCRIPTION="Crypto++ Library is a free C++ class library of cryptographic schemes."
HOMEPAGE="http://www.cryptopp.com"
SRC_URI="http://www.cryptopp.com/cryptopp561.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	sed -i GNUmakefile \
		-e 's,cryptest.exe,cryptest,g' \
		-e 's,^# CXXFLAGS += -fPIC,CXXFLAGS += -fPIC,' \
		-e 's,*\.a,libcryptopp.a,' \
		-e 's,*\.so,libcryptopp.so,' \
		-e 's,*\.exe,cryptest,'

	einfo ">>> PV ${PV}"
	einfo ">>> P  ${P}"
	einfo ">>> PN ${PN}"
	einfo ">>> A  ${A}"
	einfo ">>> S  ${S}"
}

src_configure() {
	emake all
	emake libcryptopp.so
}

src_install() {
	make PREFIX=${WORKDIR}/../image${EPREFIX}/usr install
	cd ${WORKDIR}/../image${EPREFIX}/usr/lib

	mv libcryptopp.a ${P}.a
	ln -sf ${P}.a ${PN}.a

	mv libcryptopp.so ${P}.so
	ln -sf ${P}.so ${PN}.so
}
