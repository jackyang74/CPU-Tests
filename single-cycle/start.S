.global _reset   
.set noat
.set noreorder


_reset:
    #add,sub
    addi    $t0,$zero,15
    addiu   $t1,$zero,20
    
    add     $t2,$t0,$t1
    sub     $t2,$t2,$t1
    bne     $t0,$t2,error
    
    addu    $a3,$a0,$t1
    subu    $t3,$t3,$t0
    bne     $t1,$a3,error    
    #logic
    li      $t0,0x1234 #a
    li      $t1,0x2345 #b
    li      $t2,0x3456 #c
    li      $t3,0x4567 #d
    li      $t4,0x5678 #e
    #((~((((a&b)|c)^d)|e))&0xffff)|a^b
    and     $a0,$t0,$t1
    or      $a0,$a0,$t2
    xor     $a0,$a0,$t3
    nor     $a0,$a0,$t4
    andi    $a0,0xffff
    ori     $a0,0x1234
    xori    $a0,0x2345
    li      $k0,0xffffdcf3
    bne     $a0,$k0,error
    
    #shift
    li      $t0,1
    li      $t1,5
    sll     $t0,5
    sllv    $t0,$t0,$t1
    srl     $t0,5
    srlv    $t0,$t0,$t1
    li      $k0,1
    bne     $t0,$k0,error
    
    li      $t0,0x80000000
    li      $t1,2
    sra     $t0,1
    srav    $t0,$t0,$t1
    li      $k0,0xf0000000
    bne     $t0,$k0,error
    
hang:
    b       hang
    nop
error:
    li      $gp,0 #0 indicates error
    nop
correct:
    li      $gp,1 #1 indicates right
    nop

