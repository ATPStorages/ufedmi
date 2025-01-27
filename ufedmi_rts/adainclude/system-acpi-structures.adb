with System.Memory;
with System.Storage_Elements; use System.Storage_Elements;
package body System.ACPI.Structures is

   SDT_HBytes : constant Integer_Address :=
      System_Descriptor_Table_Header'Size / 8;
   RSDP_Bytes : constant Integer_Address :=
      Root_System_Description_Pointer'Size / 8;

   procedure Initialize is
      Start_Address : constant Address := Search;
      Holder        : Address;
      use type Interfaces.Unsigned_8;
   begin
      if Start_Address = Null_Address then
         return;
      end if;
      Holder := System.Memory.Copy_Bytes (RSDP'Address,
                                          Start_Address,
                                          RSDP_Bytes);
      if RSDP.Revision >= 2 then
         Holder := "+" (Start_Address, Storage_Offset (RSDP_Bytes));
         Holder := System.Memory.Copy_Bytes (XSDP'Address,
                                             Holder,
                                             XSDP'Size / 8);
         Holder := System.Memory.Copy_Bytes (SDT'Address,
                                             XSDP.Xsdt_Address,
                                             SDT_HBytes);
      else
         Holder := System.Memory.Copy_Bytes (SDT'Address,
                                             RSDP.Rsdt_Address,
                                             SDT_HBytes);
      end if;
   end Initialize;

end System.ACPI.Structures;