with System;
package Ada.Interrupts.Defintitions is

   procedure Default_Handler with
      Import,
      Link_Name => "interrupt_default";

   type Handler_Array is
      array (Interrupt_ID'First .. Interrupt_ID'Last) of System.Address;
   Handlers : Handler_Array := (others => Default_Handler'Address);

end Ada.Interrupts.Defintitions;