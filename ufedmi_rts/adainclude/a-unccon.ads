generic
   type Source (<>) is limited private;
   type Target (<>) is limited private;

function Ada.Unchecked_Conversion (S : Source) return Target;

pragma No_Elaboration_Code_All (Ada.Unchecked_Conversion);
pragma Pure (Ada.Unchecked_Conversion);
pragma Import (Intrinsic, Ada.Unchecked_Conversion);
