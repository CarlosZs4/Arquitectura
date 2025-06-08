.data
	 msg1: .asciiz "Ingrese el primer número: "
	 msg2: .asciiz "Ingrese el segundo numero: "
	 msg3: .asciiz "\n"
	 result: .asciiz "El resultado es: "
.text
.globl main
#EL PROGRAMA FUNCIONA SOLO SI EL PRIMER NUMERO INGRESADO ES MAYOR AL SEGUNDO
main: 
	li $v0, 4 #mostrar mensaje
	la $a0, msg1 #mensaje 1
	syscall
	
	li $v0, 5 #pedir numero
	syscall
	move $a1, $v0 #el valor de entrada cae en la variable $a1
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	move $a2, $v0
	
	add $a3, $a1, $zero
	
	
	jal mcm
	move $t0, $v0
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	jal end_program
mcm:
	#reservar en la pila
	addi $sp, $sp, -16
	sw $ra, 12($sp) #direccion de retorno
	sw $a1, 8($sp) #guardando en la pila el primer valor del mcm
	sw $a2, 4($sp) #guardando el segundo valor
	sw $a3, 0($sp) #variable auxiliar
	
	div $a3, $a2 #division a/b
	mfhi $t1 #residuo
	beq $t1, $zero, return  #caso base,si aux % $a2 es == 0
	
	add $a3, $a3, $a1 #caso recursivo, mcm(n,m, aux+n)
	jal mcm #llamada recursiva 
	
	#restaurar valores originales
	lw $ra, 12($sp)      # Restaurar $ra
    	lw $a1, 8($sp)       # Restaurar $a1
    	lw $a2, 4($sp)       # Restaurar $a2
    	lw $a3, 0($sp)       # Restaurar $a3
    	addi $sp, $sp, 16    # Liberar pila
    	jr $ra	
return: 
	move $v0, $a3
	lw $ra, 12($sp) 	#recuperar direccion de retorno
	lw $a1, 8($sp)          # Restaurar $a1
    	lw $a2, 4($sp)          # Restaurar $a2
    	lw $a3, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	
				
end_program: 
	li $v0, 10
	syscall
