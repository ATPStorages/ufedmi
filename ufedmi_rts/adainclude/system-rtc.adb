with System.Low_Level; use System.Low_Level;
package body System.RTC is

   function Read_RTC_Register (Register : RTC_Register) return Unsigned_16 is
   begin
      Write_Pin (CMOS_COMMAND, 16#80# or Register'Enum_Rep);
      return Read_Pin (CMOS_DATA);
   end Read_RTC_Register;

   function Poll_Update_Flag return Boolean is
   begin
      return (Read_RTC_Register (STATUS_A) and 16#80#) /= 0;
   end Poll_Update_Flag;

   function Read_RTC return CMOS_RTC_Snapshot is
      Snapshot : CMOS_RTC_Snapshot;
   begin
      loop
         exit when not Poll_Update_Flag;
      end loop;
      Snapshot.Second := Read_RTC_Register (SECONDS);
      Snapshot.Minute := Read_RTC_Register (MINUTES);
      Snapshot.Hour := Read_RTC_Register (HOURS);
      Snapshot.Day_Of_Month := Read_RTC_Register (DAY_OF_MONTH);
      Snapshot.Month := Read_RTC_Register (MONTH);
      Snapshot.Year := Read_RTC_Register (YEAR);
      return Snapshot;
   end Read_RTC;

end System.RTC;