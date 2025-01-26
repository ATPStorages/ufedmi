with Interfaces;

package System.Low_Level is

   subtype u2 is Interfaces.Unsigned_16;

   procedure Disable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   procedure Enable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   procedure Halt;

   function A20_Line_Status return u2;

end System.Low_Level;