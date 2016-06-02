#!/bin/bash
cd $SRC_DIR
./configure --prefix=$PREFIX
make
make install