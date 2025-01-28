with Interfaces; use Interfaces;

package System.Low_Level is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type CPU_Pin is
      (PIC_CHANNEL_0_DATA,
       PIC_CHANNEL_1_DATA,
       PIC_CHANNEL_2_DATA,
       PIC_COMMAND,
       PS_2_DATA,
       PC_SPEAKER,
       PS_2_REGISTER,
       CMOS_COMMAND,
       CMOS_DATA,
       QEMU_SHUTDOWN) --  Write_Pin w/ 16#2000# to shutdown
      with Size => 16;

   for CPU_Pin use
      (PIC_CHANNEL_0_DATA => 16#040#,
       PIC_CHANNEL_1_DATA => 16#041#,
       PIC_CHANNEL_2_DATA => 16#042#,
       PIC_COMMAND        => 16#043#,
       PS_2_DATA          => 16#060#,
       PC_SPEAKER         => 16#061#,
       PS_2_REGISTER      => 16#064#,
       CMOS_COMMAND       => 16#070#,
       CMOS_DATA          => 16#071#,
       QEMU_SHUTDOWN      => 16#604#);

   type Segmented_Address is record
      Segment, Offset : Interfaces.Unsigned_16;
   end record with Size => 32;

   function As_Segmented_Address (Addr : Address) return Segmented_Address;

   function Read_Pin (Pin : CPU_Pin) return Unsigned_16;
   pragma Inline (Read_Pin);

   procedure Write_Pin (Pin : CPU_Pin; Value : Unsigned_16);
   pragma Inline (Write_Pin);

   procedure Disable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   procedure Enable_Interrupts (Non_Maskable_Interrupts : Boolean := True);
   function A20_Line_Status return Unsigned_16;
   procedure Halt;
   pragma Inline (Halt);

end System.Low_Level;