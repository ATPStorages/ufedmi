with System.Storage_Elements; use System.Storage_Elements;
with Interfaces; use Interfaces;

package body Ada.Interrupts is

   procedure Write_Interrupt_Gate_Descriptor
      (Descriptor : Interrupt_Gate_Descriptor;
       Addr       : System.Address)
   is
      IGD_Chunk : Chunk (0 .. 7) with Address => Addr;
   begin
      --  Offset
      IGD_Chunk (0) := Byte (Descriptor.Offset);
      IGD_Chunk (1) := Byte (Shift_Right (Descriptor.Offset, 8));
      IGD_Chunk (6) := Byte (Shift_Right (Descriptor.Offset, 16));
      IGD_Chunk (7) := Byte (Shift_Right (Descriptor.Offset, 24));
      --  Segment Selector
      IGD_Chunk (2) := Byte (Descriptor.Segment_Selector);
      IGD_Chunk (3) := Byte (Shift_Right (Descriptor.Segment_Selector, 8));
      --  Misc
      IGD_Chunk (5) :=
         Byte (Descriptor.Gate_Type'Enum_Rep) or
         Byte (Shift_Left (Unsigned_8 (Descriptor.Permission_Level), 5)) or
         Byte (Shift_Left (Unsigned_8 (Descriptor.Present'Enum_Rep), 7));
   end Write_Interrupt_Gate_Descriptor;

end Ada.Interrupts;