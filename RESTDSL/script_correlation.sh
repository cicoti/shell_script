#!/bin/bash

mkdir -p -- ./logs/correlation

echo "[FUSE-ITAU] - C O R R E L A T I O N"  | tee -a logs/log.txt
echo "==================================="  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/r/api/v1/correlation/balance/123/444 > logs/correlation/correlation_retorno.txt

branchId=$(grep -c "branchId" logs/correlation/correlation_retorno.txt); 
accountId=$(grep -c "accountId" logs/correlation/correlation_retorno.txt); 
value=$(grep -c  "value" logs/correlation/correlation_retorno.txt); 

if [ "$branchId" -eq 1 ] && [ "$accountId" -eq 1 ] && [ "$value" -eq 1 ]; then

curl -s -D - -o /dev/null http://$1:8081/r/api/v1/correlation/balance/123/444 > logs/correlation/correlation_header_retorno.txt
 
	sucesso=$(grep -c "Camel-ID" logs/correlation/correlation_header_retorno.txt);

	if [ "$sucesso"  -gt  1 ]; then
		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi
	
else
	echo "FALHA" >> logs/log.txt
	resultado="FALHA"
fi

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"
