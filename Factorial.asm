.data
	msg1: .asciiz "Ingrese un número: "
        msg2: .asciiz "El resultado es: "
        msg3: .asciiz "mamalo Tulio soy un fokin crack"
        salto: .asciiz "\n"
.text
.globl main

main: 
	#mostrar mensaje
	li $v0, 4
	la $a0, msg1
	syscall
	
	#leer el numero
	li $v0, 5 #codigo 5 para leer el numero
	syscall
	move $t0, $v0
	
	#verificar si es igual a 0
	blez $t0, end_program #end_program es la "funcion" pasa salir
	
	#declaracion de variables
	li $t1, 1 #variable de contador
	li $t2, 1 # variable que se usará de acumulador
loop: 
	mul $t2, $t2, $t1
	add $t1, $t1, 1
	
	#mult $t2, $t1
	#mflo $t2
	
	#compara si el contador es menor al numero o igual al ingresado por el usuario
	ble $t1, $t0, loop
	
	#segundo mensaje
	li $v0, 4
	la $a0, msg2
	syscall
	
	#mostrar el resultado
	li $v0, 1 #codigo 1 para mostrar un entero
	move $a0, $t2
	syscall
	
	#salto de linea
	li $v0, 4
	la $a0, salto
	syscall
	
	#tercer mensaje
	li $v0, 4
	la $a0, msg3
	syscall
	
end_program:
	li $v0, 10
	syscall
	
	
	
	
	
	