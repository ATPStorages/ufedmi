with System.Low_Level; use System.Low_Level;
package body System.PIC is
   procedure Beep_Speaker (Frequency : Unsigned_32) is
      Division    : constant Unsigned_32 := 1193180 / Frequency;
      Speaker_Out : Unsigned_16;
   begin
      Write_Pin (PIC_COMMAND, 16#B6#);
      Write_Pin (PIC_CHANNEL_2_DATA, Unsigned_16 (Division));
      Write_Pin (PIC_CHANNEL_2_DATA, Unsigned_16 (Shift_Right (Division, 8)));
      Speaker_Out := Read_Pin (PC_SPEAKER);
      if Speaker_Out /= (Speaker_Out or 3) then
         Write_Pin (PC_SPEAKER, Speaker_Out or 3);
      end if;
   end Beep_Speaker;

   procedure Stop_Speaker is
   begin
      Write_Pin (PC_SPEAKER, Read_Pin (PC_SPEAKER) and 16#FC#);
   end Stop_Speaker;
end System.PIC;