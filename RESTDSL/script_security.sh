#!/bin/bash

mkdir -p -- ./logs/security
		
echo "[FUSE-ITAU] - S E C U R I T Y "  | tee -a logs/log.txt
echo "=============================="  | tee -a logs/log.txt
echo "Inicio: `date +%d/%m/%y_%H:%M:%S`" >> logs/log.txt
		
		echo "RESTDSL-Product-GET" >> logs/log.txt

		echo "TOKEN ENVIADO" >> logs/log.txt
		curl -o - -s -w GET -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImEzck1VZ01Gdjl0UGNsTGE2eUYzekFrZnF1RSIsImtpZCI6ImEzck1VZ01Gdjl0UGNsTGE2eUYzekFrZnF1RSJ9.eyJjbGllbnRfaWQiOiJRWVFnSDJtRjlSWUswIiwic2NvcGUiOiJyZWFkb25seSIsImlzcyI6Imh0dHBzOi8vb2F1dGhkLml0YXUvaWRlbnRpdHkiLCJhdWQiOiJodHRwczovL29hdXRoZC5pdGF1L2lkZW50aXR5L3Jlc291cmNlcyIsImV4cCI6MTUwMTAxNzk3MSwibmJmIjoxNTAxMDE0MzcxfQ.bgP63E5TFLxwYC0FyvdKOANU-mQZkuCkH-mG-JizEdI9VQ9ctnBQTgvH20j5c_a9VdhjT_O3ASsEri_imGfnouSnONXGT24SGiZ5v_Za_Hz-vcqf-P9lgRYqayZAW0FEyxRLQGCyfjZtXS9djHdNvBPZp18sm4WQ5q-8eqFWqdQ96_LDawYcxjjcyDx06KCbLwhfnctC634Fu88PEzz_gt5aIIUEn3yoS3Vfe5WWvHr6rVpHLyJIf09y8sYUFyZKejldBjX0vTlMWSSl0B3Hai4TC635VSiHpH3Nt--n4xrV-w8HLVYq3xWxm3gr2S7cBNfyk4r3X8pP23PVbGYpLg" http://$1:8081/r/api/v1/security/product/123 > logs/security/security_token_retorno.txt 
		
		id=$(grep -c "\"id\" : \"123\"" logs/security/security_token_retorno.txt);
		name=$(grep -c "\"name\" : \"Test\"" logs/security/security_token_retorno.txt);
		desc=$(grep -c "\"desc\" : \"Test Desc\"" logs/security/security_token_retorno.txt);
		quantity=$(grep -c "\"quantity\" : 1000" logs/security/security_token_retorno.txt);
				
		
			if [ "$id"  -eq  1 ] && [ "$name"  -eq  1 ] && [ "$desc"  -eq  1 ] && [ "$quantity"  -eq  1 ]; then
				echo "SUCESSO" >> logs/log.txt
				resultado="SUCESSO"
			
				echo "TOKEN COM ERRO ENVIADO" >> logs/log.txt
				curl -o - -s -w GET -H "Authorization:Bearer TESTE" http://$1:8081/r/api/v1/security/product/123 > logs/security/security_token_falha_retorno.txt
				sucesso=$(grep -c "Invalid Token!" logs/security/security_token_falha_retorno.txt);
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
