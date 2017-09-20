#!/bin/bash

mkdir -p -- ./logs/aggregate

echo "[FUSE-ITAU] - A G G R E G A T E"  | tee -a logs/log.txt
echo "==============================="  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`"  >> logs/log.txt

curl -o - -s -w POST -H "Content-Type:application/json" http://$1:8081/r/api/v1/aggregate/transf -d @aggregate.json  > logs/aggregate/aggregate_retorno.txt
	
sucesso=$(grep -P "SUCCESS" logs/aggregate/aggregate_retorno.txt);
falha=$(grep -P "FAILURE" logs/aggregate/aggregate_retorno.txt);

resultado="FALHA";

if [ "$sucesso" != "" ]; then
	echo "SUCESSO" >> logs/log.txt
	resultado="SUCESSO"
fi

if [ "$falha" != "" ]; then
	echo "FALHA" >> logs/log.txt
	resultado="FALHA"
fi

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"
