.data
a: .word 1, 2, 3, 4, 5    # Array 'a'
b: .word 6, 7, 8, 9, 10   # Array 'b'
dot_product: .string "The dot product is: "  # String for printing

.text
main:
    # Load addresses of arrays 'a' and 'b'
    la x12, a
    la x13, b
    li x14, 5              # Loop counter
    addi x5, x0, 1         # Base case counter
    
    jal dot_product_recursive  # Call the recursive function
    
    mv x28, x12             # Save the result address

    li x10, 4
    la x11, dot_product     # Address of the string
    ecall

    li x10, 1
    mv x11, x28             # Result address
    ecall

    li x10, 10
    ecall

dot_product_recursive:
    beq x14, x5, base_case  # Check if reached base case

    addi x2, x2, -12
    sw x12, 8(x2)           # Save address of 'a'
    sw x13, 4(x2)           # Save address of 'b'
    sw x1, 0(x2)            # Save return address

    addi x12, x12, 4        # Increment 'a' pointer
    addi x13, x13, 4        # Increment 'b' pointer
    addi x14, x14, -1       # Decrement loop counter
    
    jal dot_product_recursive  # Call the recursive function

    lw x6, 8(x2)            # Save address of 'a'
    lw x7, 4(x2)            # Save address of 'b'
    lw ra, 0(x2)            # Save return address
    addi x2, x2, 12         # Save stack pointer

    lw x6, 0(x6)            # Load element from 'a'
    lw x7, 0(x7)            # Load element from 'b'

    mul x6, x6, x7          # Multiply elements
    add x12, x12, x6        # Add to result
    
    jr x1                   # Return to caller

base_case:
    lw x6, 0(x12)           # Load element from 'a'[0]
    lw x7, 0(x13)           # Load element from 'b'[0]
    
    mul x12, x6, x7         # Multiply last elements
    
    jr x1                   # Return to caller
