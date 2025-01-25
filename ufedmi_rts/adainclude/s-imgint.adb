------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       S Y S T E M . I M G _ L L U                        --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2024, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
------------------------------------------------------------------------------

with Common_Base_Mappings;

package body System.Img_Int is

   pragma Suppress (All_Checks);

   Mapping : Common_Base_Mappings.Inclusive_String
      renames Common_Base_Mappings.Mapping;

   procedure Image_Integer
     (Value        :        Integer;
      Value_Image  : in out String;
      Image_Length :    out Natural)
   is
   begin
      if Value = 0 then
         Value_Image := " 0";
         Image_Length := 2;
      else
         declare
            Count : Integer := 1;
         begin
            declare
               Counter : Integer := abs Value;
            begin
               loop
                  Count := Count + 1;
                  Value_Image (Count) := Mapping (Counter rem Mapping'Length);
                  Counter := Counter / Mapping'Length;
                  exit when Counter = 0;
               end loop;
            end;
            declare
               Final : String (1 .. Count);
            begin
               for Index in reverse 2 .. Count loop
                  Final (Index) :=
                     Value_Image (Count - Index + 2);
               end loop;
               Final (1) := (if Value < 0 then '-' else ' ');
               Image_Length := Count;
               Value_Image := Final;
            end;
         end;
      end if;
   end Image_Integer;

end System.Img_Int;
