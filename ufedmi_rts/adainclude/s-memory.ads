with Interfaces;
with System.Storage_Elements;

package System.Memory is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   subtype Integer_Address is System.Storage_Elements.Integer_Address;

   type Segment_Descriptor is record
      Base         : Interfaces.Unsigned_32;
      Access_Flags : Interfaces.Unsigned_8;
      Flags        : Interfaces.Unsigned_4;
      Limit        : Interfaces.Unsigned_20;
   end record with Size => 64, Pack;

   type Segment_Descriptor_Table is array (Positive range <>) of
      Segment_Descriptor;

   procedure Write_Segment_Descriptor
      (Descriptor : Segment_Descriptor;
       Addr : Address);

   function Allocate (Length : Integer_Address) return Address with
      Export,
      Convention => C,
      Link_Name => "__gnat_malloc";

   function Copy_Bytes
      (To, From : Address;
       Length   : Integer_Address)
   return Address with
      Export,
      Convention => C,
      Link_Name => "memcpy";

   function Move_Bytes
      (To, From : Address;
       Length   : Integer_Address)
   return Address with
      Export,
      Convention => C,
      Link_Name => "memmove";

   function Compare_Bytes
      (A, B   : Address;
       Length : Integer_Address)
   return Integer with
      Export,
      Convention => C,
      Link_Name => "memcmp";

end System.Memory;