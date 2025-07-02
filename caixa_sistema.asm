.data
    ced_100:      .word 10      

    msg_bem_vindo: .asciiz "bem-vindo!\n"
    prompt_saque: .asciiz "\ndigite o valor que deseja sacar (ou 0 para sair): R$"
    msg_sair:     .asciiz "obrigado por utilizar o nosso servico.\n"
    msg_valor_minimo: .asciiz "valor indisponível. O valor mínimo de saque é R$100.\n"
    msg_saque_ok: .asciiz "Saque de R$"
    msg_realizado_com: .asciiz " realizado com: \n"
    msg_indisponivel: .asciiz "valor indisponível para saque com as cedulas disponíveis.\n"
    msg_sem_cedulas: .asciiz "Cedulas insuficientes para o valor solicitado.\n"

    out_100:      .asciiz " cedula(s) de R$100\n"
    newline:      .asciiz "\n"

    n100_temp:    .word 0       

.text
.globl main

main:
    li   $v0, 4
    la   $a0, msg_bem_vindo
    syscall

    # carregar endereços 
    la   $s0, ced_100       

main_loop:
    li   $v0, 4
    la   $a0, prompt_saque
    syscall

    li   $v0, 5
    syscall
    move $t0, $v0           

    beq  $t0, $zero, sair_programa

   
    blt  $t0, 100, lidar_saque_pequeno

    # Verificar se é múltiplo de 100
    li   $t5, 100
    div  $t0, $t5
    mfhi $t1               
    bne  $t1, $zero, falha_saque  

   
    sw   $zero, n100_temp

   
    lw   $a1, 0($s0)      
    div  $t0, $t5          
    mflo $t3              
    ble  $t3, $a1, usar_cedulas_100  
    j    falha_saque      

usar_cedulas_100:
    sw   $t3, n100_temp    
    sub  $a1, $a1, $t3     
    sw   $a1, 0($s0)

   
    li   $v0, 4
    la   $a0, msg_saque_ok
    syscall

    li   $v0, 1
    move $a0, $t0
    syscall

    li   $v0, 4
    la   $a0, msg_realizado_com
    syscall

    lw   $a0, n100_temp
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_100
    syscall

    j    main_loop

lidar_saque_pequeno:
    li   $v0, 4
    la   $a0, msg_valor_minimo
    syscall
    j    main_loop

falha_saque:
    li   $v0, 4
    la   $a0, msg_indisponivel
    syscall
    j    main_loop

sair_programa:
    li   $v0, 4
    la   $a0, msg_sair
    syscall

    li   $v0, 10
    syscall