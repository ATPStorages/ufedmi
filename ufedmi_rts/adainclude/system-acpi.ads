with Interfaces;
package System.ACPI is

   type Root_System_Description_Pointer is record
      Signature    : String (1 .. 8);
      Checksum     : Interfaces.Unsigned_8;
      OEM_ID       : String (1 .. 6);
      Revision     : Interfaces.Unsigned_8;
      Rsdt_Address : Interfaces.Unsigned_32;
   end record with Size => 160;

   function Search return Address;

end System.ACPI;