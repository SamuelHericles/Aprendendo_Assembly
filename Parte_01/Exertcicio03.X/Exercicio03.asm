; -Parte 1-        
;   3. Desenvolva um programa que calcule a soma dos 4 bits menos significativos
;      com os 4 bits mais significativos de uma variável de memória de 8 bits.
;      O resultado deve ser armazenado em outra variável.

; nible -> sequência de 4 bits. Ex: 0000 0000 , aqui possui dois nibles    
    
;#########################
; Declaração das variavéis
;#########################
VARIAVEIS UDATA_ACS 0
  a     RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x00
  resp  RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x01    
  nb_1  RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x02    
  nb_2  RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x03    


;#########################
; Início do código
;######################### 
RES_VECT  CODE    0x0000            
    GOTO    START       
    
;===============================================================================
MAIN_PROG CODE                       

TESTE_0		    ; Primeiro teste, testa o bit pos 0
 BTFSS a,0	    ; Verifica se o bit pos 0 tem valor '1'
 GOTO TESTE_1	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000001'  ; Soma a memória '0000 0001'
 GOTO TESTE_1	    ; Se chegou aqui é porque o valor do bit é '1'
 
TESTE_1		    ; Segundo teste, testa o bit pos 0
 BTFSS a,1	    ; Verifica se o bit pos 1 tem valor '1'
 GOTO TESTE_2	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000010'  ; Soma a memória '0000 0010'
 GOTO TESTE_2	    ; Se chegou aqui é porque o valor do bit é '1'

TESTE_2		    ; Terceiro teste, testa o bit pos 0
 BTFSS a,2	    ; Verifica se o bit pos 2 tem valor '1'
 GOTO TESTE_3	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000100'  ; Soma a memória '0000 0100'
 GOTO TESTE_3	    ; Se chegou aqui é porque o valor do bit é '1'
 
TESTE_3		    ; Quarto teste, testa o bit pos 0
 BTFSS a,3	    ; Verifica se o bit pos 3 tem valor '1'
 GOTO Nible_1	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00001000'  ; Soma a memória '0000 1000'
 GOTO Nible_1	    ; Se chegou aqui é porque o valor do bit é '1'

Nible_1		    ; Guarda os resultados dos primeiros quatro teste
    movwf nb_1	    ; Armazena o resulto na variavel nb_1
    movlw .0	    ; 'limpa' a memória
    GOTO TESTE_4    ; Redireciona para o teste 4
 
;===============================================================================
    
TESTE_4		    ; Quinto teste, testa o bit pos 0
 BTFSS a,4	    ; Verifica se o bit pos 4 tem valor '1'
 GOTO TESTE_5	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000001'  ; Soma a memória '0001 0000'
 GOTO TESTE_5	    ; Se chegou aqui é porque o valor do bit é '1'

TESTE_5		    ; Sexto teste, testa o bit pos 0
 BTFSS a,5	    ; Verifica se o bit pos 5 tem valor '1'
 GOTO TESTE_6	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000010'  ; Soma a memória '0010 0000'
 GOTO TESTE_6	    ; Se chegou aqui é porque o valor do bit é '1'

TESTE_6		    ; Sétimo teste, testa o bit pos 0
 BTFSS a,6	    ; Verifica se o bit pos 6 tem valor '1'
 GOTO TESTE_7	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00000100'  ; Soma a memória '0100 0000'
 GOTO TESTE_7	    ; Se chegou aqui é porque o valor do bit é '1'
 
TESTE_7		    ; Oitavo teste, testa o bit pos 0
 BTFSS a,7	    ; Verifica se o bit pos 7 tem valor '1'
 GOTO Nible_2	    ; Se chegou aqui é porque o valor do bit é '0'
 ADDLW b'00001000'  ; Soma a memória '1000 0000'
 GOTO Nible_2	    ; Se chegou aqui é porque o valor do bit é '1'
 
Nible_2		    ; Guarda os resultados dos últimos quatro teste
  movwf nb_2	    ; Armazena o valor da memória na variavel nb_2
  GOTO SOMA	    ; Redireciona para somar os dois nibles
;===============================================================================

START			    ; Início dos testes	
    ; Coloquei essa variavel para testar com todos os bits
    movlw b'11111111' 
    movwf a		    ; Armazena o valor da memoria no registrador		   
    ;clrw -> Não está funcionando(MPLAB Linux, Fedora 31(SO que estou usando))
    movlw .0		    ; Forma para 'limpar' a memória que fiz
    GOTO TESTE_0	    ; Início do primeiro teste


SOMA			    ; Função que soma os dois nibles
    movlw .0		    ; 'limpa' a memória
    movf nb_1,w		    ; Armazena o valor do nb_1 na memória
    addwf nb_2,w	    ; Soma o valor da memória como nb_2 e reinsere em w
    movwf resp		    ; Armazena o valor da soma nb_1+nb_2 na var resp
    GOTO $		    ; Veja o resultado na aba File Registers pos 0x03
			    ; O RESULTADO É EM HEXADECIMAL!!!
END