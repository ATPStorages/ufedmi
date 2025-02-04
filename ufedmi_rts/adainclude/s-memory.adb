with System.Storage_Elements; use System.Storage_Elements;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;

package body System.Memory is

   HT : Character renames ASCII.HT;
   LF : Character renames ASCII.LF;
   Usable_Heap_Address : Address := To_Address (16#00000500#);

   procedure Write_Segment_Descriptor
      (Descriptor : Segment_Descriptor;
       Addr : Address)
   is
      SD_Chunk : Chunk (0 .. 7) with Address => Addr;
      Limit_32 : constant Unsigned_32 := Unsigned_32 (Descriptor.Limit);
      Flags_32 : constant Unsigned_32 := Unsigned_32 (Descriptor.Flags);
   begin
      --  Limit
      SD_Chunk (0) := Byte (Limit_32);
      SD_Chunk (1) := Byte (Shift_Right (Limit_32, 8));
      SD_Chunk (6) := Byte (Shift_Right (Limit_32, 16) or
                            Shift_Left  (Flags_32, 4));
      --  Base
      SD_Chunk (2) := Byte (Descriptor.Base);
      SD_Chunk (3) := Byte (Shift_Right (Descriptor.Base, 8));
      SD_Chunk (4) := Byte (Shift_Right (Descriptor.Base, 16));
      SD_Chunk (7) := Byte (Shift_Right (Descriptor.Base, 24));
      --  Access
      SD_Chunk (5) := Byte (Descriptor.Access_Flags);
   end Write_Segment_Descriptor;

   function Allocate (Length : Integer_Address) return Address is
      Saved_Address : constant Address := Usable_Heap_Address;
      --  Allocated     : Chunk (1 .. Length) with Address => Saved_Address;
   begin
      Usable_Heap_Address := Usable_Heap_Address + To_Address (Length);
      --  Allocated := (others => 0);
      return Saved_Address;
   end Allocate;

   function Copy_Bytes
      (To, From : Address;
       Length   : Integer_Address)
   return Address is
      From_Chunk : Chunk (1 .. Length) with Address => From;
      To_Chunk   : Chunk (1 .. Length) with Address => To;
   begin
      To_Chunk (1 .. Length) := From_Chunk (1 .. Length);
      return To;
   end Copy_Bytes;

   function Move_Bytes
      (To, From : Address;
       Length   : Integer_Address)
   return Address is
   begin
      Asm ("cld"       & LF & HT &
           "rep movsb",
           Inputs   => (Address'Asm_Input ("D", To),
                        Address'Asm_Input ("S", From),
                        Integer_Address'Asm_Input ("c", Length)),
           Volatile => True,
           Clobber  => "cc");
      return To;
   end Move_Bytes;

   function Compare_Bytes
      (A, B   : Address;
       Length : Integer_Address)
   return Integer is
      A_Chunk : Chunk (1 .. Length) with Address => A;
      B_Chunk : Chunk (1 .. Length) with Address => B;
      RA, RB  : Byte;
   begin
      for Index in 1 .. Length loop
         RA := A_Chunk (Index);
         RB := B_Chunk (Index);
         if RA > RB then
            return 1;
         elsif RA < RB then
            return -1;
         end if;
      end loop;
      return 0;
   end Compare_Bytes;

end System.Memory;