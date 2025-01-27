package System.ACPI.Structures is
   pragma Preelaborate;

   RSDP : Root_System_Description_Pointer;
   XSDP : Extended_Root_System_Description_Pointer;
   SDT  : System_Descriptor_Table;

   procedure Initialize;

end System.ACPI.Structures;