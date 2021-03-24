/* Define the end of RAM and the limit of stack memory */
/* (512KB SRAM on the STM32F767ZI line, 524288 = 0x80000) */
/* (RAM starts at address 0x20000000) */
ENTRY(reset_handler)

_estack = 0x20080000;

/* Set minimum size for stack and dynamic memory. */
/* (1KB) */
_Min_Leftover_RAM = 0x400;

MEMORY
{
    FLASH ( rx )        : ORIGIN = 0x08000000, LENGTH = 2048K
    RAM ( rxw )         : ORIGIN = 0x20000000, LENGTH = 512K
}

SECTIONS
{
    /* Put vector table at the start of flash. */
    .vector_table :
    {
        . = ALIGN(4);
        KEEP (*(.vector_table))
        . = ALIGN(4);
    } >FLASH

    /* Main program code. */
    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        . = ALIGN(4);
    } >FLASH

    /* Read only data. */
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } >FLASH

    /* Variables etc. */
    _sidata = .;
    .data : AT(_sidata)
    {
        . = ALIGN(4);
        /* Start and end locations for 'data'. */
        _sdata = .;
        *(.data)
        *(.data*)
        _edata = .;
        . = ALIGN(4);
    } >RAM

    /* Similar to the 'data' section, but
       initialised to 0s at the start */
    .bss :
    {
        . = ALIGN(4);
        /* Start and end locations for 'bss'. */
        _sbss = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } >RAM

    /* Space for the stack. */
    .dynamic_allocations :
    {
        . = ALIGN(4);
        _ssystem_ram = .;
        . = . + _Min_Leftover_RAM;
        . = ALIGN(4);
        _esystem_ram = .;
    } >RAM
}