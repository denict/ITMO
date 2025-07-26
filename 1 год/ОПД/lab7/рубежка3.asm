; из 22 разрядных перевести в 32 разряда, применить формулу f(x)=13x+5555
ORG 0x20
addr: WORD 0x6dd
elems: WORD 3
MLT: WORD 1 ; складываем 12 раз, поменять 1 на 12
value: WORD 5555 ; сложение
sign_mask: WORD 0x0020 ; проверка 22 бита 0000 0000 0010 0000
pos_mask: WORD 0x001F ; 0000 0000 0001 1111
neg_mask: WORD 0xFFC0 ; 1111 1111 1100 0000
index: WORD 1; будем работать со всеми числами
arr_ans: WORD 0x400
res_l: WORD ?
res_h: WORD ?
temp_l: WORD ?
temp_h: WORD ?
START:
    LD (addr)+
    ST res_l
    LD (addr)+
    ST res_h
    AND sign_mask
    BEQ if_pos
    BNE if_neg

if_pos:
    LD res_h
    AND pos_mask ; очищаем мусор в старших разрядах
    ST res_h
    ST temp_h
    LD res_l
    ST temp_l
    loop_pos_sum: 
    LD res_l
    ADD temp_l
    ST res_l
    CLA
    ADC res_h
    ADD temp_h
    ST res_h
    LOOP MLT
    JUMP loop_pos_sum
    NOP ; добавить сложение с value
    LD #1
    ST MLT
    JUMP to_array

if_neg:
    LD res_h
    OR neg_mask
    ST res_h
    ST temp_h
    LD res_l
    ST temp_l
    loop_neg_sum:
        LD res_l
        ADD temp_l
        ST res_l
        CLA
        ADC res_h
        ADD temp_h
        ST res_h
        LOOP MLT
        JUMP loop_neg_sum
        NOP ; добавить сложение с value
        LD #1
        ST MLT
        JUMP to_array

to_array:
    LD res_l
    ST (arr_ans)+
    LD res_h
    ST (arr_ans)+
    LOOP elems
    JUMP START
    JUMP STOP

STOP:
    HLT

ORG 0x6dd
WORD 0x1234
WORD 0x0022
WORD 0x1000
WORD 0xF001
WORD 0x8000
WORD 0x0001

    @ LD res_l
    @ ADD value
    @ ST res_l
    @ CLA
    @ ADC res_h
    @ ST res_h