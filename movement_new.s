# ANIMAÇÕES

#ALIVE

# ASCII
.eqv um 49
.eqv a 97
.eqv c 99
.eqv d 100
.eqv e 101
.eqv g 103
.eqv q 113
.eqv w 119
.eqv x 120
.eqv z 122
.eqv s 115
.eqv W 87
.eqv E 69
.eqv A 65
.eqv C 67
.eqv Q 81
.eqv Z 90
.eqv X 88
.eqv D 68

# ------------------------- AÇÕES ----------------------------- #

.macro cumprimento(%l, %c)
	refresh(s7,0)
	print_sprite0(%l, %c, andar_1)
	refresh(s7,1)
	print_sprite1(%l, %c, cumprimento_1)
	li a0, 350
	syscall(SLEEP)
	refresh(s7,0)
	frame(1)
	print_sprite0(%l, %c, cumprimento_2)
	li a0, 375
	syscall(SLEEP)
	refresh(s7,1)
	frame(0)
	refresh(s7,1)
	print_sprite1(%l, %c, cumprimento_1)
	li a0, 375
	syscall(SLEEP)
	refresh(s7,0)
	frame(1)
	print_sprite0(%l, %c, andar_1)
	li a0, 300
	syscall(SLEEP)
	refresh(s7,1)
	frame(0)
.end_macro

.macro acao(%char, %prev.column, %prev.line)
.data
.include "andar_1.data"
.include "andar_2.data"
.include "andar_3.data"
.include "andar_4.data"
.include "pulo_1.data"
.include "high_kick_1.data"
.include "high_kick_2.data"
.include "high_kick_4.data"
.include "true_high_kick_1.data"
.include "true_high_kick_2.data"
.include "crouch.data"
.include "somersault1.data"
.include "somersault2.data"
.include "somersault3.data"
.include "somersault4.data"
.include "punch_base.data"
.include "high_punch.data"
.include "jab.data"
.include "low_punch.data"
.include "roundhouse_1.data"
.include "roundhouse_2.data"
.include "roundhouse_3.data"
.include "short_jab_kick.data"
.include "kick_base_back.data"
.include "true_high_kick_back_1.data"
.include "true_high_kick_back_2.data"
.include "mid_kick.data"
.include "forward_sweep_1.data"
.include "forward_sweep_2.data"
.include "backwards_sweep_1.data"
.include "backwards_sweep_2.data"

.text
# Executa o movimento de acordo com a tecla pressionada.
	#li s7 1 #enemy alive
	li t0 a
	beq %char t0 J_ACAO_a
	li t0 q
	beq %char t0 J_ACAO_q
	li t0 w
	beq %char t0 J_ACAO_w
	li t0 e
	beq %char t0 J_ACAO_e
	li t0 d
	beq %char t0 J_ACAO_d
	li t0 x
	beq %char t0 J_ACAO_x
	li t0 z
	beq %char t0 J_ACAO_z
	li t0 c
	beq %char t0 J_ACAO_c
	li t0 g
	beq %char t0 J_ACAO_g
	li t0 W
	beq %char t0 J_ACAO_W
	li t0 E
	beq %char t0 J_ACAO_E
	li t0 A
	beq %char t0 J_ACAO_A
	li t0 C
	beq %char t0 J_ACAO_C
	li t0 Q
	beq %char t0 J_ACAO_Q
	li t0 D
	beq %char t0 J_ACAO_D
	li t0 Z
	beq %char t0 J_ACAO_Z
	li t0 X
	beq %char t0 J_ACAO_X		
	j EXIT

J_ACAO_a: j ACAO.a
J_ACAO_q: j ACAO.q
J_ACAO_w: j ACAO.w	
J_ACAO_e: j ACAO.e
J_ACAO_d: j ACAO.d
J_ACAO_x: j ACAO.x
J_ACAO_z: j ACAO.z
J_ACAO_c: j ACAO.c
J_ACAO_g: j ACAO.g
J_ACAO_W: j ACAO.W
J_ACAO_E: j ACAO.E
J_ACAO_A: j ACAO.A
J_ACAO_C: j ACAO.C
J_ACAO_Q: j ACAO.Q
J_ACAO_D: j ACAO.D
J_ACAO_Z: j ACAO.Z
J_ACAO_X: j ACAO.X
			
ACAO.a:	# WALK BACKWARDS ------------------------------------------------- #
	refresh(s7,0)
	addi %prev.column %prev.column -4
	print_sprite0(%prev.column, %prev.line, andar_1)
	refresh(s7,1)
	frame(0)
	addi %prev.column %prev.column -4
	print_sprite1(%prev.column, %prev.line, andar_2)
	#li a0, 30
	#syscall(SLEEP)
	refresh(s7,0)
	frame(1)
	addi %prev.column %prev.column -4
	print_sprite0(%prev.column, %prev.line, andar_3)
	#li a0, 30
	#syscall(SLEEP)
	refresh(s7,1)
	frame(0)
	addi %prev.column %prev.column -4
	print_sprite1(%prev.column, %prev.line, andar_4)
	refresh(s7,0)
	frame(1)
	j EXIT
	
ACAO.d: # WALK FORWARD --------------------------------------------------- #
	refresh(s7,0)
	addi %prev.column %prev.column 4
	print_sprite0(%prev.column, %prev.line, andar_1)
	#li a0, 30
	#syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column %prev.column 4
	print_sprite0(%prev.column, %prev.line, andar_2)
	#li a0, 30
	#syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column %prev.column 4
	print_sprite0(%prev.column, %prev.line, andar_3)
	#li a0, 30
	#syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column %prev.column 4
	print_sprite0(%prev.column, %prev.line, andar_4)
	j EXIT	
	
ACAO.w: # JUMP ------------------------------------------------------------ #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, pulo_1)
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	addi %prev.line, %prev.line, -30
	print_sprite0(%prev.column, s11, high_kick_2)
	li a0, 77
	li a1, 500
	li a2, 0
	li a3, 100
	li a7, 31
	ecall
	li a0, 125
	syscall(SLEEP)
	addi %prev.line, %prev.line, 30
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, pulo_1)
	li a0, 75
	syscall(SLEEP)

	j EXIT
	
ACAO.x: # CROUCH ---------------------------------------------------------- #
	refresh(s7,0)
	addi %prev.line, %prev.line, 10
	print_sprite0(%prev.column, %prev.line, crouch)	
	addi %prev.line, %prev.line, -10
	li a0, 200
	syscall(SLEEP)
	j EXIT
	
ACAO.q: # FORWARD SOMERSAULT ---------------------------------------------- #
	# 1, 2, 3, 4, 1
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault1)
	li a0, 50
	syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column %prev.column 32
	addi %prev.line %prev.line -40
	print_sprite0(%prev.column, %prev.line, somersault2)
	li a0, 77
	li a1, 500
	li a2, 0
	li a3, 100
	li a7, 31
	ecall
	li a0, 50
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault3)
	li a0, 50
	syscall(SLEEP)
	addi %prev.column %prev.column 32
	addi %prev.line %prev.line 40
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault4)
	j EXIT

ACAO.g:	# LOW PUNCH ------------------------------------------------ #
	refresh(s7,0)
	addi %prev.line, %prev.line, 10
	print_sprite0(%prev.column, %prev.line, crouch)
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, low_punch)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	li a0, 150
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, crouch)
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	addi %prev.line, %prev.line, -10
	j EXIT

ACAO.c:	# JAB ------------------------------------------------------------- #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, punch_base)
	li a0, 200
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, jab)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	check_collision(%prev.column, %prev.line, a5)
	li a0, 400
	syscall(SLEEP)
	j EXI

ACAO.e: # HIGH PUNCH ------------------------------------------------------ #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, punch_base)
	li a0, 200
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_punch)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	li a0, 175
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, punch_base)
	check_collision(%prev.column, %prev.line, a5)
	li a0, 100
	syscall(SLEEP)
	j EXIT
	
ACAO.z: # BACKWARDS SOMERSAULT -------------------------------------------- #
	# 4, 3, 2, 1
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault4)
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column %prev.column -32
	addi %prev.line %prev.line -40
	print_sprite0(%prev.column, %prev.line, somersault3)
	li a0, 77
	li a1, 500
	li a2, 0
	li a3, 100
	li a7, 31
	ecall
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault2)
	li a0, 75
	syscall(SLEEP)
	addi %prev.column %prev.column -32
	addi %prev.line %prev.line 40
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, somersault1)
	j EXIT

ACAO.W: # FLYING KICK ------------------------------------------------------ #
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, pulo_1)
	li a0, 125
	syscall(SLEEP)
	refresh(s7, 0)
	addi %prev.column, %prev.column, 16
	addi %prev.line, %prev.line, -30
	print_sprite0(%prev.column, %prev.line, high_kick_2)
	li a0, 77
	li a1, 500
	li a2, 0
	li a3, 100
	li a7, 31
	ecall
	li a0, 175
	syscall(SLEEP)
	refresh(s7, 0)
	addi %prev.column, %prev.column, 16
	print_sprite0(%prev.column, %prev.line, high_kick_3)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	check_collision(%prev.column, %prev.line, a5)
	li a0, 200
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, high_kick_2)
	li a0, 150
	syscall(SLEEP)
	addi %prev.line, %prev.line, 30
	j EXIT

ACAO.E:	# HIGH KICK ---------------------------------------------- #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 25
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_1)
	li a0, 25 
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_2)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	li a0, 150
	syscall(SLEEP)
	check_collision(%prev.column, %prev.line, a5)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_1)
	li a0, 25
	syscall(SLEEP)	
	j EXIT

ACAO.A: # ROUNDHOUSE ------------------------------------------------------ #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, roundhouse_1)
	li a0, 50
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, roundhouse_2)
	li a0, 50
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, roundhouse_3)
	li a0, 50
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_2)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall	
	check_collision(%prev.column, %prev.line, a5)
	li a0, 150
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 50
	syscall(SLEEP)
	j EXIT

ACAO.C: # SHOR JAB KICK -------------------------------------------------- 3
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 75
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, short_jab_kick)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall	
	check_collision(%prev.column, %prev.line, a5)
	li a0, 200
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 75
	syscall(SLEEP)	
	j EXIT

ACAO.Q:	# HIGH BACK KICK --------------------------------------------------- #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, kick_base_back)
	li a0, 25
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_back_1)
	li a0, 25 
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_back_2)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	check_collision(%prev.column, %prev.line, a5)
	li a0, 150
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, true_high_kick_back_1)
	li a0, 25 
	syscall(SLEEP)
	j EXIT

ACAO.D: # MID KICK ------------------------------------------------------- #
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 25
	syscall(SLEEP)
	refresh(s7, 0)
	print_sprite0(%prev.column, %prev.line, mid_kick)
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	li a0, 150
	syscall(SLEEP)
	check_collision(%prev.column, %prev.line, a5)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, high_kick_1)
	li a0, 25
	syscall(SLEEP)	
	j EXIT

ACAO.Z: # BACKWARDS SWEEP ------------------------------------------------- #
	refresh(s7,0)
	addi %prev.line, %prev.line, 16
	print_sprite0(%prev.column, %prev.line, backwards_sweep_1)	
	li a0, 100
	syscall(SLEEP)
	refresh(s7,0)
	addi %prev.column, %prev.column, -16
	print_sprite0(%prev.column, %prev.line, backwards_sweep_2)	
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	check_collision(%prev.column, %prev.line, a5)
	li a0, 200
	syscall(SLEEP)
	addi %prev.column, %prev.column, 16
	addi %prev.line, %prev.line, -16
	j EXIT

ACAO.X: # FORWARD SWEEP -------------------------------------------------- #
	refresh(s7,0)
	addi %prev.line, %prev.line, 16
	print_sprite0(%prev.column, %prev.line, forward_sweep_1)	
	li a0, 100
	syscall(SLEEP)
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, forward_sweep_2)	
	li a0, 50
	li a1, 1000
	li a2, 127
	li a3, 100
	li a7, 31
	ecall
	check_collision(%prev.column, %prev.line, a5)
	li a0, 200
	syscall(SLEEP)
	addi %prev.line, %prev.line, -16
	j EXIT

EXI:	
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, punch_base)
	frame(0)
	li a0, 100
	syscall(SLEEP)
EXIT:
	refresh(s7,0)
	print_sprite0(%prev.column, %prev.line, andar_1)
	refresh(s7,1)
	frame(0)


.end_macro

