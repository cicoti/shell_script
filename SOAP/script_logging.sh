#!/bin/bash

mkdir -p -- ./logs/logging

echo "[FUSE-ITAU] - L O G G I N G "  | tee -a logs/log.txt
echo "============================"  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt


curl  -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:"  -d @logging_create_request.xml -o - -s -w POST http://$1:8081/c/api/v1/logging/soap/BranchDetailsService > logs/logging/logging_create_retorno.xml

id=$(grep -c "id" logs/logging/logging_create_retorno.xml); 
name=$(grep -c "name" logs/logging/logging_create_retorno.xml); 

echo "SERVICO CREATE" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
			
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
fi 


curl  -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:"  -d @logging_get_request.xml -o - -s -w POST http://$1:8081/c/api/v1/logging/soap/BranchDetailsService > logs/logging/logging_get_retorno.xml

id=$(grep -c "id" logs/logging/logging_get_retorno.xml); 
name=$(grep -c "name" logs/logging/logging_get_retorno.xml);
retorno=$(grep -c "Agencia ABC" logs/logging/logging_get_retorno.xml);

echo "SERVICO GET" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ] && [ "$retorno" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
			
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
fi 

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"