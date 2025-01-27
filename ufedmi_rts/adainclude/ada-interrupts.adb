with Ada.Text_IO;
package body Ada.Interrupts is

   procedure Base_Interrupt is
   begin
      Ada.Text_IO.Put_Line ("Interrupt");
   end Base_Interrupt;

end Ada.Interrupts;