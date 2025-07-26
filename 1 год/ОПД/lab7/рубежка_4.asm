ORG 0x20
arr: WORD 0x6c6
len: WORD 5
index: WORD 4
sign_mask: WORD 0x20 ; 0000 0000 0010 0000
pos_mask: WORD 0x1F
neg_mask: WORD 0xFFC0
ans_pointer: WORD 0x400
max_l: WORD 0
max_h: WORD 0x8000
temp_l: WORD ?
temp_h: WORD ?

START:
    CLA
    LD (arr)+
    ST temp_l
    LD (arr)+
    ST temp_h
    CLA
    LD index
    ASR
    BCS loop_elems
    ASR
    BSC loop_elems
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
    BEQ COMPARE_TAILS
    BGE UPDATE_MAX
    JUMP loop_elems
COMPARE_TAILS:
    LD temp_l
    CMP max_l
    BGE UPDATE_MAX ; temp_l > max_l
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
    ST $index
    LOOP len
    JUMP START
    JUMP STOP
STOP:
    LD max_l
    ST (ans_pointer)+
    LD max_h
    ST (ans_pointer)+
    HLT


ORG 0x6c6
WORD 0xFFFF
WORD 0x0001
WORD 0xFFFF
WORD 0xFF0F
WORD 0xFFFF
WORD 0x0000
WORD 0x00FF
WORD 0x0000
WORD 0xFFFF
WORD 0x000F