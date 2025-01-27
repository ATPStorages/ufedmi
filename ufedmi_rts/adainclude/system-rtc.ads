with Interfaces; use Interfaces;

package System.RTC is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type CMOS_RTC_Snapshot is record
      Second       : Unsigned_16;
      Minute       : Unsigned_16;
      Hour         : Unsigned_16;
      Weekday      : Unsigned_16;
      Day_Of_Month : Unsigned_16;
      Month        : Unsigned_16;
      Year         : Unsigned_16;
      Century      : Unsigned_16;
      A, B, C, D   : Unsigned_16;
   end record;

   function Read_RTC return CMOS_RTC_Snapshot;

   function Read_Seconds return Duration;

private

   type RTC_Register is
      (SECONDS,
       MINUTES,
       HOURS,
       WEEKDAY,
       DAY_OF_MONTH,
       MONTH,
       YEAR,
       STATUS_A,
       STATUS_B,
       STATUS_C,
       STATUS_D,
       CENTURY)
      with Size => 8;

   for RTC_Register use
      (SECONDS      => 16#00#,
       MINUTES      => 16#02#,
       HOURS        => 16#04#,
       WEEKDAY      => 16#06#,
       DAY_OF_MONTH => 16#07#,
       MONTH        => 16#08#,
       YEAR         => 16#09#,
       STATUS_A     => 16#0A#,
       STATUS_B     => 16#0B#,
       STATUS_C     => 16#0C#,
       STATUS_D     => 16#0D#,
       CENTURY      => 16#32#);

   function Read_RTC_Register (Register : RTC_Register) return Unsigned_16;
   pragma Inline (Read_RTC_Register);

   procedure Write_RTC_Register (Register : RTC_Register; Value : Unsigned_8);
   pragma Inline (Write_RTC_Register);

   function Poll_Update_Flag return Boolean;

   function BCD_To_Binary (Value : Unsigned_16) return Unsigned_16;

end System.RTC;