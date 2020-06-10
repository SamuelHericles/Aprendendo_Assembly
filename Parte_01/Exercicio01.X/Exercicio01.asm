
; -Parte 1-    
;   1. Desenvolva um programa que calcula a soma dos valores em duas vari�veis 
;      de mem�ria de 16 bits e armazene o resultado em uma terceira vari�vel 
;      tamb�m de 16 bits.   
    
;#########################
; Declara��o das variav�is
;#########################
VARIAVEIS UDATA_ACS 0
  A RES 1		    ; Variavel de tamanho de 8 bits no endere�o 0x00
  B RES 1		    ; Variavel de tamanho de 8 bits no endere�o 0x01
  C RES 2		    ; Variavel de tamanho de 16 bits no endere�o 0x02

;#########################
; In�cio do c�digo
;######################### 
RES_VECT  CODE    0x0000            
    GOTO    START                   

;===============================================================================    
MAIN_PROG CODE                     

START			    ; In�cio dos testes
    MOVLW .50		    ; Move 50 literal para mem�ria
    MOVWF A		    ; Inseri o valor na var W na var A
    MOVWF B		    ; Inseri o valor na var W na var B
    
    ; Soma C = A+B
    MOVF B,W		    ; Move o valor na memoria para o registrador B
    ADDWF A,W		    ; Soma e armazena o resultado na mem�ria
    MOVWF C		    ; Veja o resultado em 0x03 no file registers
    
    GOTO $		    ; Veja o resultado na aba File Registers
    END
;===============================================================================    