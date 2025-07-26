ORG 0x20
elems: word 0x3
plus: word 1210
multiply: WORD 12
array12_pointer: WORD 0x6c1
sign_mask: word 0x0800 ; 0000 1000 0000 0000
neg_mask: word 0xF000 ; 1111 0000 0000 0000
pos_mask: word 0x0FFF ; 12 битовые числа
temp: WORD ?
res_l: WORD ?
res_h: WORD ?
START:
ld (array12_pointer)
and sign_mask
BEQ if_pos
BNE if_neg

if_pos:
  LD (array12_pointer)+
  AND pos_mask ; очищаем мусор в старших разрядах
  ST temp
  ST res_l
  pos_sum_loop: ; складываем число с самим собой 13 раз
    ld res_l
    add temp 
    st res_l
    CLA
    ADC res_h
    st res_h
    loop multiply
    JUMP pos_sum_loop
    LD res_l
    add plus
    st res_l
    CLA
    ADC res_h
    st res_h
    LD #12
    ST multiply
    JUMP to_array

if_neg:
    LD (array12_pointer)+
    OR neg_mask ; расширяем знак
    ST temp
    ST res_l
    CLA
    LD #0xff
    ST res_h
    neg_sum_loop: ; складываем число с самим собой 13 раз
      ld res_l
      add temp 
      st res_l
      CLA
      LD #0xff
      ADC res_h
      ST res_h
      loop multiply
      JUMP neg_sum_loop
      LD res_l
      ADD plus
      ST res_l
      CLA
      ADC res_h
      ST res_h
      LD #12
      ST multiply
      JUMP to_array

array_pointer: WORD 0x400
to_array:
    LD res_l ; младшая часть
    ST (array_pointer)+
    LD res_h ; старщая часть
    ST (array_pointer)+
    CLA
    st res_l
    st res_h
    loop elems
    JUMP START
STOP:
    ld (array_pointer)
    HLT

ORG 0x6c1
word 0x1111
word 0x2222
word 0x3333
WORD 0x0800 