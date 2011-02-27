# Copyright (c) 2009-2010 Satoshi Nakamoto
# Distributed under the MIT/X11 software license, see the accompanying
# file license.txt or http://www.opensource.org/licenses/mit-license.php.

# Default prefix for make install
ifeq ($(PREFIX),)
PREFIX = /usr
endif

INCLUDEPATHS= \
 -I"$(PREFIX)/usr/include" \
 -I"$(PREFIX)/usr/include/wx-2.9" \
 -I"$(PREFIX)/usr/lib/wx/include/gtk2-unicode-2.9"

# for wxWidgets 2.9.1, add -lXxf86vm
WXLIBS= \
 -L"$(PREFIX)/usr/lib" \
 -Wl,-Bdynamic \
   -lwx_baseu-2.9 \
   -lwx_gtk2u_core-2.9 \
   -lwx_gtk2u_html-2.9 \
   -lwx_gtk2u_adv-2.9

# for boost 1.37, add -mt to the boost libraries
LIBS= \
 -L"$(PREFIX)/lib" \
 -Wl,-Bdynamic \
   -lpthread \
   -lcrypto \
   -lboost_program_options-mt \
   -lboost_system-mt \
   -lboost_thread-mt \
   -lboost_filesystem-mt \
   -ldb_cxx \
   -lssl \
   -lcryptopp

DEFS=-D_FILE_OFFSET_BITS=64 -DWXUSINGDLL -D__WXGTK__ -DNOPCH -DFOURWAYSSE2 -DUSE_SSL
CFLAGS=-O2 -Wno-invalid-offsetof -Wformat $(DEBUGFLAGS) $(DEFS) $(INCLUDEPATHS)
HEADERS=headers.h strlcpy.h serialize.h uint256.h util.h key.h bignum.h base58.h \
    script.h db.h net.h irc.h main.h rpc.h uibase.h ui.h noui.h init.h

OBJS= \
    obj/util.o \
    obj/script.o \
    obj/db.o \
    obj/net.o \
    obj/irc.o \
    obj/main.o \
    obj/rpc.o \
    obj/init.o \

all: bitcoin

obj/%.o: %.cpp $(HEADERS)
	g++ -c $(CFLAGS) -DGUI -o $@ $<

obj/sha256.o: sha256.cpp
	g++ -c $(CFLAGS) -msse2 -O3 -march=amdfam10 -o $@ $<

bitcoin: $(OBJS) obj/ui.o obj/uibase.o obj/sha256.o
	g++ $(CFLAGS) -o $@ $^ $(WXLIBS) $(LIBS)


obj/nogui/%.o: %.cpp $(HEADERS)
	g++ -c $(CFLAGS) -o $@ $<

bitcoind: $(OBJS:obj/%=obj/nogui/%) obj/sha256.o
	g++ $(CFLAGS) -o $@ $^ $(LIBS)


clean:
	-rm -f obj/*.o
	-rm -f obj/nogui/*.o
	-rm -f cryptopp/obj/*.o
	-rm -f headers.h.gch
