package System is
   pragma Pure (System);

   Min_Int             : constant := -2 ** (Standard'Max_Integer_Size - 1);
   Max_Int             : constant :=  2 ** (Standard'Max_Integer_Size - 1) - 1;

   Max_Binary_Modulus    : constant := 2 ** Standard'Max_Integer_Size;
   Max_Nonbinary_Modulus : constant := 2 ** Integer'Size - 1;

   Max_Base_Digits       : constant := Long_Long_Float'Digits;
   Max_Digits            : constant := Long_Long_Float'Digits;

   Max_Mantissa          : constant := Standard'Max_Integer_Size - 1;
   Fine_Delta            : constant := 2.0 ** (-Max_Mantissa);

   Tick                  : constant := 0.000_001;

   type Address is private;
   pragma Preelaborable_Initialization (Address);
   Null_Address : constant Address;

   Storage_Unit : constant := 8;
   Word_Size    : constant := Standard'Word_Size;
   Memory_Size  : constant := 2 ** Long_Integer'Size;
private

   type Address is mod Memory_Size;
   for Address'Size use Standard'Address_Size;

   Null_Address : constant Address := 0;

   procedure Overflow_Check
      (File : Address;
       Line : Integer)
   with
      Export,
      Convention => C,
      Link_Name => "__gnat_rcheck_CE_Overflow_Check";

   procedure Range_Check
      (File : Address;
       Line : Integer)
   with
      Export,
      Convention => C,
      Link_Name => "__gnat_rcheck_CE_Range_Check";

   procedure Index_Check
      (File : Address;
       Line : Integer)
   with
      Export,
      Convention => C,
      Link_Name => "__gnat_rcheck_CE_Index_Check";

   procedure Length_Check
      (File : Address;
       Line : Integer)
   with
      Export,
      Convention => C,
      Link_Name => "__gnat_rcheck_CE_Length_Check";

   procedure Invalid_Check
      (File : Address;
       Line : Integer)
   with
      Export,
      Convention => C,
      Link_Name => "__gnat_rcheck_CE_Invalid_Data";

end System;