# ------------------------------------------------------------------------------------------- #
#  Biblioteca com todos os macros e constantes/equivalências necessárias utilizadas no game!  #
# ------------------------------------------------------------------------------------------- #

#============================================================================== #
# 			CONSTANTES / EQUIVALÊNCIAS			 	#
#============================================================================== #

# Boolean
.eqv TRUE 1
.eqv FALSE 0

# Ecall Codes
.eqv PRINT_INT 1
.eqv PRINT_FLOAT 2
.eqv PRINT_STRING 4
.eqv PRINT_CHAR 11
.eqv EXIT1 10
.eqv EXIT2 93
.eqv OPEN_FILE 1024
.eqv READ_FILE 63
.eqv CLOSE_FILE 57
.eqv SLEEP 32
.eqv TIME 30
.eqv MIDI 33

# Keybord MMIO
.eqv MMIO_buf 0xff200004 	# Data (Endereço do Buffer, onde o valor ASCII da tecla pressionada está)
.eqv MMIO_ctrl 0xff200000 	# Control (valor Booleano, indica se houve tecla pressionada)


#============================================================================== #
# 				MACROS					 	#
#============================================================================== #

# SYSCALL ----------------------------------------------------- #
# Chama a syscall de acordo com a operação.
.macro syscall(%operation)
	li a7, %operation
	ecall
.end_macro
# ------------------------------------------------------------- #

# PRINT FULL IMG ---------------------------------------------- #
# Printa uma imagem completa no display.
.macro print_full_img0(%file_name)
.data
FILE:	.string %file_name

.text
# Abre o arquivo
	la a0, FILE		# Passa a label com o nome do arquivo a ser aberto.
	li a1,0			# Indica a leitura de um arquivo.
	li a2,0			# Indica um arquivo binário.
	syscall(OPEN_FILE)	# Chama a syscall e a0 recebe o descritor do arquivo.
	
	mv t0, a0		# Salva o descritor em t0.

# Le o arquivos para a memoria VGA
	li a1, 0xFF000000	# Endereço onde os bytes lidos do arquivo serão escritos.
	li a2, 76800		# Quantidade de bytes a serem lidos.
	syscall(READ_FILE)	# Lê o arquivo e retorna em a0 o comprimento.
	
#Fecha o arquivo
	mv a0, t0		# a0 recebe novamente o descritor.
	syscall(CLOSE_FILE)	# Fecha o arquivo.
.end_macro
# ------------------------------------------------------------- #

.macro print_full_img1(%file_name)
.data
FILE:	.string %file_name

.text
# Abre o arquivo
	la a0, FILE		# Passa a label com o nome do arquivo a ser aberto.
	li a1,0			# Indica a leitura de um arquivo.
	li a2,0			# Indica um arquivo binário.
	syscall(OPEN_FILE)	# Chama a syscall e a0 recebe o descritor do arquivo.
	
	mv t0, a0		# Salva o descritor em t0.

# Le o arquivos para a memoria VGA
	li a1, 0xFF100000	# Endereço onde os bytes lidos do arquivo serão escritos.
	li a2, 76800		# Quantidade de bytes a serem lidos.
	syscall(READ_FILE)	# Lê o arquivo e retorna em a0 o comprimento.
	
#Fecha o arquivo
	mv a0, t0		# a0 recebe novamente o descritor.
	syscall(CLOSE_FILE)	# Fecha o arquivo.
.end_macro


# PRINT_SPRITE ------------------------------------------------ #
# Printa uma sprite na posição desejada.
.macro print_sprite0(%coluna,%linha,%file_adress)
.data

.text
	la a0 %file_adress	#a0 endereço da imagem
	lw t0 0(a0)		#numero de colunas
	lw t1 4(a0)		#numero de linhas
	mul a2 t0 t1		#tamanho imagem
	li t1 0x140
	mul t1 t1 %linha	#multiplica 0x140 por linha
	add t1 t1 %coluna	#soma coluna ao valor de cima
	li a1 0xff000000
	add a1 t1 a1		#soma o valor de cima ao endereço da tela, endereço onde será printado sprite
	li t1 0			#contador 1
	li t2 0			#contador 2
	addi a0 a0 8
LOOP:
	beq t1 a2 DONE		#se o contador 1 for igual ao tamanho da img vai para DONE
	lw t3 0(a0)		#carrega a word da imagem
	sw t3 0(a1)		#coloca word no endereço calculado acima
	addi a0 a0 4
	addi a1 a1 4
	addi t1 t1 4
	addi t2 t2 4
	blt t2 t0 LOOP		#verifica se t2 esta do tamanho da largura da img
	li t2 0x140		#0x140 equivale a uma linha no bitmap display
	sub t2 t2 t0		#subtrai 0x140-colunas para alinhamento
	add a1 a1 t2		#soma t2 ao endereço do bitmap
	li t2 0			#zera o contador2
	j LOOP

DONE:
.end_macro

.macro print_sprite1(%coluna,%linha,%file_adress)
.data

.text
	la a0 %file_adress	#a0 endereço da imagem
	lw t0 0(a0)		#numero de colunas
	mv a5 t0
	lw t1 4(a0)		#numero de linhas
	mul a2 t0 t1		#tamanho imagem
	li t1 0x140
	mul t1 t1 %linha	#multiplica 0x140 por linha
	add t1 t1 %coluna	#soma coluna ao valor de cima
	li a1 0xff100000
	add a1 t1 a1		#soma o valor de cima ao endereço da tela, endereço onde será printado sprite
	li t1 0			#contador 1
	li t2 0			#contador 2
	addi a0 a0 8
LOOP:
	beq t1 a2 DONE		#se o contador 1 for igual ao tamanho da img vai para DONE
	lw t3 0(a0)		#carrega a word da imagem
	sw t3 0(a1)		#coloca word no endereço calculado acima
	addi a0 a0 4
	addi a1 a1 4
	addi t1 t1 4
	addi t2 t2 4
	blt t2 t0 LOOP		#verifica se t2 esta do tamanho da largura da img
	li t2 0x140		#0x140 equivale a uma linha no bitmap display
	sub t2 t2 t0		#subtrai 0x140-colunas para alinhamento
	add a1 a1 t2		#soma t2 ao endereço do bitmap
	li t2 0			#zera o contador2
	j LOOP

DONE:
.end_macro

.eqv frame_selec 0xff200604

.macro frame(%int)
	li t0 %int
	li t1 frame_selec
	sw t0 0(t1)
	
.end_macro

# ------------------------------------------------------------- #
# posição inimigo
.eqv colunaI 240
.eqv linhaI 170

# PRINT ALL --------------------------------------------------- #
.macro refresh(%alive,%frame)
.data
.include "gaara.data"
.text
	li t0 %frame
	beqz t0 FRAME0
	print_full_img1("cenario_vale.bin")
	beqz %alive DEAD
	li t5 colunaI
	li t6 linhaI
	print_sprite1(t5, t6, gaara)
	j DEAD
FRAME0:	print_full_img0("cenario_vale.bin")
	beqz %alive DEAD
	print_sprite0(t5, t6, gaara)
DEAD:
.end_macro
# ------------------------------------------------------------- #

.macro get_time(%prev_time)
.data
QUEBRA: .string "\n"
.text
	syscall(TIME)
	mv t0 a0
	sub t1 t0 %prev_time
	add s6 s6 t1
	li t2 1000
	mv s5 a0
	blt s6 t2 EXIT
	mv s6 zero
	addi s4 s4 -1
	mv a0 s4
	li a1, 150
	li a2, 10
	li a3, 0x000000FF
	li a4, 0
	syscall(101)
EXIT:
	
.end_macro 

# MENU -------------------------------------------------------- #
# Exibe o menu na tela e lê uma tecla para dar inicio ao game.

.macro loading()
.data
NOTAS: .word 62,1000,55,1500,74,250,72,250,67,2500,72,500,76,500,77,1000,72,3000,76,2000,74,500,76,500,77,500,71,500,79,2000,77,1000,74,1000,74,250,72,250,67,2500,72,500,76,500,77,1000,72,3000,76,2000,74,500,76,500,77,500,71,500,72,3000
.text
	print_full_img0("loading.bin")
	li s1 30
	la s0 NOTAS
	li t0 0
	li a2,68
	li a3,127
LOOP:	beq t0 s1 EXIT
	lw a0 0(s0)
	lw a1 4(s0)
	syscall(MIDI)
	addi s0 s0 8
	addi t0 t0 1
	j LOOP
EXIT:
.end_macro

.macro menu()
	print_full_img0("menu.bin")
.end_macro
#  ------------------------------------------------------------ #

.macro morte()
.data
#Tamanho: 35
NOTAS: .word 67,195,71,390,69,195,67,2730,55,195,60,195,62,195,64,780,62,585,60,1170,55,195,60,195,62,195,64,780,65,390,64,195,65,390,67,195,67,585,55,195,60,195,62,195,64,780,62,585,60,1170,60,195,67,195,65,390,60,195,67,195,65,390,59,390,59,390,60,195,60,1170
.text
	frame(0)
	print_full_img0("morte_rocklee.bin")
	li s1 35
	la s0 NOTAS
	li t0 0
	li a2,68
	li a3,127
LOOP:	beq t0 s1 EXIT
	lw a0 0(s0)
	lw a1 4(s0)
	syscall(MIDI)
	addi s0 s0 8
	addi t0 t0 1
	j LOOP
EXIT:

.end_macro

.macro vitoria()
.data
#Tamanho:41
NOTAS: .word 67,270,71,270,67,270,72,811,76,811,74,1893,67,270,71,270,67,270,76,811,74,811,71,1893,67,270,71,270,67,270,60,817,60,272,60,545,59,272,60,272,60,545,60,272,60,272,60,545,62,545,59,545,59,272,60,272,60,545,59,272,60,272,60,545,60,272,60,272,60,545,59,545,60,545,60,272,60,272,60,545,59,545,60,545,60,272,60,272,60,545,62,545,59,545,60,272,60,272,60,545,59,545,60,545,60,272,60,272,60,545,59,545
.text
	frame(0)
	print_full_img0("morte_gaara.bin")
	li s1 41
	la s0 NOTAS
	li t0 0
	li a2,68
	li a3,127
LOOP:	beq t0 s1 EXIT
	lw a0 0(s0)
	lw a1 4(s0)
	syscall(MIDI)
	addi s0 s0 8
	addi t0 t0 1
	j LOOP
EXIT:
.end_macro
	

.macro check_collision(%char_column,%char_line,%largura)
	li t0 colunaI
	addi t0 t0 8
	#li t1 linhaI
	mv t2 %char_column
	add  t1 %largura t2
	bgt t1 t0 COLISAO
	j EXIT
COLISAO:
	addi s7 s7 -1
EXIT:
	
.end_macro
