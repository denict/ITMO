; Программа находит максимальный нечётный элемент в массиве
ORG 0x55C 
ARR_FIRST_ELEM: WORD 0x0573
ARR_POINTER_ELEM: WORD 0xA000
ARR_LENGTH: WORD 0x4000
RESULT: WORD 0xE0000
LD #0x40
SWAB ; 0040 -> 4000
ASL ; AC15 --> C, 0 --> AC0.4000 --> 8000
ST RESULT ; 8000 -> RESULT
LD #0x05
ST ARR_LENGTH
LD ARR_FIRST_ELEM ; 0573 -> AC
ST ARR_POINTER_ELEM ; 0573 -> ARR_POINTER_ELEM
START: LD (ARR_POINTER_ELEM)+ ; 0573 -> AC
ROR ; 0573 -> 02B9
BCS SRAVNENIE ; младший разряд равен 1, число нечетное, дальше идём по циклу и перепрыгиваем возрат
BR RETURN ; 
SRAVNENIE: ROL ; Возврат младшего разряда, который был в Carry
CMP RESULT
BLT RETURN ; Если значение в аккумуляторе (элемент массива) меньше результата, то происходит переход на LOOP
ST RESULT
RETURN: LOOP ARR_LENGTH
BR START ; Переход на новый цикл
HLT
ARRAY: WORD 0x7564, 0x8563, 0x0281, 0xD566, 0x0



; Суммирование каждого элемента двумерного массива размерностью [7][7] с 
;индексом i с шагом 3, индексом j с шагом 2 и при условии, что элемент кратен 4, 
;состоящего из 20-разрядных элементов, с формированием 32-разрядного результата
;Формат хранения элементов в массиве: мл_байты_0; ст_байты_0; мл_байты_1; ст_байты_1; ...

ORG 0x10
arr_addr: WORD 0x300
cur_elem_addr: WORD ?
flat_dimension: WORD 0x7 ; размер
linear_index_max_border: WORD ? ; максимальмальная граница линейного индекса
count: WORD ? ; счётчик
index_i: WORD 0x ; индекс i
index_j: WORD 0x ; индекс j
index_j_max_border: WORD ? ; фактическая граница для индекса j (т.к храним мл_байт, ст_байт в элементе)
step_i: WORD 0x3 ; шаг i
step_j: WORD 0x2 ; шаг j
step_i_f: WORD ? ; шаг для первого случая
step_j_f: WORD ? ; шаг для первого случая
step_j_actual: WORD ? ; шаг для корректного прохода по элементам в строке
linear_index: WORD 0x0
sum1: WORD 0x0
sum2: WORD 0x0
START:
CLA
ST sum1
ST sum2
LD step_i
DEC
SR step_i_f
LD step_j
ASL
ST step_j_f ; фактический шаг это step_j * 2
ASR ; SUB #2



; 12 бит. каждый k-ый элемент. k с ву2 
; добавить проверку по индексам i четное j кратно 5 массив 4x10
ORG 0x10
arr_addr: WORD 0x500
arr_end: WORD 0x528
pointer: WORD ?
step: WORD ?
sum_1: WORD 0x0
st_2: WORD 0x0
mask_cmp: WORD 0x0800 ; AND 0000 1000 0000 0000 - 12 бит
mask_pls: WORD 0xF000 ; AND 1111 0000 0000 0000 - 4 бит - расширение знака для положительных
mask_neg: WORD 0x0FFF ; OR 0000 0000 0000 1111 - расширение знака для отрицательных

START:
    CLA
    ST pointer
    ST step
    LD arr_addr
    ST pointer

IN_VU:
    IN 0x5
    AND #0x40
    BEQ IN_VU
    IN 0x4
    ST step
    DEC
    ADD pointer
    ST pointer
    JUMP CHECK

ST_INC:
    LD pointer
    ADD step
    ST pointer

CHECK:
    CMP arr_end
    BMI STOP

NEXT:
    LD (pointer)
    AND mask_cmp
    BEQ if_pos