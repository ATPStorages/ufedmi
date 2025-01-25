package body System is

   function Copy_Bytes
      (To, From : Address;
       Length   : Size_T)
   return Address is
      From_Chunk : Chunk (1 .. Length) with Address => From;
      To_Chunk   : Chunk (1 .. Length) with Address => To;
   begin
      for Index in 1 .. Length loop
         To_Chunk (Index) := From_Chunk (Index);
      end loop;
      return To;
   end Copy_Bytes;

   procedure Overflow_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Overflow_Check;

   procedure Range_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Range_Check;

   procedure Index_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Index_Check;

   procedure Length_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Length_Check;

end System;