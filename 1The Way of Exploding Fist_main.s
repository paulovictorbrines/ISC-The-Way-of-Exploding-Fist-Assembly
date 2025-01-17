##########################################################################
# � [x] Sistema de Pooling do Teclado;
# � [x] Exibir Menu na tela e iniciar o game.
#	� [x] Fazer macro para printar o Menu;
#	� [x] Fazer leitura da tecla que starta o game;
# � [x] Movimenta��o do Player;
# 	� [x] Fazer macro para printar sprites.
# 	� [x] Fazer movimenta��o de andar.
#	� [x] Fazer movimenta��o de pular.
# � [x] Golpes
#	� [x] Golpes B�sicos
#		� [x] Jump (w)
#		� [x] High Punch (e)
#		� [x] Walk Forward (d)
#		� [x] Jab (c)
#		� [x] Crouch (x)
#		� [x] Low Punch (g)
#		� [x] Back Somersault (z)
#		� [x] Walk Backwards (a)
#		� [x] Forward Somersault (q)
#	� [x] Golpes Especiais
#		� [x] Flying Kick (W)
#		� [x] High Kick (E)
#		� [x] Mid Kick (D)
#		� [x] Short Jab Kick (C)
#		� [x] Forward Sweep (X)
#		� [x] Bacwards Sweep (Z)
#		� [x] Roundhouse / About-face (A)
# 		� [x] High Back Kick (Q)
# � [x] Som
# � [ ] IA
##########################################################################
# o jogo come�a com uma tela de loading que toca um trecho de m�sica
# na tela de menu aprete "f" para come�ar o jogo
# o fire button � a tecla shift
##########################################################################
# ============================= INLCUDES =============================== # 
.include "game_lib_new.s"
.include "MACROSv21.s"
.include "movement_new.s"
# ====================================================================== #

.data
.include "cumprimento_1.data"
.include "cumprimento_2.data"
.include "andar_base.data"

.text
MAIN:	
	frame(0)
	loading()
	menu()			# Printa o menu.
	li s0, MMIO_ctrl	# s0 recebe o endere�o onde o bit de controle do teclado est� armazenado.
	sw zero, 0(s0)		# Limpa o bit de controle, evitando que qualquer tecla pressionada antes da execu��o seja interpretada.
	li t2, 0x66		# t2 recebe o valor ASCII de 'f'.
	li s10 12		# s10 recebe o valor da coluna onde se quer imprimir.
	li s11 170		# s11 recebe o valor da linha '' '' ''.

# Exibe o Menu --------------------------------------------------------------------------- #
MENU_LOOP:
	lb t1, 0(s0)		# t1 recebe o bit de controle (1 = teclado quer mandar um dado, 0 = teclado n�o quer mandar um dado).
	beqz t1, MENU_LOOP	# Reinicia o loop caso t1 = 0 (caso o teclado n�o queira mandar nenhum dado).
	li a0, MMIO_buf		# a0 recebe o endere�o onde o valor ASCII da tecla pressionada est� guardado.
	lw a0, 0(a0)		# Instru��o necess�ria para que o dado n�o se perca.
	# a0 cont�m o valor ASCII do caractere agora.
	beq a0, t2, FIM_MENU	# Caso o caractere seja igual a 'f', sai do menu.
	j MENU_LOOP		# Loop infinito at� que 'f' seja pressionado.
FIM_MENU:

# Jogo come�a ---------------------------------------------------------------------------- #
	li s7 2
	cumprimento(s10, s11)	# Chama a anima��o incial de cumprimento.
	li a7 30
	ecall
	mv s5 a0
	li s4 40
POOL_LOOP:
	get_time(s5)
	lb t1, 0(s0)		# t1 recebe o bit de controle (1 = teclado quer mandar um dado, 0 = teclado n�o quer mandar um dado).
	beqz s4 J_MORTE
	beqz s7 J_VITORIA
	j PULEI
J_MORTE: j MORTE
	 j PULEI
J_VITORIA: j VITORIA
PULEI:	beqz t1, POOL_LOOP	# Reinicia o loop caso t1 = 0 (caso o teclado n�o queira mandar nenhum dado).
	li a0, MMIO_buf		# a0 recebe o endere�o onde o valor ASCII da tecla pressionada est� guardado.
	lw a0, 0(a0)		# Instru��o necess�ria para que o dado n�o se perca.
	#a0 cont�m o valor ASCII do caractere agora.
	acao(a0,s10,s11)	# Chama o macro que executa a anima��o de acordo com a tecla pressionada.
	j POOL_LOOP		# Loop infinito do teclado.

MORTE:
	morte()
	j EXIT
VITORIA:
	vitoria()
EXIT:
	syscall(EXIT1)		# Finaliza a execu��o do programa.

.include "SYSTEMv21.s"
