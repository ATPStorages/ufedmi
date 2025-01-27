with System.Memory;
with System.Storage_Elements;
package body System.ACPI.Structures is

   procedure Initialize is
      Start_Address : constant Address := Search;
      Holder        : Address;
      use type System.Storage_Elements.Integer_Address;
      use type Interfaces.Unsigned_8;
   begin
      if Start_Address = Null_Address then
         return;
      end if;
      Holder := System.Memory.Copy_Bytes (RSDP'Address,
                                          Start_Address,
                                          RSDP'Size / 8);
      if RSDP.Revision >= 2 then
         Holder := System.Storage_Elements."+" (RSDP'Address,
                                                (RSDP'Size / 8));
         Holder := System.Memory.Copy_Bytes (XSDP'Address,
                                             Holder,
                                             XSDP'Size / 8);
      end if;
   end Initialize;

end System.ACPI.Structures;