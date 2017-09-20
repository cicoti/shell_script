#!/bin/bash

mkdir -p -- ./logs/seda

echo "[FUSE-ITAU] - S E D A "  | tee -a logs/log.txt
echo "======================"  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/r/api/v1/seda/statement/222/1234 > logs/seda/seda_retorno.txt
 
branch=$(grep -c "Agencia Santo Amaro" logs/seda/seda_retorno.txt); 
statment=$(grep -c "Dysney World LDTA" logs/seda/seda_retorno.txt); 
audited=$(grep -c  "\"audited\" : true" logs/seda/seda_retorno.txt); 

echo "SERVICO ACESSADO" >> logs/log.txt
if [ "$branch" -eq 1 ] && [ "$statment" -eq 1 ]; then
	echo "SUCESSO" >> logs/log.txt
		resultado="SUCESSO"
	else
		echo "FALHA" >> logs/log.txt
		resultado="FALHA"
	fi

if [ "$audited" -eq 1 ]; then
echo "TIMEOUT NAO EXCEDIDO" >> logs/log.txt
	else
echo "TIMEOUT EXCEDIDO" >> logs/log.txt
fi	

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"
