/**********************************************************************************************************************************************
Projeto: O cronômetro inicia com a contagem parada em 60 minutos podendo ser configurada, em incrementos
de 10 minutos, a cada acionamento de um dos dois botões disponíveis. A contagem inicia ao acionamento 
do outro botão e, uma vez iniciada, não poderá mais ser ajustada e nem parada. Um buzzer de alarme deve 
ser acionado ao término da contagem, emitindo um beep, de duração de 250 milisegundos, cada 1 segundo. 
O alarme sé interrompido ao se pressionar qualquer uma das teclas, evento no qual o cronômetro retorna ao 
seu estado inicial: contagem parada, alarme desativado e contagem inicial de 60 minutos.
*********************************************************************************************************************************************/

/****************************************************************************
                    CONFIGURAÇÕES NECESSÁRIAS  
****************************************************************************/
#define _XTAL_FREQ 4000000
#pragma config PBADEN = OFF
#include <xc.h>

/****************************************************************************
                    DECLARAÇÕES DE VARIAVEIS  
****************************************************************************/
unsigned char disp1,disp2;
char contar =0;
int para;

/****************************************************************************
                    CHAMADAS DE FUNÇÕES 
****************************************************************************/
void conta(void);
void atualiza_PORTD(void);
void inicializar(void);
void buzzer(int para);
void conta(void);

/****************************************************************************
                        FUNÇÕES PRINCIPAIS 
****************************************************************************/
int main(void) {
    inicializar();   // Inicializa a configurações básicas do pic
    while (1) {
        if(contar) conta();        // Verifica se pode contar ou não
        atualiza_PORTD();      // Atualiza as portas do portD
       
       // Delay de 1 minuto
       __delay_ms(30000);  
       __delay_ms(30000);
        
    }    
}


void atualiza_PORTD(void){
    PORTD = (disp2 << 4) | disp1; // Atualiza entradas do portd
}

// Liga o buzzer e apita a cada 250ms
void buzzer(int para){
    if(para == 1){
        RB4 ^=1;
        __delay_ms(250);
        TRISBbits.RB4 ^= 1;
    }
}

// Contador regressivo de 60 à 0 minutos
void conta(void){
    
    // Se parou então toca o buzzer
     if(disp2 == 0 && disp1 == 0){
        disp2 = 0;
        disp1 = 0;
        contar = 0;
        para = 1;
        while (para ==1) buzzer(para);
    }
    
    if (disp1 !=0){ 
        disp1--;        
    } else {
        if(contar == 1){
            disp2--;
            disp1=9;    
        }
    }
}  

void inicializar(void){
    // Inicialização
    TRISBbits.RB0         = 1; // RB0 como entrada
    TRISBbits.RB1         = 1; // RB1 como entrada
    TRISBbits.RB4         = 0; // RB4 como saída
    TRISD                      = 0; // PORTD todos bits com saída
    PORTB                    = 4; // RB4 com saída
    PORTD                    = 0; // Todas as portas do portD com saída
    INTCONbits.INT0IE   = 1; // Habilita interrupções INT0
    INTCON3bits.INT1IE = 1; // Habilita interrupções INT1
    INTCONbits.GIE       = 1; // Habilita interupões globalmente
    INTCONbits.PEIE     = 1; // Habilita interrupções dos periféricos
    disp1                       = 0; // Valor do display 1
    disp2                       = 6; // Valor do display 2
    contar                     = 0; // Contador do display
}

void __interrupt(high_priority) ISR(void){
    if(INT0IF){
        //Caso seja o botão ligado ao pino INT0
        INT0IF = 0;
        
        // Se o buzzer estiver ligado, para ele e retorna as configurações iniciais  
        if(para == 1){
            TRISBbits.RB4 = 0;
            TRISBbits.RB4 = 0;
            disp2 = 6;
            disp1 = 0;
            para =  0;
        } 
        else contar = 1; // Se o buzzer não estivar parado então ele começa o contar.
                
    } else if(INT1IF){
        //Caso seja o botão ligado ao pino INT1
        INT1IF = 0;
        
        // Adiciona 10 minutos
        if(para == 0){
            if(contar==0){ 
                if(disp2<9) disp2 ++;
            } 
            
          // Se o buzzer estiver ligado, para ele e retorna as configurações iniciais  
        } else if(para ==1 ){
            //RB4 = 0;
            TRISBbits.RB4 = 0;
            disp2 = 6;
            disp1 = 0;
            para =  0;
        }
    }
}