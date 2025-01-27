with Ada.Unchecked_Conversion;
with Interfaces;
with System.Low_Level; use System.Low_Level;

package body System.PS2 is

   function Read_Controller_Configuration return Controller_Configuration is
      function Convert_Byte is new Ada.Unchecked_Conversion
         (Interfaces.Unsigned_8, Controller_Configuration);
   begin
      Write_Pin (PS_2_REGISTER, 16#20#);
      return Convert_Byte (Interfaces.Unsigned_8 (Read_Pin (PS_2_DATA)));
   end Read_Controller_Configuration;

end System.PS2;