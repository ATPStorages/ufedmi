package body System.Serial is

   function Serial_Initialize (Pin : CPU_Pin) return Boolean is
      INTERRUPT : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 1);
      INTR_FIFO : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 2);
      LINE_CTRL : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 3);
      MDEM_CTRL : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 4);
      COMM_PORT : CPU_Pin renames Pin;
   begin
      Write_Pin (INTERRUPT, 16#00#);
      Write_Pin (LINE_CTRL, 16#80#);
      Write_Pin (COMM_PORT, 16#03#);
      Write_Pin (INTERRUPT, 16#00#);
      Write_Pin (LINE_CTRL, 16#03#);
      Write_Pin (INTR_FIFO, 16#C7#);
      Write_Pin (MDEM_CTRL, 16#0B#);
      Write_Pin (MDEM_CTRL, 16#1E#);
      Write_Pin (COMM_PORT, 16#AE#);
      if Read_Pin (COMM_PORT) /= 16#AE# then
         return False;
      end if;
      Write_Pin (MDEM_CTRL, 16#0F#);
      return True;
   end Serial_Initialize;

   function Serial_Read_Waiting (Pin : CPU_Pin) return Unsigned_16
   is
      LINE_STAT : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 5);
   begin
      return Read_Pin (LINE_STAT) and 16#01#;
   end Serial_Read_Waiting;

   function Serial_Read_Char (Pin : CPU_Pin) return Character is
   begin
      loop
         exit when Serial_Read_Waiting (Pin) /= 0;
      end loop;
      return Character'Val (Read_Pin (Pin));
   end Serial_Read_Char;

   function Serial_Write_Waiting (Pin : CPU_Pin) return Unsigned_16
   is
      LINE_STAT : constant CPU_Pin := CPU_Pin'Enum_Val (Pin'Enum_Rep + 5);
   begin
      return Read_Pin (LINE_STAT) and 16#20#;
   end Serial_Write_Waiting;

   procedure Serial_Write_Char (Pin : CPU_Pin; Data : Character) is
   begin
      loop
         exit when Serial_Write_Waiting (Pin) /= 0;
      end loop;
      Write_Pin (Pin, Unsigned_16 (Character'Pos (Data)));
   end Serial_Write_Char;

   procedure Serial_Write_String (Pin : CPU_Pin; Data : String) is
   begin
      for Index in Data'Range loop
         Serial_Write_Char (Pin, Data (Index));
      end loop;
   end Serial_Write_String;

end System.Serial;