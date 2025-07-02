#include  <stdio.h>

int main () {
	int ced_100,ced_50,ced_20,ced_10,ced_5,ced_2;
	int saque;
	
	printf("valores das cedulas nao podem ser negativos!! \n");
	printf("\n");
	
	printf("quantas cedulas de 100 tem no caixa? \n");
	scanf("%d", &ced_100);
	
	printf("quantas cedulas de 50 tem no caixa? \n");
	scanf("%d", &ced_50);
	
	printf("quantas cedulas de 20 tem no caixa? \n");
	scanf("%d", &ced_20);
	
	printf("quantas cedulas de 10 tem no caixa? \n");
	scanf("%d", &ced_10);
	
	printf("quantas cedulas de 5 tem no caixa? \n");
	scanf("%d", &ced_5);
	
	printf("quantas cedulas de 2 tem no caixa? \n");
	scanf("%d", &ced_2);
	
	while (1) {
		printf("Digite o valor que deseja sacar(ou 0 para sair:) \n");
		scanf("%d", &saque);
		
         if (saque == 0) {
            printf("Obrigado por utilizar o nosso servico. \n");
            break; 
        } else if (saque < 2) {
            printf("Valor indisponivel. Nao ha notas de R$1 e o valor minimo de saque e R$2\n");
            continue; 
        }

	int valor = saque;                                                       
	int n100 = 0, n50 = 0, n20 = 0, n10 = 0, n5 = 0, n2 = 0;               
	  
     n100 = (valor >= 100) ? ((valor / 100 < ced_100) ? (valor / 100 ) : ced_100) : 0;
     valor -= n100 * 100;
     
     n50 = (valor >= 50) ? ((valor / 50 < ced_50) ? (valor / 50) : ced_50) : 0;
     valor -= n50 * 50;

     n20 =  (valor >= 20) ? ((valor / 20 < ced_20) ? (valor /50) : ced_20) : 0;
     valor -= n20 * 20;
        
     n10 = (valor >= 10) ? ((valor / 10 < ced_10) ? (valor /10) : ced_10) : 0;
     valor -= n10 * 10;
       
     n5 = (valor >= 5) ? ((valor / 5 < ced_5) ? (valor /5) : ced_5) : 0;
     valor -= n5 * 5;

     n2 = (valor >= 2) ? ((valor / 2 < ced_2) ? (valor /2) : ced_2) : 0;
     valor -= n2 * 2;
        
     if (valor == 0) {
           
            ced_100 -= n100;
            ced_50 -= n50;
            ced_20 -= n20;
            ced_10 -= n10;
            ced_5 -= n5;
            ced_2 -= n2;

            printf("saque de R$%d realizado com:\n", saque);
            if (n100 > 0) printf("%d nota(s) de R$100\n", n100);
            if (n50 > 0)  printf("%d nota(s) de R$50\n", n50);
            if (n20 > 0)  printf("%d nota(s) de R$20\n", n20);
            if (n10 > 0)  printf("%d nota(s) de R$10\n", n10);
            if (n5 > 0)   printf("%d nota(s) de R$5\n", n5);
            if (n2 > 0)   printf("%d nota(s) de R$2\n", n2);
        } else {
            printf("valor indisponivel para saque.\n");
	 }
    }
    return 0;
}
