#!/bin/bash
which cmake
echo $LIBRARY_LIB
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX $SRC_DIR 
make
make install