with System.Low_Level; use System.Low_Level;
package body System.RTC is

   function Read_RTC_Register (Register : RTC_Register) return Unsigned_16 is
   begin
      Write_Pin (CMOS_COMMAND, Register'Enum_Rep);
      return Read_Pin (CMOS_DATA);
   end Read_RTC_Register;

   procedure Write_RTC_Register (Register : RTC_Register; Value : Unsigned_8)
   is
   begin
      Write_Pin (CMOS_COMMAND, Register'Enum_Rep);
      Write_Pin (CMOS_DATA, Unsigned_16 (Value));
   end Write_RTC_Register;

   function Poll_Update_Flag return Boolean is
   begin
      return (Read_RTC_Register (STATUS_A) and 16#80#) /= 0;
   end Poll_Update_Flag;

   function BCD_To_Binary (Value : Unsigned_16) return Unsigned_16 is
   begin
      return (Value and 16#0F#) + ((Value / 16) * 10);
   end BCD_To_Binary;

   function Read_RTC return CMOS_RTC_Snapshot is
      Snapshot : CMOS_RTC_Snapshot := (others => 0);
   begin
      Snapshot.D := Read_RTC_Register (STATUS_D);
      if Snapshot.D = 0 then
         --  Battery is dead
         return Snapshot;
      end if;

      loop
         exit when not Poll_Update_Flag;
      end loop;
      Snapshot.Second := Read_RTC_Register (SECONDS);
      Snapshot.Minute := Read_RTC_Register (MINUTES);
      Snapshot.Hour := Read_RTC_Register (HOURS);
      Snapshot.Day_Of_Month := Read_RTC_Register (DAY_OF_MONTH);
      Snapshot.Month := Read_RTC_Register (MONTH);
      Snapshot.Year := Read_RTC_Register (YEAR);
      Snapshot.Century := Read_RTC_Register (CENTURY);
      Snapshot.A := Read_RTC_Register (STATUS_A);
      Snapshot.B := Read_RTC_Register (STATUS_B);
      Snapshot.C := Read_RTC_Register (STATUS_C);
      if (Snapshot.B and 16#04#) = 0 then
         Snapshot.Second := BCD_To_Binary (Snapshot.Second);
         Snapshot.Minute := BCD_To_Binary (Snapshot.Minute);
         Snapshot.Hour := BCD_To_Binary (Snapshot.Hour);
         Snapshot.Day_Of_Month := BCD_To_Binary (Snapshot.Day_Of_Month);
         Snapshot.Month := BCD_To_Binary (Snapshot.Month);
         Snapshot.Year := BCD_To_Binary (Snapshot.Year);
         if Snapshot.Century /= 0 then
            Snapshot.Century := BCD_To_Binary (Snapshot.Century);
         end if;
      end if;
      return Snapshot;
   end Read_RTC;

   function Read_Seconds return Duration is
      Snapshot : constant CMOS_RTC_Snapshot := Read_RTC;
   begin
      return Duration
         (Snapshot.Second + (Snapshot.Minute * 60) + (Snapshot.Hour * 3600));
   end Read_Seconds;

end System.RTC;