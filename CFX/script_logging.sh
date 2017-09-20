#!/bin/bash

mkdir -p -- ./logs/logging

echo "[FUSE-ITAU] - L O G G I N G "  | tee -a logs/log.txt
echo "============================"  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

echo "CXF-REST-Branch-GET"  >> logs/log.txt
 
curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/c/api/v1/logging/rest/branch/123 > logs/logging/logging_get_retorno.txt

id=$(grep -c "id" logs/logging/logging_get_retorno.txt); 
name=$(grep -c "name" logs/logging/logging_get_retorno.txt); 

echo "SERVICO ACESSADO" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
			
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi 
	
	
	
curl -o - -s -w POST -H "Content-Type:application/json" http://$1:8081/c/api/v1/logging/rest/branch -d @logging.json  > logs/logging/logging_post_retorno.txt

echo "RESTDSL-Pessoa-POST"  >> logs/log.txt

id=$(grep -o "id" logs/logging/logging_post_retorno.txt | wc -l); 
name=$(grep -o "name" logs/logging/logging_post_retorno.txt | wc -l); 

echo "SERVICO ACESSADO" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
				
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi 	
	

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"
	