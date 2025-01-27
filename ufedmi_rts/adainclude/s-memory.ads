with System.Storage_Elements;

package System.Memory is

   subtype Integer_Address is System.Storage_Elements.Integer_Address;

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

end System.Memory;