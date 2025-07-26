ORG 0x100
ARG1: WORD 0xFFFF
ARG2: WORD 0x800
ARG3: WORD 0x53
X: WORD 0x52
RES1: WORD ?
RES2: WORD ?
RES3: WORD ?
CORRECT_RES1: WORD 0xFFAD
CORRECT_RES2: WORD 0x7AE
CORRECT_RES3: WORD 0x1

ORG 0x4EF
START:
	CLA
	CALL TEST1
	CALL TEST2
	CALL TEST3
STOP: HLT

TEST1:
    LD X
	WORD 0x9100; ADDHL 100 - адрес ARG1
	BMI negative_is_set
	JUMP exit
	negative_is_set: LD ARG1
	CMP CORRECT_RES1
	BEQ set_number1_is_correct
	JUMP exit
	set_number1_is_correct: LD CHECK1
	INC
	ST CHECK1
	exit: RET

TEST2:
	LD ARG2
	WORD 0x9471
	BEQ zero_is_set
	JUMP exit
	zero_is_set: LD ARG2
	CMP CORRECT_RES2
	BEQ set_number2_is_correct
	JUMP exit
	set_number2_is_correct: LD CHECK2
	INC
	ST CHECK2
	JUMP exit

TEST3:
	LD ARG3
	WORD 0x9472
	BVC overflow_is_set
	JUMP exit
	overflow_is_set: LD ARG3
	CMP CORRECT_RES3
	BEQ set_number3_is_correct
	JUMP exit
	set_number3_is_correct: LD CHECK3
	INC
	ST CHECK3
    JUMP exit