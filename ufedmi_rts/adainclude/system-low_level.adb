with System.Machine_Code; use System.Machine_Code;

package body System.Low_Level is

   HT : Character renames ASCII.HT;
   LF : Character renames ASCII.LF;

   function As_Segmented_Address (Addr : Address) return Segmented_Address is
   begin
      return Segmented_Address'(Unsigned_16 (Addr / 16),
                                Unsigned_16 (Addr rem 16));
   end As_Segmented_Address;

   function Read_Pin (Pin : CPU_Pin) return Unsigned_16 is
      Output : Unsigned_16 := 0;
   begin
      Asm ("inw %%dx, %%ax",
           Inputs   => Unsigned_16'Asm_Input ("d", Pin'Enum_Rep),
           Outputs  => Unsigned_16'Asm_Output ("=a", Output),
           Volatile => True);
      return Output;
   end Read_Pin;

   procedure Write_Pin (Pin : CPU_Pin; Value : Unsigned_16) is
   begin
      Asm ("outw %%ax, %%dx",
           Inputs   => (Unsigned_16'Asm_Input ("a", Value),
                        Unsigned_16'Asm_Input ("d", Pin'Enum_Rep)),
           Volatile => True);
   end Write_Pin;

   procedure Disable_Interrupts (Non_Maskable_Interrupts : Boolean := True) is
   begin
      Asm ("cli", Volatile => True);
      if Non_Maskable_Interrupts then
         Asm ("inb  $0x70"      & LF & HT &
              "orb  %%al, 0x80" & LF & HT &
              "outb $0x71"      & LF & HT &
              "inb  $0x71",
              Volatile => True, Clobber => "al");
      end if;
   end Disable_Interrupts;

   procedure Enable_Interrupts (Non_Maskable_Interrupts : Boolean := True) is
   begin
      Asm ("sti", Volatile => True);
      if Non_Maskable_Interrupts then
         Asm ("inb  $0x70"      & LF & HT &
              "andb %%al, 0x7F" & LF & HT &
              "outb $0x71"      & LF & HT &
              "inb  $0x71",
              Volatile => True, Clobber => "al");
      end if;
   end Enable_Interrupts;

   procedure Halt is
   begin
      Asm ("hlt", Volatile => True);
   end Halt;

   function A20_Check return Boolean is
      Output : Boolean;
   begin
      Asm ("mov 0x007DFE, %0" & LF & HT &
           "sub 0x107DFE, %0" & LF & HT &
           "test %0, %0"      & LF & HT &
           "jz zero"          & LF & HT &
           "mov $1, %0"       & LF & HT &
           "jmp ok"           & LF & HT &
           "zero: xor %0, %0" & LF & HT &
           "ok:",
           Outputs  => Boolean'Asm_Output ("=g", Output),
           Clobber  => "cc",
           Volatile => True);
      return Output;
   end A20_Check;

   function Read_Control_Register_0 return Control_Register_0 is
      Output : Control_Register_0;
   begin
      Asm ("mov %%cr0, %0",
           Outputs  => Control_Register_0'Asm_Output ("=r", Output),
           Volatile => True);
      return Output;
   end Read_Control_Register_0;

   procedure Set_Global_Descriptor_Table
      (Register : Descriptor_Register)
   is
   begin
      Asm ("mov %1, 0x7C00" & LF & HT &
           "mov %0, 0x7C02" & LF & HT &
           "lgdt 0x7C00",
           Inputs   => (Unsigned_32'Asm_Input ("r", Register.Addr),
                        Unsigned_16'Asm_Input ("r", Register.Limit)),
           Volatile => True);
   end Set_Global_Descriptor_Table;

   procedure Set_Interrupt_Descriptor_Table
      (Register : Descriptor_Register)
   is
   begin
      Asm ("mov %1, 0x7C00" & LF & HT &
           "mov %0, 0x7C02" & LF & HT &
           "lidt 0x7C00",
           Inputs   => (Unsigned_32'Asm_Input ("r", Register.Addr),
                        Unsigned_16'Asm_Input ("r", Register.Limit)),
           Volatile => True);
   end Set_Interrupt_Descriptor_Table;

   function Get_Global_Descriptor_Register
      return Descriptor_Register
   is
      Register : Descriptor_Register;
   begin
      Asm ("sgdt %0",
           Outputs  => Descriptor_Register'Asm_Output ("=m", Register),
           Volatile => True);
      return Register;
   end Get_Global_Descriptor_Register;

   function Get_Interrupt_Descriptor_Register
      return Descriptor_Register
   is
      Register : Descriptor_Register;
   begin
      Asm ("sidt %0",
           Outputs  => Descriptor_Register'Asm_Output ("=m", Register),
           Volatile => True);
      return Register;
   end Get_Interrupt_Descriptor_Register;

   procedure Refresh_Global_Descriptor_Table is
   begin
      Asm ("jmp $0x08,$far" & LF & HT &
           "far:",
           Volatile => True);
   end Refresh_Global_Descriptor_Table;

   procedure Raise_Division_Error is
   begin
      Asm ("xor %%ecx, %%ecx" & LF & HT &
           "div %%ecx",
           Volatile => True);
   end Raise_Division_Error;

   procedure Raise_Invalid_Opcode_Error is
   begin
      Asm ("ud2",
           Volatile => True);
   end Raise_Invalid_Opcode_Error;

end System.Low_Level;