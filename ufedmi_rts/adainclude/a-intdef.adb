--  with Ada.Text_IO;
with System.Low_Level;
with System.Machine_Code;
package body Ada.Interrupts.Defintitions is

   procedure Default_Handler is
   begin
      System.Machine_Code.Asm ("leave", Volatile => True);
      System.Low_Level.Halt;
   end Default_Handler;

end Ada.Interrupts.Defintitions;