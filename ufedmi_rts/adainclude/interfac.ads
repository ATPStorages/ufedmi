package Interfaces is

   type Unsigned_8 is mod 2 ** 8 with Size => 8;
   pragma Provide_Shift_Operators (Unsigned_8);

   type Unsigned_16 is mod 2 ** 16 with Size => 16;
   pragma Provide_Shift_Operators (Unsigned_16);

   type Unsigned_32 is mod 2 ** 32 with Size => 32;
   pragma Provide_Shift_Operators (Unsigned_32);

   type Unsigned_64 is mod 2 ** 64 with Size => 64;
   pragma Provide_Shift_Operators (Unsigned_64);

end Interfaces;