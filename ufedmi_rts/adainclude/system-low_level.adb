with System.Machine_Code; use System.Machine_Code;

package body System.Low_Level is

   HT : constant Character := Character'Val (9);
   LF : constant Character := Character'Val (10);

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

   function A20_Line_Status return u2 is
      Output : u2 := 0;
   begin
      Asm ("mov %0, 0xFFDD",
           Volatile => True,
           Outputs => u2'Asm_Output ("=a", Output));
      return Output;
   end A20_Line_Status;

   procedure Halt is
   begin
      Asm ("hlt", Volatile => True);
   end Halt;

end System.Low_Level;