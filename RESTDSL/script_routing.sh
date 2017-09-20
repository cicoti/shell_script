#!/bin/bash

mkdir -p -- ./logs/routing

echo "[FUSE-ITAU] - R O U T I N G "  | tee -a logs/log.txt
echo "============================"  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

echo "PARAMETRO PESSOA JURIDICA" >> logs/log.txt

curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/r/api/v1/routing/person/pj/123 > logs/routing/routing_pj_retorno.txt
 
sucesso=$(grep -c "empresa@itau.com.br" logs/routing/routing_pj_retorno.txt); 

if [ "$sucesso"  -eq  1 ]; then
		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi

echo "PARAMETRO PESSOA FISICA" >> logs/log.txt

curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/r/api/v1/routing/person/pf/123 > logs/routing/routing_pf_retorno.txt
 
sucesso=$(grep -c "joao@gmail.com" logs/routing/routing_pf_retorno.txt); 

if [ "$sucesso"  -eq  1 ]; then
		echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"

