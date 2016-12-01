#COPTS		= -g -Wall
COPTS		= -O3 -Wall -DLASZIPDLL_EXPORTS=1 -DUNORDERED=1 --std=c++11
COMPILER	= g++
LINKER		= g++
#BITS		= -64

#LIBS		= -L/usr/lib32
LIBS		= -L/usr/lib -L/opt/homebrew/lib -L/usr/local/lib
INCLUDE		= -I/usr/include -I/opt/homebrew/include

LAZLIBS		=
POTREELIBS      = -lboost_regex -lboost_program_options -lboost_exception -lboost_filesystem -lboost_system

LAZINCLUDE	= -I./LASzip
POTREEINCLUDE   = -I./PotreeConverter/include -I./PotreeConverter/lib/rapidjson/include

LAZOBJS		= ./LASzip/laszip.o ./LASzip/laszipper.o ./LASzip/lasunzipper.o ./LASzip/lasreadpoint.o ./LASzip/lasreaditemcompressed_v1.o ./LASzip/lasreaditemcompressed_v2.o ./LASzip/laswritepoint.o  ./LASzip/laswriteitemcompressed_v1.o ./LASzip/laswriteitemcompressed_v2.o ./LASzip/integercompressor.o ./LASzip/arithmeticdecoder.o ./LASzip/arithmeticencoder.o ./LASzip/arithmeticmodel.o ./LASzip/lasquadtree.o ./LASzip/lasindex.o ./LASzip/lasinterval.o ./LASzip/laszip_dll.o
POTREEOBJS      = ./PotreeConverter/src/BINPointReader.o \
	./PotreeConverter/src/GridCell.o \
	./PotreeConverter/src/LASPointReader.o \
	./PotreeConverter/src/LASPointWriter.o \
	./PotreeConverter/src/PTXPointReader.o \
	./PotreeConverter/src/PointAttributes.o \
	./PotreeConverter/src/PotreeConverter.o \
	./PotreeConverter/src/PotreeWriter.o \
	./PotreeConverter/src/SparseGrid.o \
	./PotreeConverter/src/main.o \
	./PotreeConverter/src/stuff.o

all: converter

converter: ${LAZOBJS} ${POTREEOBJS}
	${LINKER} ${BITS} ${COPTS} ${LAZOBJS} ${POTREEOBJS} -o $@ ${LIBS} ${LAZLIBS} ${POTREELIBS} $(INCLUDE) $(LAZINCLUDE) $(POTREEINCLUDE)

.cpp.o: 
	${COMPILER} ${BITS} -c ${COPTS} ${INCLUDE} $(LAZINCLUDE) $(POTREEINCLUDE) $< -o $@

.c.o: 
	${COMPILER} ${BITS} -c ${COPTS} ${INCLUDE} $(LAZINCLUDE) $(POTREEINCLUDE)  $< -o $@

clean:
	-rm -rf ${LAZOBJS} ${POTREEOBJS}
	-rm -rf converter
