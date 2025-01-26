with Interfaces; use Interfaces;

package System.Low_Level is

   type CPU_Pin is
      (PS_2_DATA,
       PS_2_REGISTER,
       CMOS_COMMAND,
       CMOS_DATA)
      with Size => 8;

   for CPU_Pin use
      (PS_2_DATA     => 16#60#,
       PS_2_REGISTER => 16#64#,
       CMOS_COMMAND  => 16#70#,
       CMOS_DATA     => 16#71#);

   function Read_Pin (Pin : CPU_Pin) return Unsigned_16;
   procedure Write_Pin (Pin : CPU_Pin; Value : Unsigned_16);

   procedure Disable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   procedure Enable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   function A20_Line_Status return Unsigned_16;
   procedure Halt;

end System.Low_Level;