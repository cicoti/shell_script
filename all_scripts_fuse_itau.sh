#!/bin/bash
echo ""
echo "* * * A L L  S C R I P T S  F U S E  I T A U * * *"
echo ""
cd RESTDSL
./script_fuse_itau.sh $1

cd ..
cd CFX
echo ""
./script_fuse_itau.sh $1

cd ..

cd SOAP
echo ""
./script_fuse_itau.sh $1

cd ..