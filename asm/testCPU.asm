.data
aword: .word 0x7fffffff
bword: .word 8
c: .word 4
d: .word

.text
lui $t1,16
lui $t2,16
lui $t7,0           #if j and beq correct executed, keep 0
beq $t1,$t2,label1
nop
add $t7,$t1,$t2     #skip

label1:
lw $t3,4            #read num 8
lw $t6,0            #read num 0x7fffffff
sw $t1,12
j label2
nop
add $t7,$t1,$t2     #skip

label2:
add $t4,$t1,$t2
add $t6,$t3,$t6     #overflow
addiu $t5,$t3,32
divu $t1,$t3
nop