with Interfaces;
with System;
with System.PS2;
with System.RTC;
with System.Timings;

with Ada.Text_IO; use Ada.Text_IO;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;
with System.ACPI.Structures; use System.ACPI.Structures;

procedure Main is
   use type System.Address;
   use type Interfaces.Unsigned_8;
   use type Interfaces.Unsigned_32;
begin
   Clear;
   Disable_Interrupts;
   Put_Line ("UFEDMI starting...");
   Begin_Section;
   --  System initialization
   Put_Line ("Checking Real Time Clock");
   Begin_Section;
   --  RTC
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
         System.Timings.Reliable_Clock_Source_Entry :=
            System.RTC.Read_Seconds'Access;
         Status_Line (OK, "Set relative delay clock source to RTC (1s res.)");
      else
         Status_Line (ERROR, "RTC not available");
      end if;
   end;
   --  RTC End
   End_Section;
   Put_Line ("ACPI Initialization");
   Begin_Section;
   --  ACPI
   System.ACPI.Structures.Initialize;
   if RSDP'Address = System.Null_Address then
      Status_Line (ERROR, "RSDP not found");
   else
      Status_Line (OK, "RSDT Address :"  & RSDP.Rsdt_Address'Image);
      Put_Line    (    "RSDP Checksum:"  & RSDP.Checksum'Image);
      Put_Line    (    "RSDP OEM ID  : " & RSDP.OEM_ID);
      Put_Line    (    "RSDP Revision:"  & RSDP.Revision'Image);
      if RSDP.Revision >= 2 then
         Status_Line (OK, "XSDP Address :"  & XSDP.Xsdt_Address'Image);
         Put_Line    (    "XSDP Checksum:" & XSDP.Checksum'Image);
         Put_Line    (    "XSDP Length  :" & XSDP.Length'Image);
         Put_Line ("Iterating over XSDP entries");
         Begin_Section;
         for Index in 1 .. (SDT.Length - 36) / 8 loop
            Put (Index'Image & ": ");
            declare
               Table   : System.ACPI.Extended_System_Descriptor_Table_Header_Pointer :=
                  SDT.Tables_64 (Index);
               Raw_Sig : String (1 .. 4) with Address =>
                  Table.Signature'Address;
            begin
               Status_Line ((if Table.Signature'Valid then OK else WARNING),
                            Raw_Sig & ", recognized: " &
                            Table.Signature'Valid'Image);
            end;
         end loop;
         End_Section;
      else
         Put_Line ("Iterating over RSDP entries");
         Begin_Section;
         for Index in 1 .. (SDT.Length - 36) / 4 loop
            Put (Index'Image & ": ");
            declare
               Table   : System.ACPI.System_Descriptor_Table_Header_Pointer :=
                  SDT.Tables_32 (Index);
               Raw_Sig : String (1 .. 4) with Address =>
                  Table.Signature'Address;
            begin
               Status_Line ((if Table.Signature'Valid then OK else WARNING),
                            Raw_Sig & ", recognized: " &
                            Table.Signature'Valid'Image);
            end;
         end loop;
         End_Section;
      end if;
   end if;
   --  ACPI End
   End_Section;
   --  Put_Line ("PS/2 initialization");
   Begin_Section;
   --  PS/2
   --  Initialize USB
   --  Determine if PS/2 exists
   --  Disable Devices
   --  Flush Output Buffer
   --  Set Controller Config Byte
   --  Perofrm Controller self test
   --  Determine if 2 chanenls
   --  Perform interface tests
   --  Enable Dev
   --  Reset Dev
   --  if System.PS2.Read_Controller_Configuration.POST_OK then
      --  Status_Line (OK, "POST from PS/2 is OK");
   --  else
      --  Status_Line (ERROR, "Erroneous state. POST from PS/2 is BAD");
   --  end if;
   --  PS/2 End
   End_Section;
   --  System initialization END
   End_Section;
   Status_Line (OK, "UFEDMI started");
   Put_Line ("Launching shell");
   Halt;
end Main;