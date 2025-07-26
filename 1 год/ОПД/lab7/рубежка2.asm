ORG 0x20
addr: WORD 0x6dd
elems: WORD 4
sign_mask: WORD 0x0040 ; проверка 23 бита
pos_mask: WORD 0x003F ; 0000 0000 0011 1111
neg_mask: WORD 0xFF80 ; 1111 1111 1000 0000
index: WORD 1
temp_l: WORD ?
temp_h: WORD ?
ans_pointer: WORD 0x400
max_l: WORD 0x0000
max_h: WORD 0x8000
START:
	CLA
    LD (addr)+
    ST temp_l
    LD (addr)+
    ST temp_h
    CLA
    LD index
    ASR
    BCS loop_elems
    LD temp_h
    AND sign_mask
    BEQ UPGRADE_POS
    BNE UPGRADE_NEG
UPGRADE_NEG: 
    LD temp_h
    OR neg_mask
    ST temp_h
    JUMP DIGITS_UPGRADE
UPGRADE_POS:
    LD temp_h
    AND pos_mask
    ST temp_h
DIGITS_UPGRADE:
    CMP max_h
    BEQ COMPARE_TAILS ; temp_h == max_h --> сравниваем temp_l и temp_h
    BGE UPDATE_MAX ; temp_h > max_h, то точно идём обновлять
    JUMP loop_elems ; temp_h < max_h, идём на следующую итерацию

COMPARE_TAILS:
    LD temp_l
    CMP max_l
    BGE UPDATE_MAX ; temp_l > max_l, то идём обновлять
    JUMP loop_elems

UPDATE_MAX:
    LD temp_l
    ST max_l
    LD temp_h
    ST max_h
    JUMP loop_elems
loop_elems:
	LD $index
    INC
    ST index
    LOOP elems
    JUMP START
    JUMP STOP
STOP:
	LD max_l
	ST (ans_pointer)+
	LD max_h
	ST (ans_pointer)+
    HLT



@ ORG 0x6dd
@ WORD 0x0000
@ WORD 0x0040
@ WORD 0x0000
@ WORD 0x0040
@ WORD 0x0040
@ WORD 0x0000
@ WORD 0x0040
@ WORD 0x0031
ORG 0x6dd
WORD 0x0000
WORD 0x0010
WORD 0x1234
WORD 0x000F
WORD 0x1111
WORD 0x000F
WORD 0x0005
WORD 0x0001