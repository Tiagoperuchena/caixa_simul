print("Os valores das cédulas não podem ser negativos!")

ced_100 = int(input("Quantas cédulas de 100 tem no caixa? "))
ced_50 = int(input("Quantas cédulas de 50 tem no caixa? "))
ced_20 = int(input("Quantas cédulas de 20 tem no caixa? "))
ced_10 = int(input("Quantas cédulas de 10 tem no caixa? "))
ced_5 = int(input("Quantas cédulas de 5 tem no caixa? "))
ced_2 = int(input("Quantas cédulas de 2 tem no caixa? "))

while True:
    saque = int(input("\nDigite o valor que deseja sacar (ou 0 para sair): "))

    if saque == 0:
        print("Encerrando operacoes.")
        break

    if saque < 2 or (saque % 2 != 0 and ced_5 == 0):
        print("Valor indisponivel, nao ha notas de R$1 e R$5 suficientes.")
        continue

    valor = saque
    n100 = n50 = n20 = n10 = n5 = n2 = 0

    n100 = min(valor // 100, ced_100) if valor >= 100 else 0
    valor -= n100 * 100

    n50 = min(valor // 50, ced_50) if valor >= 50 else 0
    valor -= n50 * 50
    
    n20 = min(valor // 20, ced_20) if valor >= 20 else 0
    valor -= n20 * 20

    n10 = min(valor // 10, ced_10) if valor >= 10 else 0
    valor -= n10 * 10

    n5 = min(valor // 5, ced_5) if valor >= 5 else 0
    valor -= n5 * 5

    n2 = min(valor // 2, ced_2) if valor >= 2 else 0
    valor -= n2 * 2
    
    if valor == 0:
       
        ced_100 -= n100
        ced_50 -= n50
        ced_20 -= n20
        ced_10 -= n10
        ced_5 -= n5
        ced_2 -= n2

        print(f"\nSaque de R${saque} realizado com:")
        if n100: print(f"{n100} nota(s) de R$100")
        if n50: print(f"{n50} nota(s) de R$50")
        if n20: print(f"{n20} nota(s) de R$20")
        if n10: print(f"{n10} nota(s) de R$10")
        if n5: print(f"{n5} nota(s) de R$5")
        if n2: print(f"{n2} nota(s) de R$2")
    else:
        print("Valor indisponivel para saque.")