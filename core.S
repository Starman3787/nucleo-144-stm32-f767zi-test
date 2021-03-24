.syntax unified
.cpu cortex-m7
.fpu softvfp
.thumb

// Global values
.global reset_handler 

/*
 * The reset handler, called on reset.
 */
 .type reset_handler, %function
 reset_handler:
    // Set the stack pointer to the end of the stack
    LDR r0, =_estack
    MOV sp, r0

// Copy data from flash to RAM data init section
// R2 will store the progress along the sidata section
MOVS r0, #0
// Load the start and end addresses of the data section,
// and the start of the data init section
LDR r1, =_sdata
LDR r2, =_edata
LDR r3, =_sidata
B   copy_sidata_loop

copy_sidata:
    // Offset the data init section by our copy progress
    LDR     r4, [r3, r0]
    // Copy the current word into data and increment
    STR     r4, [r1, r0]
    ADDS    r0, r0, #4

copy_sidata_loop:
    // Unless the whole data section has been copied,
    // copy the next word from sidata to data
    ADDS    r4, r0, r1
    CMP     r4, r2
    BCC     copy_sidata

// Once the data section has been copied into RAM,
// start filling the BSS section with 0s
MOVS    r0, #0
LDR     r1, =_sbss
LDR     r2, =_ebss
B       reset_bss_loop

// Fill the BSS segment with 0s
reset_bss:
    // Store a 0 and increment by a word
    STR     r0, [r1]
    ADDS    r1, r1, #4

reset_bss_loop:
    // R1 is used to count progress
    // The next word should be reset and R1 incremented if not complete
    CMP r1, r2
    BCC reset_bss

    // Branch to the 'main' method
    B   main
.size reset_handler, .-reset_handler