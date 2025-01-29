with System;
package Ada.Interrupts.Defintitions is

   procedure Default_Handler_Asm with
      Import,
      Convention => C,
      Link_Name => "default_interrupt_handler";

   procedure Default_Handler with
      Export,
      Convention => C,
      Link_Name => "default_interrupt_ada";

   type Handler_Array is
      array (Interrupt_ID'First .. Interrupt_ID'Last) of System.Address;
   Handlers : Handler_Array := (others => Default_Handler_Asm'Address);

end Ada.Interrupts.Defintitions;