with Interfaces; use Interfaces;

package System.Low_Level is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type CPU_Pin is
      (NONE,
       PIC_1_COMMAND,
       PIC_1_DATA,
       PIC_CHANNEL_0_DATA,
       PIC_CHANNEL_1_DATA,
       PIC_CHANNEL_2_DATA,
       PIC_COMMAND,
       PS_2_DATA,
       PC_SPEAKER,
       PS_2_REGISTER,
       CMOS_COMMAND,
       CMOS_DATA,
       PIC_2_COMMAND,
       PIC_2_DATA,
       COM_1,
       COM_1_INTERRUPTS,
       COM_1_INTRP_FIFO_CTRL,
       COM_1_LINE_CONTROL,
       COM_1_MODEM_CONTROL,
       COM_1_LINE_STATUS,
       COM_1_MODEM_STATUS,
       COM_1_SCRATCH,
       QEMU_SHUTDOWN) --  Write_Pin w/ 16#2000# to shutdown
      with Size => 16;

   for CPU_Pin use
      (NONE                  => 16#000#,
       PIC_1_COMMAND         => 16#020#,
       PIC_1_DATA            => 16#021#,
       PIC_CHANNEL_0_DATA    => 16#040#,
       PIC_CHANNEL_1_DATA    => 16#041#,
       PIC_CHANNEL_2_DATA    => 16#042#,
       PIC_COMMAND           => 16#043#,
       PS_2_DATA             => 16#060#,
       PC_SPEAKER            => 16#061#,
       PS_2_REGISTER         => 16#064#,
       CMOS_COMMAND          => 16#070#,
       CMOS_DATA             => 16#071#,
       PIC_2_COMMAND         => 16#0A0#,
       PIC_2_DATA            => 16#0A1#,
       COM_1                 => 16#3F8#,
       COM_1_INTERRUPTS      => 16#3F9#,
       COM_1_INTRP_FIFO_CTRL => 16#3FA#,
       COM_1_LINE_CONTROL    => 16#3FB#,
       COM_1_MODEM_CONTROL   => 16#3FC#,
       COM_1_LINE_STATUS     => 16#3FD#,
       COM_1_MODEM_STATUS    => 16#3FE#,
       COM_1_SCRATCH         => 16#3FF#,
       QEMU_SHUTDOWN         => 16#604#);

   type Pin_Array is array (Positive range <>) of CPU_Pin;
   COM_Pins : constant Pin_Array := (1 => COM_1);

   type Segmented_Address is record
      Segment, Offset : Interfaces.Unsigned_16;
   end record with Size => 32;

   function As_Segmented_Address (Addr : Address) return Segmented_Address;

   function Read_Pin (Pin : CPU_Pin) return Unsigned_16 with Inline_Always;
   procedure Write_Pin (Pin : CPU_Pin; Value : Unsigned_16) with Inline_Always;

   procedure Disable_Interrupts (Non_Maskable_Interrupts : Boolean := True)
      with Inline_Always;
   procedure Enable_Interrupts (Non_Maskable_Interrupts : Boolean := True)
      with Inline_Always;
   procedure Halt
      with Inline_Always;

   function A20_Check return Boolean;

   type Control_Register_0 is record
      Protected_Mode          : Boolean;
      Monitor_Coprocessor     : Boolean;
      x87_FPU_Emulated        : Boolean;
      x87_Task_Context_Saving : Boolean;
      Using_80387_Beyond      : Boolean;
      x87_Internal_Errors     : Boolean;
      Page_Write_Protection   : Boolean;
      Alignment_Check_Enabled : Boolean;
      Write_Through_Disabled  : Boolean;
      Memory_Cache_Disabled   : Boolean;
      Paging                  : Boolean;
   end record with Size => 32;

   for Control_Register_0 use record
      Protected_Mode          at 0 range 0 .. 0;
      Monitor_Coprocessor     at 0 range 1 .. 1;
      x87_FPU_Emulated        at 0 range 2 .. 2;
      x87_Task_Context_Saving at 0 range 3 .. 3;
      Using_80387_Beyond      at 0 range 4 .. 4;
      x87_Internal_Errors     at 0 range 5 .. 5;
      Page_Write_Protection   at 2 range 0 .. 0;
      Alignment_Check_Enabled at 2 range 2 .. 2;
      Write_Through_Disabled  at 3 range 5 .. 5;
      Memory_Cache_Disabled   at 3 range 6 .. 6;
      Paging                  at 3 range 7 .. 7;
   end record;

   function Read_Control_Register_0 return Control_Register_0;

   type Global_Descriptor_Register is record
      Limit : Unsigned_16;
      Addr  : Unsigned_32;
   end record with Pack, Size => 48;

   procedure Set_Global_Descriptor_Table
      (Register : Global_Descriptor_Register) with Inline_Always;

   function Get_Global_Descriptor_Register
      return Global_Descriptor_Register with Inline_Always;

   procedure Raise_Division_Error;

end System.Low_Level;