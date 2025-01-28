with Interfaces; use Interfaces;
with System.Low_Level; use System.Low_Level;
package System.Serial is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   function Serial_Initialize (Pin : CPU_Pin) return Boolean;

   function Serial_Read_Waiting (Pin : CPU_Pin) return Unsigned_16;
   function Serial_Read_Char (Pin : CPU_Pin) return Character;

   function Serial_Write_Waiting (Pin : CPU_Pin) return Unsigned_16;
   procedure Serial_Write_Char (Pin : CPU_Pin; Data : Character);
   procedure Serial_Write_String (Pin : CPU_Pin; Data : String);

end System.Serial;