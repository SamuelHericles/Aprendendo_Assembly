/**********************************************************************************************************************************************
Projeto:  Desenvolva um voltímetro digital de única escala que meça voltagens entre 0 e 5 volts. A  voltagem
deve ser medida, através de uma das entradas analógicas do microcontrolador, com o conversor A/D e o 
resultado deve ser apresentado num display LCD alfanumérico.
************************************************************************************************************************************************/

/*************************************************************************
                    Configurações necessárias para
                  funcionamento correto do projeto 
**************************************************************************/

#pragma config PBADEN = OFF   // Configurar a saída analógica do PORTA
#pragma config EBTRB   = OFF   
#define  _XTAL_FREQ 4000000     // Configura o cristal para 4MHz

/*************************************************************************
                           Imports necessários
**************************************************************************/

#include <xc.h>
#include "lcd.h"    
#include <stdio.h>

void __interrupt(low_priority) ISR(void); // Função para ação de interrupções de baixa prioridade
void mostra_resultado(int resultado);     // Função para exibir o resultado no display LCD
void putch(char data);                            // Função que carrega caracter por caracter para o display LCD
unsigned int resultado;                          // Valor capturado no potenciômetro

int main(void) {
/*************************************************************************
                          Configurações do PIC18
**************************************************************************/
    
    PORTD = 0;                            // PORTD como saída
    TRISD  = 0x00;                       // PORTD como saída                                 
    TRISB = 0;                              // PORTB como saída
    ADON = 1;                              // Liga conversor A/D    
    ADCON1bits.PCFG = 0b1110; // Configura o RA0 como sendo entrada  analógica
    ADCON2bits.ADFM = 1;          // Resultado justificado a direita
    ADCON2bits.ADCS = 0b100;   // Liga o conversor A/D
    PIE1bits.ADIE = 1;                  // Habilita interrupção do conversor A/D
    GIEH  = 1;                              // Habilitação global das interrupções Alta
    GIEL  = 1;                              // Habilitação global das interrupções Baixa

/*************************************************************************
                Configurações iniciais do display LCD
**************************************************************************/    
   
    inicializa_lcd();                     // Inicializa as configurações no display LCD
    limpa_lcd();                          // Limpar o que estava no display LCD
    resultado = 0;                       // 'Limpa' a memória da variavel

/*************************************************************************
                                Rotina do display
**************************************************************************/    
    while (1) {
        caracter_inicio(1,3);                    // Inicar o primeiro caracter no display LCD        
        ADCON0bits.GO = 1;                    // Inicia a conversão        
        while(ADCON0bits.DONE == 1); 
        resultado = ADRES;                    // ADRES é o registro que guarda o resultado da conversão
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