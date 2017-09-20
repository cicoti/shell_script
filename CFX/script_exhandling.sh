#!/bin/bash

mkdir -p -- ./logs/exhandling

echo "[FUSE-ITAU] - E X H A N D L I N G "  | tee -a logs/log.txt
echo "=================================="  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt

curl -o - -s -w GET -H "Content-Type:application/json" http://$1:8081/c/api/v1/exhandling/rest/account > logs/exhandling/exhandling_retorno.txt

number=$(grep -o "number" logs/exhandling/exhandling_retorno.txt | wc -l);
branchNr=$(grep -o "branchNr" logs/exhandling/exhandling_retorno.txt | wc -l);
bankNr=$(grep -o "bankNr" logs/exhandling/exhandling_retorno.txt | wc -l);
sucesso=$(($number + $branchNr + $bankNr));

echo "SERVICO ACESSADO" >> logs/log.txt
if [ $sucesso == 12 ]; then
	echo "SUCESSO" >> logs/log.txt
	resultado="SUCESSO"

	curl -o - -s -w GET -H "throwException:true" http://$1:8081/c/api/v1/exhandling/rest/account > logs/exhandling/exhandling_exception_retorno.txt
	
	sucesso=$(grep -c "Test exception thrown!" logs/exhandling/exhandling_exception_retorno.txt);

	echo "CHAMADA DE EXCECAO" >> logs/log.txt
	if [ $sucesso  ==  1 ]; then
		echo "SUCESSO" >> logs/log.txt
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
