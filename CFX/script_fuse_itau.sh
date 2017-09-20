#!/bin/bash
echo ""
echo "[CFX-REST]"
echo ""
./script_exhandling.sh $1
echo ""
./script_logging.sh $1
echo ""
./script_security.sh $1
echo ""

