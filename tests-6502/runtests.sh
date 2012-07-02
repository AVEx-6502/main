#!/bin/sh

export executavel=$1


asm_test()
{
  echo "======> A testar agora: " `ls $1.asm`
  cl65 -t none $1.asm -o $1
  rm $1.o
  $executavel -bios $1 2>/dev/null | diff - $1.out
}

asm_seeres()
{
  echo "======> A testar agora: " `ls $1.asm`
  cl65 -t none $1.asm -o $1
  $executavel -bios $1 2>/dev/null
}

asm_genout()
{
  echo "======> A testar agora: " `ls $1.asm`
  cl65 -t none $1.asm -o $1
  $executavel -bios $1 2>/dev/null > $1.out
}

asm_test unittests/smc_test
asm_test unittests/brk_test
asm_test unittests/bcd_test
asm_test unittests/di_test
asm_test unittests/plp_php_test
asm_test unittests/add_sub_test
asm_test unittests/v_test
asm_test unittests/bit_test
asm_test unittests/6502_lib
asm_test unittests/stack
asm_test unittests/bcs_test
asm_test unittests/brcond
asm_test unittests/inc_dec_test
asm_test unittests/load_store_test
asm_test unittests/shrot_test_sostack
asm_test unittests/beq_test
asm_test unittests/carry_test
asm_test unittests/lsr_test
asm_test unittests/bitwise_test  
asm_test unittests/cmps_test 
asm_test unittests/rotate_test
asm_test unittests/sub_test
asm_test unittests/bmi_test
asm_test unittests/inc_dec_test2
asm_test unittests/load_store_test2
asm_test unittests/jmptest
asm_test unittests/shrot_test 
asm_test unittests/txldsttest
asm_test unittests/jmp_ind_test
asm_test garbage/print_test
asm_test unittests/good_bcd_test
asm_test unittests/addr_quirks

# Undocumented instructions tests
asm_test unittests/undocumented/nop_test
asm_test unittests/undocumented/lax_sax_test
