with System.Machine_Code; use System.Machine_Code;

package body System.Low_Level is

   HT : constant Character := Character'Val (9);
   LF : constant Character := Character'Val (10);

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

   function A20_Line_Status return Unsigned_16 is
      Output : constant Unsigned_16 := 1;
   begin
      --  Asm ("xor %%dx, %%dx" & LF & HT &
      --       "mov %%dx, %0",
      --       Volatile => True,
      --       Clobber  => "dx",
      --       Outputs  => u2'Asm_Output ("=c", Output));
      return Output;
   end A20_Line_Status;

   procedure Halt is
   begin
      Asm ("hlt", Volatile => True);
   end Halt;

end System.Low_Level;