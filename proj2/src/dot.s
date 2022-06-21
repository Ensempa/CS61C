.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

	# Prologue
    addi sp, sp, -8
    sw ra, 4(sp)
    sw s0, 0(sp)
    addi t0, x0, 1 #t0=1
    blt a2, t0 exception1 #length < 1
    blt a3, t0 exception2 #stride < 1
    blt a4, t0 exception2 #stride < 1
    add t0, x0, x0 #t0 to track the number
    add s0, x0, x0 #s2 to save the dot product
    #address span
    slli a3, a3, 2
    slli a4, a4, 2
    j loop_start


loop_start:
    beq t0, a2, loop_end
    lw t1 0(a0)
    lw t2 0(a1)
    mul t1, t1, t2
    add s0, s0, t1 #add the current product
    add a0, a0, a3
    add a1, a1, a4
    addi t0, t0, 1
    j loop_start


loop_end:
	# Epilogue
    srai a3, a3, 2
    srai a4, a4, 2
    add a0, x0, s0
    lw s0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
	ret
    
exception1:
    li a0 36
    j exit
    
exception2:
    li a0 37
    j exit
