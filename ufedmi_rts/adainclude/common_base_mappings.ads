package Common_Base_Mappings is

   type Inclusive_String is array (Natural range <>) of Character;

   Mapping : constant Inclusive_String (0 .. 9) := "0123456789";

end Common_Base_Mappings;