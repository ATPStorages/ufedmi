package Ada.Interrupts is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type Interrupt is
      (DIVIDE_ERROR,
       NON_MASKABLE_INTERRUPT,
       BREAKPOINT,
       INTO_OVERFLOW,
       OUT_OF_BOUNDS,
       INVALID_OPCODE,
       DEVICE_NOT_AVAILABLE,
       DOUBLE_FAULT,
       COPROCESSOR_SEGMENT_OVERRUN,
       INVALID_TSS,
       SEGMENT_NOT_PRESENT,
       STACK_SEGMENT_FAULT,
       GENERAL_PROTECTION_FAULT,
       PAGE_FAULT,
       X87_FPU_ERROR,
       ALIGNMENT_CHECK,
       MACHINE_CHECK,
       SIMD_FLOATING_POINT_ERROR)
      with Size => 8;

   for Interrupt use
      (DIVIDE_ERROR                => 16#00#,
       NON_MASKABLE_INTERRUPT      => 16#02#,
       BREAKPOINT                  => 16#03#,
       INTO_OVERFLOW               => 16#04#,
       OUT_OF_BOUNDS               => 16#05#,
       INVALID_OPCODE              => 16#06#,
       DEVICE_NOT_AVAILABLE        => 16#07#,
       DOUBLE_FAULT                => 16#08#,
       COPROCESSOR_SEGMENT_OVERRUN => 16#09#,
       INVALID_TSS                 => 16#0A#,
       SEGMENT_NOT_PRESENT         => 16#0B#,
       STACK_SEGMENT_FAULT         => 16#0C#,
       GENERAL_PROTECTION_FAULT    => 16#0D#,
       PAGE_FAULT                  => 16#0E#,
       X87_FPU_ERROR               => 16#10#,
       ALIGNMENT_CHECK             => 16#11#,
       MACHINE_CHECK               => 16#12#,
       SIMD_FLOATING_POINT_ERROR   => 16#13#);

end Ada.Interrupts;