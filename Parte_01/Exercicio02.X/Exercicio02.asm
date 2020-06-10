; -Parte 1-    
;   2. Desenvolva um programa que conte a quantidade de bits '1' existentes no 
;      valor armazenado em uma variável de memória de 8 bits e guarde o resulta-
;      do em outra variável de memória também de 8 bits.    
    
;#########################
; Declaração das variavéis
;#########################
VARIAVEIS UDATA_ACS 0
  a     RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x00
  resp  RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x01
 
;#########################
; Início do código
;#########################  
RES_VECT  CODE    0x0000  
    GOTO    START                   

;===============================================================================		    
MAIN_PROG CODE 
 
TESTE_0		; Teste para o primeiro bit armazenado no registrador
 BTFSS a,0	; Verifica o valor do bit posição 0, se tem valor 0
 GOTO TESTE_1	; Se o valor do bit for '0' pula para o teste 1
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_1	; Se chegou nesta linha é porque o bit tem valor '1'


TESTE_1		; Teste para o segundo bit armazenado no registrador
 BTFSS a,1	; Verifica o valor do bit posição 0, se tem valor 1
 GOTO TESTE_2	; Se o valor do bit for '0' pula para o teste 2
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_2	; Se chegou nesta linha é porque o bit tem valor '1'


TESTE_2		; Teste para o terceito bit armazenado no registrador
 BTFSS a,2	; Verifica o valor do bit posição 0, se tem valor 2
 GOTO TESTE_3	; Se o valor do bit for '0' pula para o teste 3
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_3	; Se chegou nesta linha é porque o bit tem valor '1'


TESTE_3		; Teste para o quarto bit armazenado no registrador
 BTFSS a,3	; Verifica o valor do bit posição 0, se tem valor 3
 GOTO TESTE_4	; Se o valor do bit for '0' pula para o teste 4
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_4	; Se chegou nesta linha é porque o bit tem valor '1'
 

TESTE_4		; Teste para o quinto bit armazenado no registrador
 BTFSS a,4	; Verifica o valor do bit posição 0, se tem valor 4
 GOTO TESTE_5	; Se o valor do bit for '0' pula para o teste 5
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_5	; Se chegou nesta linha é porque o bit tem valor '1'
 
TESTE_5		; Teste para o sexto bit armazenado no registrador
 BTFSS a,5	; Verifica o valor do bit posição 0, se tem valor 5
 GOTO TESTE_6	; Se o valor do bit for '0' pula para o teste 6
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_6	; Se chegou nesta linha é porque o bit tem valor '1'

TESTE_6		; Teste para o sétimo bit armazenado no registrador
 BTFSS a,6	; Verifica o valor do bit posição 0, se tem valor 6
 GOTO TESTE_7	; Se o valor do bit for '0' pula para o teste 7
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO TESTE_7	; Se chegou nesta linha é porque o bit tem valor '1'
 

TESTE_7		; Teste para o oitavo bit armazenado no registrador 
 BTFSS a,7	; Verifica o valor do bit posição 0, se tem valor 7
 GOTO $		; Veja o resultado na aba File Registers no endereço 0x01
 incf resp	; Soma +1 no registrador dee nomeado como 'resp'
 GOTO $		; Veja o resultado na aba File Registers no endereço 0x01
 
;=============================================================================== 
START			; Início dos testes
    ; Coloquei valor boleano para fizar mais facil ver, mas pode ser literal
    movlw b'10110100'	
    movwf a		; Move o valor na memória para o registrador
    GOTO TESTE_0	; Redireciona para o primeiro teste 
END
;===============================================================================

;########################
; Caso queria fazer outros testes
; 00000000
; 00000001
; 00000010    
; 00000011    
; 00000100    
; 00000101
; 00000111    
; 00001000    
; 00001001
; 00001010    
; 00001011    
; 00001100    
; 00001101    
; 00001111    
; ........        