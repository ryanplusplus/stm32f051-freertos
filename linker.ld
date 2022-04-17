MEMORY {
  rom (rx) : ORIGIN = 0x08000000, LENGTH = 64K
  ram (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

ENTRY(reset_handler);

SECTIONS {
  .text : {
    . = ALIGN(4);
    KEEP(*(.vectors))
    *(.text*)
    *(.rodata*)
    . = ALIGN(4);
  } > rom

  _data_rom = LOADADDR(.data);

  .data : {
    . = ALIGN(4);
    _data_begin = .;
    *(.data*)
    . = ALIGN(4);
    _data_end = .;
  } > ram AT > rom

  .bss : {
    . = ALIGN(4);
    _bss_begin = .;
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _bss_end = .;
  } > ram

  _stack_top = ORIGIN(ram) + LENGTH(ram);
}
