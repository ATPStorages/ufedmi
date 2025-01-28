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

   type SDT_Header_Signature is
      (APIC,
       FACP,
       RSDT,
       XSDT,
       WAET,
       HPET)
      with Size => 32;

   for SDT_Header_Signature use
      (APIC => 16#43495041#,
       FACP => 16#50434146#,
       RSDT => 16#54445352#,
       XSDT => 16#54445358#,
       WAET => 16#54454157#,
       HPET => 16#54455048#);

   type System_Descriptor_Table_Header;

   type System_Descriptor_Table_Header_Pointer is
      access System_Descriptor_Table_Header with Storage_Size => 0, Size => 32;
   pragma No_Strict_Aliasing (System_Descriptor_Table_Header_Pointer);

   type SDT_Header_Pointer_Array is
      array (Interfaces.Unsigned_32 range <>) of
         System_Descriptor_Table_Header_Pointer;

   pragma Warnings (Off, "*bits of");
   type Extended_System_Descriptor_Table_Header_Pointer is
      access System_Descriptor_Table_Header with Storage_Size => 0, Size => 64;
   pragma No_Strict_Aliasing (Extended_System_Descriptor_Table_Header_Pointer);
   pragma Warnings (On, "*bits of");

   type Extended_SDT_Header_Pointer_Array is
      array (Interfaces.Unsigned_32 range <>) of
         Extended_System_Descriptor_Table_Header_Pointer;

   use type Interfaces.Unsigned_32;
   type System_Descriptor_Table_Header
      (Signature : SDT_Header_Signature; Length : Interfaces.Unsigned_32)
   is record
      Revision         : Interfaces.Unsigned_8;
      Checksum         : Interfaces.Unsigned_8;
      OEM_ID           : String (1 .. 6);
      OEM_Table_ID     : String (1 .. 8);
      OEM_Revision     : Interfaces.Unsigned_32;
      Creator_ID       : Interfaces.Unsigned_32;
      Creator_Revision : Interfaces.Unsigned_32;
      case Signature is
         when RSDT =>
            --  Receiving end must validate index, 4 bytes per.
            Tables_32 : SDT_Header_Pointer_Array (1 .. Length);
         when XSDT =>
            --  Receiving end must validate index, 8 bytes per.
            Tables_64 : Extended_SDT_Header_Pointer_Array (1 .. Length);
         when others =>
            null;
      end case;
   end record with Pack;

   for System_Descriptor_Table_Header use record
      Signature        at 0  range 0 .. 31;
      Length           at 4  range 0 .. 31;
      Revision         at 8  range 0 .. 7;
      Checksum         at 9  range 0 .. 7;
      OEM_ID           at 10 range 0 .. 47;
      OEM_Table_ID     at 16 range 0 .. 63;
      OEM_Revision     at 24 range 0 .. 31;
      Creator_ID       at 28 range 0 .. 31;
      Creator_Revision at 32 range 0 .. 31;
   end record;

   function Search return Address;

end System.ACPI;