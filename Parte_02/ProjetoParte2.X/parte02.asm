; -Parte 2-Gera��o de formas de onda
; Desenvolva um projeto para gerar, em tr�s pinos distintos de entrada e sa�da, 
; as formas de onda apresentadas na Figura 1. A constante T, em microsegundos,
; � definida pela f�rmula:
;				 T=100+100?N
; sendo N o �ltimo d�gito de seu n�mero de matr�cula.    
    
;####################################   
; Importar a biblioteca do pic18F4550    
;####################################
#include "p18f4550.inc"

; Configura��es adicionais    
  CONFIG  FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
  CONFIG  WDT = OFF    ; Watchdog Timer Habilidatado 
  CONFIG  LVP = OFF    ; Single-Supply ICSP Habilitador

;#########################
; Declara��o das variav�is
;#########################
VARIAVEIS UDATA_ACS 0
  CONTA01  RES 1	; Variavel de tamanho de 8 bits no endere�o 0x00 
  CONTA02  RES 1	; Variavel de tamanho de 8 bits no endere�o 0x00
 
RES_VECT  CODE    0x0000 
  GOTO    START          
  
;===============================================================================
MAIN_PROG CODE 
 
START
    MOVLW b'10001111'  ; Configura RB4,RB5 e RB6 como saida, outros com entrada 
    MOVWF TRISD	       ; Move o valor para TRISD que configura as portas no PIC

LOOP		       ; LOOP para gera��o da forma de onda   
    ; 4 - Azul | 5 - Vermelhor | 6 - Verde  
    
    ; 1
    BSF PORTD,4
    BSF PORTD,6
    BCF PORTD,6
    
    ; 2
    CALL ATRASO
    BCF PORTD,4
    BSF PORTD,5
    
    ; 3 
    CALL ATRASO
    BCF PORTD,5
    BSF PORTD,6
    
    ; 4
    CALL ATRASO
    BSF PORTD,4
    BCF PORTD,6
    
    ; 5
    CALL ATRASO 
    BCF PORTD,4
    BSF PORTD,5
    
    ; 6
    CALL ATRASO
    BCF PORTD,5
    BSF PORTD,6
    
    ; 7
    CALL ATRASO
    BSF PORTD,4
    BCF PORTD,6
    
    ; 8
    CALL ATRASO
    BCF PORTD,4
    BCF PORTD,6

    GOTO LOOP       

;===============================================================================    
SUBATRASO		; SubRotina de atraso que usa outro contador
    MOVLW .22		; Adicionar valor 1 na mem�ria
    MOVWF CONTA02	; Move o valor para a variavel CONTA02
    
REPETE_2		; Rotina que decrementa o valor o contador CONTA02
    DECFSZ CONTA02	; Decrementa -1 no contador CONTA02
    GOTO REPETE_2	; Repete a rotina at� que zere o contador CONTA02
    RETURN		; Retorna a rotina principal
    
ATRASO			; Rotina de atraso para gera��o da forma de onda
    MOVLW .9		; insere 1 literal na mem�ria
    MOVWF CONTA01	; Move o registrador o valor em w
    
REPETE			; Rotina chama a subrotina de atraso
    CALL SUBATRASO	; Chama a sub rotina de atraso
    DECFSZ CONTA01	; Subtrai do -1 do contador principal
    GOTO REPETE		; Repete at� que zere o contador principal
    RETURN
    END
;===============================================================================
    
; RESULTADO DESDE PROGRAMA � VISTO NO SOFTWARE PROTEUS!!!!!    
    