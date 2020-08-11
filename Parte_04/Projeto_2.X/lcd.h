
#ifndef XC_HEADER_TEMPLATE_H
#define	XC_HEADER_TEMPLATE_H
#include <xc.h> 

#define _XTAL_FREQ 4000000

#define lcd_rs     PORTDbits.RD0 // pino rs (register select)do LCD                                                                  // (0) para comandos (1) para dados
#define lcd_enable PORTDbits.RD1 // pino enable do LCD
#define lcd_db4    PORTDbits.RD4 // pino de dados d4 do LCD
#define lcd_db5    PORTDbits.RD5 // pino de dados d5 do LCD
#define lcd_db6    PORTDbits.RD6 // pino de dados d6 do LCD
#define lcd_db7    PORTDbits.RD7 // pino de dados d7 do LCD

/***************************************************************************/
/* Rotinas para o LCD */
/***************************************************************************/
 void envia_nibble_lcd(char dado);
 void envia_byte_lcd(char endereco,char dado);
 inline void escreve_lcd(char c);
 void limpa_lcd(void);
 void inicializa_lcd(void);
 void caracter_inicio(char linha,char coluna);

#endif	/* XC_HEADER_TEMPLATE_H */

