/**********************************************************************************************************************************************
Projeto:  Desenvolva um volt�metro digital de �nica escala que me�a voltagens entre 0 e 5 volts. A  voltagem
deve ser medida, atrav�s de uma das entradas anal�gicas do microcontrolador, com o conversor A/D e o 
resultado deve ser apresentado num display LCD alfanum�rico.
************************************************************************************************************************************************/

/*************************************************************************
                    Configura��es necess�rias para
                  funcionamento correto do projeto 
**************************************************************************/

#pragma config PBADEN = OFF   // Configurar a sa�da anal�gica do PORTA
#pragma config EBTRB   = OFF   
#define  _XTAL_FREQ 4000000     // Configura o cristal para 4MHz

/*************************************************************************
                           Imports necess�rios
**************************************************************************/

#include <xc.h>
#include "lcd.h"    
#include <stdio.h>

void __interrupt(low_priority) ISR(void); // Fun��o para a��o de interrup��es de baixa prioridade
void mostra_resultado(int resultado);     // Fun��o para exibir o resultado no display LCD
void putch(char data);                            // Fun��o que carrega caracter por caracter para o display LCD
unsigned int resultado;                          // Valor capturado no potenci�metro

int main(void) {
/*************************************************************************
                          Configura��es do PIC18
**************************************************************************/
    
    PORTD = 0;                            // PORTD como sa�da
    TRISD  = 0x00;                       // PORTD como sa�da                                 
    TRISB = 0;                              // PORTB como sa�da
    ADON = 1;                              // Liga conversor A/D    
    ADCON1bits.PCFG = 0b1110; // Configura o RA0 como sendo entrada  anal�gica
    ADCON2bits.ADFM = 1;          // Resultado justificado a direita
    ADCON2bits.ADCS = 0b100;   // Liga o conversor A/D
    PIE1bits.ADIE = 1;                  // Habilita interrup��o do conversor A/D
    GIEH  = 1;                              // Habilita��o global das interrup��es Alta
    GIEL  = 1;                              // Habilita��o global das interrup��es Baixa

/*************************************************************************
                Configura��es iniciais do display LCD
**************************************************************************/    
   
    inicializa_lcd();                     // Inicializa as configura��es no display LCD
    limpa_lcd();                          // Limpar o que estava no display LCD
    resultado = 0;                       // 'Limpa' a mem�ria da variavel

/*************************************************************************
                                Rotina do display
**************************************************************************/    
    while (1) {
        caracter_inicio(1,3);                    // Inicar o primeiro caracter no display LCD        
        ADCON0bits.GO = 1;                    // Inicia a convers�o        
        while(ADCON0bits.DONE == 1); 
        resultado = ADRES;                    // ADRES � o registro que guarda o resultado da convers�o
        mostra_resultado(resultado);      // Exibe o resultado no display LCD
        __delay_ms(50);                          // Atraso em exibir no display LCD
        
    }
}

void mostra_resultado(int resultado){
    printf("%.2f Volts",((5.0*resultado)/1023.0)); // Transformar o valor do resultado em bits para volts
}

void __interrupt(high_priority) ISR(void){
    if(ADIF){
        ADIF = 0;                  // Zerar a flag
        resultado = ADRES; // Capturar o resultado
    }
}

void putch(char data){escreve_lcd(data);}