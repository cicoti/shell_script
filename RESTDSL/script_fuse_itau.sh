#!/bin/bash
echo ""
echo "[RESTDSL]"
echo ""
./script_aggregate.sh $1
echo ""
./script_correlation.sh $1
echo ""
./script_exhandling.sh $1
echo ""
./script_logging.sh $1
echo ""
./script_routing.sh $1
echo ""
./script_security.sh $1
echo ""
./script_seda.sh $1
echo ""
