ENTRY (loader)
SECTIONS
{
  . = 0x00007E00;
  .mbheader : {
    *(.mbheader)
  }
  .text : {
    *(.text)
  }
  .rodata ALIGN (0x1000) : {
    *(.rodata)
  }
  .data ALIGN (0x1000) : {
    *(.data)
  }
  .bss : {
    sbss = .;
    *(COMMON)
    *(.bss)
    ebss = .;
  }
  . = 0x00000500;
  .kernel : {
    *(.kernel)
  }
}
