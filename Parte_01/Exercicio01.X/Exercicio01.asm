
; -Parte 1-    
;   1. Desenvolva um programa que calcula a soma dos valores em duas variáveis 
;      de memória de 16 bits e armazene o resultado em uma terceira variável 
;      também de 16 bits.   
    
;#########################
; Declaração das variavéis
;#########################
VARIAVEIS UDATA_ACS 0
  A RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x00
  B RES 1		    ; Variavel de tamanho de 8 bits no endereço 0x01
  C RES 2		    ; Variavel de tamanho de 16 bits no endereço 0x02

;#########################
; Início do código
;######################### 
RES_VECT  CODE    0x0000            
    GOTO    START                   

;===============================================================================    
MAIN_PROG CODE                     

START			    ; Início dos testes
    MOVLW .50		    ; Move 50 literal para memória
    MOVWF A		    ; Inseri o valor na var W na var A
    MOVWF B		    ; Inseri o valor na var W na var B
    
    ; Soma C = A+B
    MOVF B,W		    ; Move o valor na memoria para o registrador B
    ADDWF A,W		    ; Soma e armazena o resultado na memória
    MOVWF C		    ; Veja o resultado em 0x03 no file registers
    
    GOTO $		    ; Veja o resultado na aba File Registers
    END
;===============================================================================    