#!/bin/bash

mkdir -p -- ./logs/logging

echo "[FUSE-ITAU] - L O G G I N G "  | tee -a logs/log.txt
echo "============================"  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt
 
curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/r/api/v1/logging/person/123 > logs/logging/logging_get_retorno.txt

id=$(grep -c "id" logs/logging/logging_get_retorno.txt); 
name=$(grep -c "name" logs/logging/logging_get_retorno.txt); 
email=$(grep -c  "email" logs/logging/logging_get_retorno.txt); 

echo "SERVICO ACESSADO" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ] && [ "$email" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
		
		curl -o - -s -w GET -H "throwException:true" http://$1:8081/r/api/v1/logging/person/123 > logs/logging/logging_get_exception_retorno.txt
		
		sucesso=$(grep -c "DirectConsumerNotAvailableException" logs/logging/logging_get_exception_retorno.txt); 
		
		echo "EXCECAO LOGADA" >> logs/log.txt
		if [ "$sucesso"  -eq  1 ]; then
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
	
	
	
curl -o - -s -w POST -H "Content-Type:application/json" http://$1:8081/r/api/v1/logging/person -d @logging.json  > logs/logging/logging_post_retorno.txt

echo "RESTDSL-Pessoa-POST"  >> logs/log.txt

id=$(grep -c "id" logs/logging/logging_post_retorno.txt); 
name=$(grep -c "name" logs/logging/logging_post_retorno.txt); 
email=$(grep -c  "email" logs/logging/logging_post_retorno.txt); 

echo "SERVICO ACESSADO" >> logs/log.txt
if [ "$id"  -eq  1 ] && [ "$name" -eq 1 ] && [ "$email" -eq 1 ]; then

		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
		
		curl -o - -s -w POST -H "throwException:true" http://$1:8081/r/api/v1/logging/person -d @logging.json  > logs/logging/logging_post_exception_retorno.txt
		
		sucesso=$(grep -c "DirectConsumerNotAvailableException" logs/logging/logging_post_exception_retorno.txt); 
		
		echo "EXCECAO LOGADA" >> logs/log.txt
		if [ "$sucesso"  -eq  1 ]; then
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
	