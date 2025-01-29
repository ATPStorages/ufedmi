global default_interrupt_handler
extern default_interrupt_ada

section .kernel

default_interrupt_handler:
  mov eax, 0xDEADC0DE
  ud2
  hlt