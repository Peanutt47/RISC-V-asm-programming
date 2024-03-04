.data
a:  .word   1, 2, 3, 4, 5
b:  .word   6, 7, 8, 9, 10
dot_product: .string "The dot product is: "

.text
MAIN:
    # Registers NOT to be used: x0-x4 and x10-x17
    # Registers available for use: x21-x9 and x18-x31
    
    li x21, 5            # x21 = size = 5 (loop counter)
    li x22, 0            # x22 = sum of products (sop) int sop = 0;
    li x23, 0            # x23 = loop index (i) int i = 0;
    
    la x24, a            # Load the address of a[] into x24
    la x25, b            # Load the address of b[] into x25

LOOP:
    bge x23, x21, EXIT    # Break loop if i >= size
    
    slli x26, x23, 2              # Multiply i by 4 (word size) and store in x26
    add x27, x26, x24             # Calculate address of a[i] and store in x27
    lw x28, 0(x27)                # Load a[i] into x28
    
    add x29, x26, x25             # Calculate address of b[i] and store in x29
    lw x30, 0(x29)                # Load b[i] into x30
    
    mul x31, x28, x30             # Multiply a[i] by b[i] and store in x31
    add x22, x22, x31             # Add result to sop
    
    addi x23, x23, 1              # Increment loop index (i)
   
    j LOOP
    
EXIT:
    li a0, 4                    # Load syscall number for print string
    la a1, dot_product          # Load address of dot_product string
    ecall                       # Print dot_product label

    li a0, 1                    # Load syscall number for print integer
    mv a1, x22                  # Load sop into argument register a1
    ecall                       # Print sop
    
    li a0, 10                   # Load syscall number for exit
    ecall                       # Exit program
