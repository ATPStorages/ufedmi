with Ada.Interrupts.Defintitions;
with System;
with Interfaces;
with System.PS2;
with System.RTC;
with System.Timings;

with Ada.Text_IO; use Ada.Text_IO;
with System.Serial; use System.Serial;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;
with System.ACPI.Structures; use System.ACPI.Structures;
with System.Storage_Elements; use System.Storage_Elements;

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
   Put_Line ("COM / Serial initialization");
   Begin_Section;
   --  COM / Serial
   for Pin_No in COM_Pins'Range loop
      declare
         COM_Pin : CPU_Pin renames COM_Pins (Pin_No);
         Init_OK : constant Boolean := Serial_Initialize (COM_Pin);
      begin
         Status_Line ((if Init_OK then OK Else WARNING), COM_Pin'Image);
         if System.CGA_TextMode.COM = NONE then
            System.CGA_TextMode.COM := COM_Pin;
            Put_Line ("Logging on " & COM_Pin'Image);
         end if;
      end;
   end loop;
   --  COM / Serial End
   End_Section;
   Put_Line ("Checking real time clock");
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
   Put_Line ("ACPI initialization");
   Begin_Section;
   --  ACPI
   System.ACPI.Structures.Initialize;
   if RSDP'Address = System.Null_Address then
      Status_Line (ERROR, "RSDP not found");
   else
      Status_Line (OK, "RSDP RSDT Address :"  & RSDP.Rsdt_Address'Image);
      Put_Line    (    "RSDP Checksum:"  & RSDP.Checksum'Image);
      Put_Line    (    "RSDP OEM ID  : " & RSDP.OEM_ID);
      Put_Line    (    "RSDP Revision:"  & RSDP.Revision'Image);
      if RSDP.Revision >= 2 then
         Status_Line (OK, "XSDP Address :"  & XSDP.Xsdt_Address'Image);
         Put_Line    (    "XSDP Checksum:" & XSDP.Checksum'Image);
         Put_Line    (    "XSDP Length  :" & XSDP.Length'Image);
         Put_Line ("Iterating over (" & Interfaces.Unsigned_32'Image ((SDT.Length - 36) / 8) & " ) XSDP entries");
         Begin_Section;
         for Index in 1 .. (SDT.Length - 36) / 8 loop
            Put (Index'Image & ": ");
            declare
               Table   : constant System.ACPI.Extended_System_Descriptor_Table_Header_Pointer :=
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
         Put_Line ("Iterating over (" & Interfaces.Unsigned_32'Image ((SDT.Length - 36) / 4) & " ) RSDP entries");
         Begin_Section;
         for Index in 1 .. (SDT.Length - 36) / 4 loop
            Put (Index'Image & ": ");
            declare
               Table   : constant System.ACPI.System_Descriptor_Table_Header_Pointer :=
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
         Status_Line (OK, "ACPI ready for use");
      end if;
   end if;
   --  ACPI End
   End_Section;
   Put_Line ("PS/2 initialization");
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
   if System.PS2.Read_Controller_Configuration.POST_OK then
      Status_Line (OK, "POST from PS/2 is OK");
   else
      Status_Line (ERROR, "Erroneous state. POST from PS/2 is BAD");
   end if;
   --  PS/2 End
   End_Section;
   Put_Line ("Control register 0 stat");
   Begin_Section;
   -- Protected Mode
   declare
      CR0 : constant Control_Register_0 := Read_Control_Register_0;
   begin
      Put_Line ("Protected Mode                 : " &
                CR0.Protected_Mode'Image);
      if not CR0.Protected_Mode then
         Begin_Section;
         Put_Line ("Protected mode initialization");
         Begin_Section;
         Put_Line ("TODO");
         End_Section;
         Put_Line ("Protected mode entered");
         End_Section;
      end if;
      Put_Line ("Monitor coprocessor            : " &
                CR0.Monitor_Coprocessor'Image);
      Put_Line ("x87 FPU Emulation              : " &
                CR0.x87_FPU_Emulated'Image);
      Put_Line ("x87 context saving             : " &
                CR0.x87_Task_Context_Saving'Image);
      Put_Line ("80387+ Math Coprocessor        : " &
                CR0.Using_80387_Beyond'Image);
      Put_Line ("x87 internal error reporting   : " &
                CR0.x87_Task_Context_Saving'Image);
      Put_Line ("Read-only page write protection: " &
                CR0.Page_Write_Protection 'Image);
      Put_Line ("Alignment check exception      : " &
                CR0.Alignment_Check_Enabled'Image);
      Put_Line ("Write-through caching          : " &
                Boolean'Image (not CR0.Write_Through_Disabled));
      Put_Line ("Memory caching                 : " &
                Boolean'Image (not CR0.Memory_Cache_Disabled));
      Put_Line ("Memory Paging                  : " &
                Boolean'Image (    CR0.Paging));
   end;
   --  Protected Mode End
   End_Section;
   Put_Line ("System initialization complete");
   --  System initialization End
   End_Section;
   Status_Line (OK, "UFEDMI started");
   Put_Line ("Launching shell");
   Halt;
end Main;