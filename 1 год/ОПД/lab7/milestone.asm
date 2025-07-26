; 32-разрядная сумма
sum1: WORD 0x0
sum2: WORD 0
thingWeSUM: WORD 0

summing:
LD thingWeSUM
BLT if_neg

if_pos: ADD sum1
ST sum1
CLA
ADC sum2 ; AC + sum2 + C -> AC
ST sum2
JUMP RETURN

if_neg:
ADD sum1
ST sum1
LD #0xFF ; расширение знака до FFFF
ADC sum2
ST sum2
JUMP RETURN

RETURN:



; Эта программа ищет максимальный элемент массива, 
;состоящего из 16-битовых знаковых чисел. 
; Ответ лежит в ячейке 100.
ORG 0x100
max: WORD 0x8000 ; самое маленькое 16-разрядное число 
first_elem_addr: WORD 0x500
curr_elem_addr: WORD ?
; curr_elem_addr - для реентерабельности программы
arr_len: WORD 0x0005
elems_len: ?
; elems_lem - для реентерабельности программы

ORG 0x110
START:
CLA
ST max
LD first_elem_addr
St curr_elem_addr
LD arr_len
ST elems_len
MAIN_LOOP:
LD (curr_elem_addr)+ ; загружаем элемент массива
CMP max
BLT NEXT ; AC (element) < max, то есть максимум не обновляется
; то переход на следуюшую итерацию цикла
ST max ; AC >= max, то есть максимум обновляется
; обновляем максимум
NEXT:
    LOOP elems_len
    JUMP MAIN_LOOP
    HLT

ORG 0x500
WORD 0x1000
WORD 0x2141
WORD 0xFFFF
WORD 0x9241
WORD 0x5555



; Программа для нахождения максимального элемента массива,
; состоящего из 32-битовых знаковых чисел.
; Ответ лежит в ячейке 100.
ORG 0x100
max_head: WORD 0x8000
max_tail: WORD 0x0000 ; 800000000_16 = -2147483648_10
max: WORD 0x8000
cur_num_head: WORD ?
cur_num_tail: WORD ?
first_elem_addr: WORD 0x500
cur_elem_addr: WORD ? ; для реентерабельности программы
array_length: WORD 0x0005
arr_len: WORD ? ; для реентерабельности программы

ORG 0x120
START:
CLA
ST max_tail
ST cur_num_head
ST cur_num_tail
LD first_elem_addr
ST cur_elem_addr
LD array_length
ST arr_len
MAIN_LOOP:
LD (cur_elem_addr)+ ; Считываем начало и конец 32-разрядного элемента
ST cur_num_head ; 
LD (cur_elem_addr)+
ST cur_num_tail ;
LD cur_num_head
CMP max_head
BEQ COMPARE_TAILS
; если currentNumberHead == maxHead, то
; переходим к сравнению хвостов
BGE UpdateMaximum; currentNumberHead > maxHead
JUMP NEXT

COMPARE_TAILS:
LD cur_num_tail
CMP max_tail
BGE UpdateMaximum ; currentNumberHead == maxHead and currentNumberTail >= maxTail
JUMP NEXT

UpdateMaximum:
LD cur_num_head
ST max_head
LD cur_num_tail
ST max_tail

NEXT:
LOOP arr_len
JUMP MAIN_LOOP
HLT

ORG 0x500
WORD 0x2141
WORD 0x1000
WORD 0x9241
WORD 0xFFFF
WORD 0x2121
WORD 0x5555
WORD 0x2121
WORD 0x5556
WORD 0x9000
WORD 0xFFFF

; Суммирование каждого 2-ого элемента массива в 32-ух разрядную сумму
; Элементы — 14-ти разрядные числа
ORG 0x100
first_elem_addr: WORD 0x500
cur_elem_addr: WORD ? ; для реентерабельности программы
array_length: WORD 0x0005
last_elem_addr: WORD ?
arr_len: WORD ? ; для реентерабельности программы
SUM_0_15: WORD 0x0 ; Результат/Сумма (младшие 2 байта)
SUM_16_31: WORD 0x0 ; Результат/Сумма (старшие 2 байта)
cur_num_head: WORD ?
cur_num_tail: WORD ?
INDEX_K: WORD 0x2
SIGN_13: WORD 0x2000 ; Маска для проверки знака 14-разрядного числа 0010 0000 0000 0000
POS_MASK: WORD 0x1FFF ; Маска для очищения "мусора" в 
; старших разрядах и получения отрицательного числа
NEG_MASK: WORD 0xC000 ; Маска для получения отрицательного числа
START:
CLA ; Загружаем исходные данные в обновляемые ячейки и обнуляем ячейки результата
ST SUM_0_15
ST SUM_16_31
ST cur_num_head
ST cur_num_tail
LD array_length
ST arr_len
ADD $first_elem_addr
ST last_elem_addr
SUB $array_length


MAIN_LOOP:
CLA
ST 

