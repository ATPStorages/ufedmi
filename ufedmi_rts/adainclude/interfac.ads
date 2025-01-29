package Interfaces is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type Unsigned_2 is mod 2 ** 2 with Size => 2;

   type Unsigned_4 is mod 2 ** 4 with Size => 4;

   type Unsigned_8 is mod 2 ** 8 with Size => 8;
   pragma Provide_Shift_Operators (Unsigned_8);

   type Unsigned_16 is mod 2 ** 16 with Size => 16;
   pragma Provide_Shift_Operators (Unsigned_16);

   type Unsigned_20 is mod 2 ** 20 with Size => 20;

   type Unsigned_24 is mod 2 ** 24 with Size => 24;

   type Unsigned_32 is mod 2 ** 32 with Size => 32;
   pragma Provide_Shift_Operators (Unsigned_32);

   type Unsigned_64 is mod 2 ** 64 with Size => 64;
   pragma Provide_Shift_Operators (Unsigned_64);

   function Shift_Right (U : Unsigned_16; A : Natural) return Unsigned_16 with
      Import,
      Convention => Intrinsic;

end Interfaces;