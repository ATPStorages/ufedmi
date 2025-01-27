with System.Storage_Elements;
package body System.ACPI is

   function Search return Address is
      Scan_Addr   : System.Storage_Elements.Integer_Address := 16#00080000#;
      Max_Address : System.Storage_Elements.Integer_Address := 16#00080400#;
      Tried_BIOS  : Boolean := False;
      use type System.Storage_Elements.Integer_Address;
   begin
      loop
         declare
            Addr  : constant Address :=
               System.Storage_Elements.To_Address (Scan_Addr);
            Check : String (1 .. 8) with Address => Addr;
         begin
            if Check = "RSD PTR " then
               return Addr;
            end if;
         end;
         Scan_Addr := Scan_Addr + 16;
         if Scan_Addr >= Max_Address then
            exit when Tried_BIOS;
            Tried_BIOS := True;
            Scan_Addr := 16#000E0000#;
            Max_Address := 16#000FFFFF#;
         end if;
      end loop;
      return Null_Address;
   end Search;

end System.ACPI;