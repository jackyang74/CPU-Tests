.text
.globl _reset   
.set noat
.set noreorder

#if the program excutes without error, then $gp will be set 1,  otherwise 0
#please check valule of $gp in your simulation wave window


_reset:
    li      $gp,0 #0 indicates error
    #add,sub
    addi    $t0,$zero,15
    addiu   $t1,$zero,20
    
    add     $t2,$t0,$t1
    sub     $t2,$t2,$t1
    bne     $t0,$t2,error
    
    addu    $t3,$t0,$t1
    subu    $t3,$t3,$t0
    bne     $t1,$t3,error
    # seb,seh
    li      $t0,0xabca
    seb     $t1,$t0
    li      $k0,0xffffffca
    bne     $k0,$t1,error
    
    li      $t0,0xab7a
    seb     $t1,$t0
    li      $k0,0x7a
    bne     $k0,$t1,error
    
    li      $t0,0x1abc7
    seh     $t1,$t0
    li      $k0,0xffffabc7
    bne     $k0,$t1,error
    
    li      $t0,0x77bc7
    seh     $t1,$t0
    li      $k0,0x7bc7
    bne     $k0,$t1,error
    
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
    li      $k0,0xb9f3
    bne     $a0,$k0,error
    #clo,clz
    li      $t0,0xff100000
    li      $k0,8
    clo     $t1,$t0
    bne     $k0,$t1,error
    
    li      $t0,0x001fffff
    li      $k0,11
    clz     $t1,$t0
    bne     $k0,$t1,error
    
    
    #shift
    li      $t0,1
    li      $t1,5
    sll     $t0,$t0,5
    sllv    $t0,$t0,$t1
    srl     $t0,$t0,5
    srlv    $t0,$t0,$t1
    li      $k0,1
    bne     $t0,$k0,error
    
    li      $t0,0x80000000
    li      $t1,2
    sra     $t0,$t0,1
    srav    $t0,$t0,$t1
    li      $k0,0xf0000000
    bne     $t0,$k0,error
    
    li      $t0,0xf0f0f0f0
    li      $t1,4
    rotr    $t0,$t0,4
    rotrv   $t0,$t0,$t1
    li      $k0,0xf0f0f0f0
    bne     $t0,$k0,error
    #condition testing
    li      $t0,32
    li      $t1,50
    li      $k0,1
    
    slt     $t2,$t0,$t1
    bne     $t2,$k0,error
    sltu    $t2,$t1,$t0
    bnez    $t2,error
    
    slti    $t2,$t0,31
    bnez    $t2,error
    slti    $t2,$t0,32
    bnez    $t2,error
    #jumps and branches
    li      $t0,1
    li      $t1,2
    li      $t2,1
    li      $t3,-1
    beq     $t0,$t1,error
    bgez    $t3,error
    bgtz    $t3,error
    blez    $t0,error
    bltz    $t0,error
    bne     $t0,$t2,error
    

correct:
    li      $gp,1 #1 indicates right
hang:
    b       hang
    nop
error:
    li      $gp,0 #0 indicates error
    