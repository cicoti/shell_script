#!/bin/bash

mkdir -p -- ./logs/exhandling

echo "[FUSE-ITAU] - E X H A N D L I N G "  | tee -a logs/log.txt
echo "=================================="  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

curl  -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:"  -d @exhandling_request.xml -o - -s -w POST http://$1:8081/c/api/v1/exhandling/soap/AccountService > logs/exhandling/exhandling_retorno.xml

number=$(grep -o "number" logs/exhandling/exhandling_retorno.xml  | wc -l);
branchNr=$(grep -o "branchNr" logs/exhandling/exhandling_retorno.xml  | wc -l);
bankNr=$(grep -o "bankNr" logs/exhandling/exhandling_retorno.xml  | wc -l);
sucesso=$(($number + $branchNr + $bankNr));

echo "SERVICO ACESSADO" >> logs/log.txt
if [ $sucesso == 24 ]; then
	echo "SUCESSO" >> logs/log.txt
	resultado="SUCESSO"
	
else
	echo "FALHA" >> logs/log.txt
	resultado="FALHA"
fi

echo "Fim: `date +%d-%m-%y_%H:%M:%S`" >> logs/log.txt
echo >> logs/log.txt
echo "Processo finalizado com $resultado"
