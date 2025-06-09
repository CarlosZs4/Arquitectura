.data
	 msg1: .asciiz "Ingrese el primer número: "
	 msg2: .asciiz "El resultado es: "
	 msg3: .asciiz "\n"
.text
.globl main

main: 
	li $v0, 4 #primer mensaje
	la $a0, msg1 #direccion de memoria del primer mensaje
	syscall
	
	li $v0, 5 #pedir número
	syscall
	move $a0, $v0 #guardar en a0
	
	jal factorial
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 1 #mostrar un numero
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	jal end_program
		
	
factorial: 
	addi, $sp, $sp, -8 #reservando 2 espacios en la pila
	
	sw $ra, 4($sp) #guardando direccion de retorno
	sw $a0, 0($sp) #guardando el n ingresado
	
	li $v0, 1 #valor de retorno por defecto: 1
	beq $a0, $zero, return #caso base si n == 0
	
	addi $a0, $a0, -1
	jal factorial
	
	lw $a, 0($sp)
	mul $v0, $a0, $v0  
	
	
	
return: 
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra

end_program:
	li $v0, 10 #codigo para terminar programa
	syscall