with Interfaces;

package System.ACPI is
   pragma Pure;
   pragma No_Elaboration_Code_All;

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

   type System_Descriptor_Table_Signature is
      (RSDT, XSDT);

   type System_Descriptor_Table_Header is record
      Signature        : String (1 .. 4);
      Length           : Interfaces.Unsigned_32;
      Revision         : Interfaces.Unsigned_8;
      Checksum         : Interfaces.Unsigned_8;
      OEM_ID           : String (1 .. 6);
      OEM_Table_ID     : String (1 .. 8);
      OEM_Revision     : Interfaces.Unsigned_32;
      Creator_ID       : Interfaces.Unsigned_32;
      Creator_Revision : Interfaces.Unsigned_32;
   end record with Size => 288;

   type System_Descriptor_Table_Data
      (Signature : System_Descriptor_Table_Signature)
   is record
      case Signature is
         when RSDT =>
            null;
         when XSDT =>
            null;
      end case;
   end record;

   type System_Descriptor_Table is record
      Header : System_Descriptor_Table_Header;
      Data   : access System_Descriptor_Table_Data;
   end record with Size => 320;

   for System_Descriptor_Table use record
      Header at 0  range 0 .. 287;
      Data   at 36 range 0 .. 31;
   end record;

   function Search return Address;

end System.ACPI;