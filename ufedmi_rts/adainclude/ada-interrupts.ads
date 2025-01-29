with Interfaces;
with System;

package Ada.Interrupts is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   type Interrupt_ID is
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

   for Interrupt_ID use
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

   type IGD_Gate_Type is
      (TASK_GATE,
       INTERRUPT_GATE_16,
       TRAP_GATE_16,
       INTERRUPT_GATE_32,
       TRAP_GATE_32)
      with Size => 4;

   for IGD_Gate_Type use
      (TASK_GATE         => 2#0101#,
       INTERRUPT_GATE_16 => 2#0110#,
       TRAP_GATE_16      => 2#0111#,
       INTERRUPT_GATE_32 => 2#1110#,
       TRAP_GATE_32      => 2#1111#);

   type Interrupt_Gate_Descriptor is record
      Offset           : Interfaces.Unsigned_32;
      Segment_Selector : Interfaces.Unsigned_16;
      Gate_Type        : IGD_Gate_Type;
      Permission_Level : Interfaces.Unsigned_2;
      Present          : Boolean;
   end record with Size => 64, Pack;

   type Interrupt_Descriptor_Table is array (Natural range <>) of
      Interrupt_Gate_Descriptor;

   procedure Write_Interrupt_Gate_Descriptor
      (Descriptor : Interrupt_Gate_Descriptor;
       Addr       : System.Address);

end Ada.Interrupts;