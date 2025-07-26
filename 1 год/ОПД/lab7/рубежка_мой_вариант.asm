@ Задание №1. Разработать программу для работы с элементами массива M, в которой:
@ 1. Массив имеет следующие характеристики:
@ - адрес начала массива в памяти БЭВМ - 0x6d3;
@ - число измерений исходного массива - 1;
@ - количество элементов исходного массива - 16;
@ - каждый элемент является знаковым числом с разрядностью 14 бит;
@ - нумерация элементов начинается с 4;
@ - элементы хранятся в массиве по границам слов, нет необходимости в плотной упаковке;
@ 2. Для элементов массива необходимо вычислить 32-х битное значение функции:
@ - формула функции F(Mi) = 8 * Mi + 5221;
@ - 32-битный результат необходимо поместить в другой массив по адресу 0x400
@ - Результатом является массив 32-х разрядных чисел равным количеству элементов исходного массива.
@ Примечание: все числа представлены в десятичной системе счисления, если явно не указано иное.
ORG 0x20
MULTIPLY: WORD 7 ; потому что и так есть число, поэтому множитель уменьшается на 1
CHISLO: WORD 5221
INDEX: WORD 4
LEN: WORD 16
SIGN_MASK: WORD 0x2000 ; 0010 0000 0000 0000
POS_MASK: WORD 0x1FFF
NEG_MASK: WORD 0xC000
ARRAY: WORD 0x6d3
ARRAY_ANSWER: WORD 0x400
res_l: WORD ?
res_h: WORD ?
temp: WORD ?
START:
    CLA
    LD (ARRAY)
    AND SIGN_MASK
    BNE IF_NEG
IF_POS:
    LD (ARRAY)+
    AND POS_MASK
    ST res_l
    ST temp
    CLA
    ST res_h ; для очистки страшего байта
    pos_sum_loop:
        LD res_l
        ADD temp
        ST res_l
        CLA
        ADC res_h ; если произошёл переход из 15 бита (старшего разряда младшего слова) в 16 (младший разряд старшего слова)
        ST res_h
        LOOP MULTIPLY
        JUMP pos_sum_loop
        LD res_l
        ADD CHISLO
        ST res_l
        CLA
        ADC res_h
        ST res_h
        LD #7 ; восстанавливаем множитель
        ST MULTIPLY
        JUMP TO_ARRAY

IF_NEG:
    LD (ARRAY)+
    OR NEG_MASK
    ST res_l
    ST temp
    CLA
    LD #0xFF
    ST res_h ; 0xFFFF в старшем слове
    neg_sum_loop:
        LD res_l
        ADD temp
        ST res_l
        CLA
        LD #0xFF
        ADC res_h
        ST res_h
        loop MULTIPLY
        JUMP neg_sum_loop
        LD res_l
        ADD CHISLO
        ST res_l
        CLA
        ADC res_h
        ST res_h
        LD #7
        ST MULTIPLY
        JUMP TO_ARRAY


TO_ARRAY:
    LD res_l
    ST (ARRAY_ANSWER)+
    LD res_h
    ST (ARRAY_ANSWER)+
    CLA
    ST res_l
    ST res_h
    loop LEN ; уменьшаем длину на 1
    JUMP START
STOP:
    HLT

ORG 0x6d3
WORD 0x1000
WORD 0x9000
WORD 0x0001
WORD 0x0010
WORD 0x0100
WORD 0x0200
WORD 0x0400
WORD 0x1000
WORD 0x2000
WORD 0x4000
WORD 0xFFFF
WORD 0xD011
WORD 0xC001
WORD 0x2111
WORD 0x2222
WORD 0x3111