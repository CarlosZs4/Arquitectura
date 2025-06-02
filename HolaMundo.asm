.data
	msg1: .asciiz "Hola mundo!"
	msg2: .asciiz "\n"
.text

main:

	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 10
	syscall
	