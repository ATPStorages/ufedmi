with Common_Base_Mappings;

package body System.Img_Uns is

   Mapping : Common_Base_Mappings.Inclusive_String
      renames Common_Base_Mappings.Mapping;

   procedure Image_Unsigned
     (Value        : Unsigned;
      Value_Image  : in out String;
      Image_Length : out Natural)
   is
      use type Unsigned;
   begin
      if Value = 0 then
         Value_Image := " 0";
         Image_Length := 2;
      else
         declare
            Count : Integer := 1;
         begin
            declare
               Counter : Unsigned := Value;
            begin
               loop
                  Count := Count + 1;
                  Value_Image (Count) :=
                     Mapping (Integer (Counter rem Mapping'Length));
                  Counter := Counter / Mapping'Length;
                  exit when Counter = 0;
               end loop;
            end;
            declare
               Final : String (1 .. Count);
            begin
               Final (1) := ' ';
               for Index in reverse 2 .. Count loop
                  Final (Index) :=
                     Value_Image (Count - Index + 2);
               end loop;
               Image_Length := Count;
               Value_Image := Final;
            end;
         end;
      end if;
   end Image_Unsigned;

end System.Img_Uns;