with Interfaces;

package System.ACPI is
   pragma Pure;

   type Root_System_Description_Pointer is record
      Signature    : String (1 .. 8);
      Checksum     : Interfaces.Unsigned_8;
      OEM_ID       : String (1 .. 6);
      Revision     : Interfaces.Unsigned_8;
      Rsdt_Address : Address;
   end record with Size => 160;

   for Root_System_Description_Pointer use record
      Signature    at 0 range 0 .. 63;
      Checksum     at 8 range 0 .. 7;
      OEM_ID       at 9 range 0 .. 47;
      Revision     at 15 range 0 .. 7;
      Rsdt_Address at 16 range 0 .. 31;
   end record;

   type Extended_Root_System_Description_Pointer is record
      Length       : Interfaces.Unsigned_32;
      Xsdt_Address : Address;
      Checksum     : Interfaces.Unsigned_8;
   end record with Size => 128;

   for Extended_Root_System_Description_Pointer use record
      Length       at 0  range 0 .. 31;
      Xsdt_Address at 4  range 0 .. 63;
      Checksum     at 12 range 0 .. 7;
   end record;

   function Search return Address;

end System.ACPI;