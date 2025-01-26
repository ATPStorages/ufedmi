with System.Storage_Elements; use System.Storage_Elements;

package body System.Memory is

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
      for Index in 1 .. Length loop
         To_Chunk (Index) := From_Chunk (Index);
      end loop;
      return To;
   end Copy_Bytes;

end System.Memory;