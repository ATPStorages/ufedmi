package Common_Base_Mappings is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type Inclusive_String is array (Natural range <>) of Character;

   Mapping : constant Inclusive_String := "0123456789";

end Common_Base_Mappings;