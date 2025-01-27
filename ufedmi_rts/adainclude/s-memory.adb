with System.Storage_Elements; use System.Storage_Elements;
with System.Machine_Code; use System.Machine_Code;

package body System.Memory is

   HT : Character renames ASCII.HT;
   LF : Character renames ASCII.LF;
   Usable_Heap_Address : Address := To_Address (16#00007E00#);

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

end System.Memory;