.data
    ced_100:      .word 10       # Quantidade de cédulas de R$100
    ced_50:       .word 10       # Quantidade de cédulas de R$50
    ced_20:       .word 10       # Quantidade de cédulas de R$20
    ced_10:       .word 10       # Quantidade de cédulas de R$10
    ced_5:        .word 10       # Quantidade de cédulas de R$5
    ced_2:        .word 10       # Quantidade de cédulas de R$2

    msg_bem_vindo: .asciiz "bem-vindo!\n"
    prompt_saque: .asciiz "\ndigite o valor que deseja sacar (ou 0 para sair): R$"
    msg_sair:     .asciiz "obrigado por utilizar o nosso servico.\n"
    msg_valor_minimo: .asciiz "valor indisponível. O valor mínimo de saque é R$2.\n"
    msg_saque_ok: .asciiz "Saque de R$"
    msg_realizado_com: .asciiz " realizado com: \n"
    msg_indisponivel: .asciiz "valor indisponível para saque com as cedulas disponíveis.\n"
    msg_sem_cedulas: .asciiz "Cedulas insuficientes para o valor solicitado.\n"

    out_100:      .asciiz " cedula(s) de R$100\n"
    out_50:       .asciiz " cedula(s) de R$50\n"
    out_20:       .asciiz " cedula(s) de R$20\n"
    out_10:       .asciiz " cédula(s) de R$10\n"
    out_5:        .asciiz " cedula(s) de R$5\n"
    out_2:        .asciiz " ceedula(s) de R$2\n"
    newline:      .asciiz "\n"

    n100_temp:    .word 0       
    n50_temp:     .word 0       
    n20_temp:     .word 0        
    n10_temp:     .word 0       
    n5_temp:      .word 0       
    n2_temp:      .word 0       

.text
.globl main

main:
   
    li   $v0, 4
    la   $a0, msg_bem_vindo
    syscall

    # carregar endereços 
    la   $s0, ced_100       
    la   $s1, ced_50        
    la   $s2, ced_20        
    la   $s3, ced_10        
    la   $s4, ced_5         
    la   $s5, ced_2         

main_loop:
    
    li   $v0, 4
    la   $a0, prompt_saque
    syscall

    
    li   $v0, 5
    syscall
    move $t0, $v0           

    
    beq  $t0, $zero, sair_programa

    #min
    blt  $t0, 2, lidar_saque_pequeno

  
    sw   $zero, n100_temp
    sw   $zero, n50_temp
    sw   $zero, n20_temp
    sw   $zero, n10_temp
    sw   $zero, n5_temp
    sw   $zero, n2_temp

    move $t1, $t0           

  
    lw   $a1, 0($s0)       
    blez $a1, verificar_50  
    li   $t5, 100          
    div  $t1, $t5          
    mflo $t3               
    mfhi $t1               
    ble  $t3, $a1, usar_cedulas_100  
    move $t3, $a1          
    mul  $t6, $t3, $t5      
    sub  $t1, $t0, $t6    
usar_cedulas_100:
    sw   $t3, n100_temp    

verificar_50:
    lw   $a1, 0($s1)       
    blez $a1, verificar_20
    li   $t5, 50
    div  $t1, $t5
    mflo $t3
    mfhi $t1
    ble  $t3, $a1, usar_cedulas_50
    move $t3, $a1
    mul  $t6, $t3, $t5
    sub  $t1, $t1, $t6
    add  $t1, $t1, $t6     
usar_cedulas_50:
    sw   $t3, n50_temp

verificar_20:
    lw   $a1, 0($s2)       
    blez $a1, verificar_10
    li   $t5, 20
    div  $t1, $t5
    mflo $t3
    mfhi $t1
    ble  $t3, $a1, usar_cedulas_20
    move $t3, $a1
    mul  $t6, $t3, $t5
    sub  $t1, $t1, $t6
    add  $t1, $t1, $t6     
usar_cedulas_20:
    sw   $t3, n20_temp

verificar_10:
    lw   $a1, 0($s3)       
    blez $a1, verificar_5
    li   $t5, 10
    div  $t1, $t5
    mflo $t3
    mfhi $t1
    ble  $t3, $a1, usar_cedulas_10
    move $t3, $a1
    mul  $t6, $t3, $t5
    sub  $t1, $t1, $t6
    add  $t1, $t1, $t6     
usar_cedulas_10:
    sw   $t3, n10_temp

verificar_5:
    lw   $a1, 0($s4)        
    blez $a1, verificar_2
    li   $t5, 5
    div  $t1, $t5
    mflo $t3
    mfhi $t1
    ble  $t3, $a1, usar_cedulas_5
    move $t3, $a1
    mul  $t6, $t3, $t5
    sub  $t1, $t1, $t6
    add  $t1, $t1, $t6     
usar_cedulas_5:
    sw   $t3, n5_temp

verificar_2:
    lw   $a1, 0($s5)       
    blez $a1, fim_verificacao
    li   $t5, 2
    div  $t1, $t5
    mflo $t3
    mfhi $t1
    ble  $t3, $a1, usar_cedulas_2
    move $t3, $a1
    mul  $t6, $t3, $t5
    sub  $t1, $t1, $t6
    add  $t1, $t1, $t6     
usar_cedulas_2:
    sw   $t3, n2_temp

fim_verificacao:
  
    bne  $t1, $zero, falha_saque

   
    lw   $t2, n100_temp
    lw   $t3, 0($s0)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s0)

    lw   $t2, n50_temp
    lw   $t3, 0($s1)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s1)

    lw   $t2, n20_temp
    lw   $t3, 0($s2)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s2)

    lw   $t2, n10_temp
    lw   $t3, 0($s3)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s3)

    lw   $t2, n5_temp
    lw   $t3, 0($s4)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s4)

    lw   $t2, n2_temp
    lw   $t3, 0($s5)
    sub  $t3, $t3, $t2
    sw   $t3, 0($s5)

   
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
    beqz $a0, mostrar_50
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_100
    syscall

mostrar_50:
    lw   $a0, n50_temp
    beqz $a0, mostrar_20
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_50
    syscall

mostrar_20:
    lw   $a0, n20_temp
    beqz $a0, mostrar_10
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_20
    syscall

mostrar_10:
    lw   $a0, n10_temp
    beqz $a0, mostrar_5
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_10
    syscall

mostrar_5:
    lw   $a0, n5_temp
    beqz $a0, mostrar_2
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_5
    syscall

mostrar_2:
    lw   $a0, n2_temp
    beqz $a0, fim_saque
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, out_2
    syscall

fim_saque:
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
