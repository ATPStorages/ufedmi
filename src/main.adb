with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;
with System.PS2;
with System.Relative_Delays;
with System.RTC;

procedure Main is
begin
   Clear;
   Disable_Interrupts;
   Put_Line ("UFEDMI starting...");
   Begin_Section;
   --  System initialization
   Put_Line ("Beginning PS/2 initialization");
   Begin_Section;
   -- PS/2
   if System.PS2.Read_Controller_Configuration.POST_OK then
      Status_Line (OK, "POST from PS/2 is OK");
   else
      Status_Line (ERROR, "Erroneous state. POST from PS/2 is BAD");
   end if;
   -- PS/2 End
   End_Section;
   Put_Line ("Checking Real Time Clock");
   Begin_Section;
   -- RTC
   declare
      Data : constant System.RTC.CMOS_RTC_Snapshot := System.RTC.Read_RTC;
      use type Interfaces.Unsigned_16;
   begin
      Put_Line
         ("Time reported:" & Data.Second'Image &
          " :"             & Data.Minute'Image &
          " :"             & Data.Hour'Image);
      Put_Line
         ("Date reported:" & Data.Day_Of_Month'Image &
          " /"             & Data.Month'Image        &
          " / ("           & Data.Century'Image      &
          " )"             & Data.Year'Image);
      Put_Line
         ("Stat         :" & Data.A'Image &
          " |"    & Data.B'Image &
          " |"    & Data.C'Image &
          " |"    & Data.D'Image);
      if Data.D > 0 and Data.Year > 24 then
         Put_Line ("RTC looks sane enough");
         System.Relative_Delays.Reliable_Clock_Source_Entry :=
            System.RTC.Read_Seconds'Access;
         Status_Line (OK, "Set relative delay clock source to RTC (1s res.)");
      else
         Status_Line (ERROR, "RTC not available");
      end if;
   end;
   -- RTC End
   End_Section;
   --  System initialization END
   End_Section;
   Status_Line (OK, "UFEDMI started");
   Put_Line ("Launching shell");
   Halt;
end Main;