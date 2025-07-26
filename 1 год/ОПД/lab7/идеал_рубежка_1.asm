org 0x020
elems: word 3
cur: word 0x6c1
static_num: word 1210
smask: word 0x0800
posmask: word 0x07FF
negmask: word 0xF000
chet: word 12

main:
start:
ld (cur)
and smask
bzs if_pos
bzc if_neg

if_pos:
ld (cur)+
and posmask
st temp
st res_l
pos_sum_loop: ld res_l
add temp
st res_l
cla
adc res_h
st res_h
loop chet
jump pos_sum_loop
ld res_l
add static_num
st res_l
cla
adc res_h
st res_h
ld #12
st chet
jump to_array


if_neg:
ld (cur)+
or negmask
st temp
st res_l
cla
ld #0xff
st res_h
neg_sum_loop:
ld res_l
add temp
st res_l
ld #0xFF
adc res_h
st res_h
loop chet
jump neg_sum_loop
ld res_l
add static_num
st res_l
cla
adc res_h
st res_h
ld #12
st chet
jump to_array


array_pointer:word 0x0400
to_array:
ld res_l
st (array_pointer)+
ld res_h
st (array_pointer)+
cla
st res_l
st res_h
loop elems
jump main

prog_end: 
ld (array_pointer)
hlt

temp: word ?
res_h: word ?
res_l: word ?

org 0x6c1
word 0x1111
word 0x2222
word 0x0800
