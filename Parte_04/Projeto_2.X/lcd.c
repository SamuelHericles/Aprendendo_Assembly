#include "lcd.h" 

// Escreve no LCD os 4 bits menos significativos de dado
void envia_nibble_lcd(char dado)
{ 
  lcd_enable = 1;  
  lcd_db4 = dado & 0x01;
  lcd_db5 = (dado >> 1) & 0x01;
  lcd_db6 = (dado >> 2) & 0x01;
  lcd_db7 = (dado >> 3) & 0x01;
  //Gera um pulso de enable
 
  __delay_us(50); // Recomendado para estabilizar o LCD
  lcd_enable = 0;
  __delay_us(50);
}

// Esta rotina envia um dado ou um comando para o LCD
// endereco = 0 -> a variável dado será enviada como uma instrução
// endereco = 1 -> a variável dado será enviada como um caractere

void envia_byte_lcd(char endereco,char dado)
{
 lcd_rs = endereco; // Seta o bit RS para instrução ou caractere
 __delay_us(5);   // Aguarda 5 us para o LCD estabilizar
 envia_nibble_lcd(dado>>4); // Envia ao LCD os MSBs de dado
 envia_nibble_lcd(dado & 0x0f); // Envia os LSBs de dado
}

// Esta rotina foi implementada como uma forma conveniente 
// de se escrever um caractere no display

inline void escreve_lcd(char c){envia_byte_lcd(1,c);};

// Função que envia instrução para limpar a tela do LCD
void limpa_lcd(void)
{
  envia_byte_lcd(0,0x01); // 0x01 -> instrução para limpar LCD 
  __delay_ms(2);  // Aguarda 2ms para estabilizar o LCD                                                         // Retorna ao ponto de chamada da função
}

// Função de inicialização do LCD
void inicializa_lcd(void)
{
 lcd_enable = 0;   
 lcd_db4 = 0;  // Garante que os pino DB4-DB7 estão em 0 (low)
 lcd_db5 = 0;
 lcd_db6 = 0;
 lcd_db7 = 0;
 
 __delay_ms(50); // Aguarda 5ms para estabilizar o LCD
 envia_nibble_lcd(0x03); // Envia comando de inicialização
 __delay_ms(4); // Aguarda 5ms para estabilizar o LCD
 envia_nibble_lcd(0x03); // Envia comando de inicialização
 __delay_us(100); // Aguarda 5ms para estabilizar o LCD
 envia_nibble_lcd(0x03); // Envia comando de inicialização

 envia_nibble_lcd(0x02); // Comando que configura o LCD para 4 bits

 envia_byte_lcd(0,0x01); // instrução para limpar LCD 
 __delay_ms(2);  // Aguarda 2ms para estabilizar o LCD 

 envia_byte_lcd(0,0x28); // Comando que configura o LCD para 4 bits, 2 linhas
 // e fonte 5X7.
 envia_byte_lcd(0,0x0c); // Display ligado, sem cursor
 
 envia_byte_lcd(0,0x06); // Posiciona o cursor à direita
}

// Esta função define a posição da tela do LCD (linha e coluna)
// a partir da qual serão realizadas futuras escritas de caracteres. 

 void caracter_inicio(char linha,char coluna)
{
 char posicao=0;
 if(linha == 1)
{
 posicao=0x80; // Endereço inicial da linha 1 (0x80)
}
 if(linha == 2)
{
 posicao=0xc0; // Endereço inicial da linha 2 (0xc0)
}

posicao=posicao+coluna; //soma o número da coluna ao endereço inicial                                                  //subtrai 1 para corrigir posição

envia_byte_lcd(0,posicao); // Envia commando
}