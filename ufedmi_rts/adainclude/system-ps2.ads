package System.PS2 is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   type Buffer_Status is (EMPTY, FULL) with Size => 1;
   for Buffer_Status use (EMPTY => 0, FULL => 1);

   type Register_Type is (COMMAND, DATA) with Size => 1;
   for Register_Type use (COMMAND => 0, DATA => 1);

   type Error_Status is (OK, ERROR) with Size => 1;
   for Error_Status use (OK => 0, ERROR => 1);

   type Status is record
      Output_Buffer, Input_Buffer : Buffer_Status;
      POST_OK                     : Boolean;
      Data_Type                   : Register_Type;
      Reserved_1, Reserved_2      : Boolean;
      Time_Out, Parity            : Error_Status;
   end record with Size => 8;

   for Status use record
      Output_Buffer at 0 range 0 .. 0;
      Input_Buffer  at 0 range 1 .. 1;
      POST_OK       at 0 range 2 .. 2;
      Data_Type     at 0 range 3 .. 3;
      Reserved_1    at 0 range 4 .. 4;
      Reserved_2    at 0 range 5 .. 5;
      Time_Out      at 0 range 6 .. 6;
      Parity        at 0 range 7 .. 7;
   end record;

   type Controller_Command is
      (READ_FIRST_RAM,
       WRITE_FIRST_RAM,
       DISABLE_SECOND_PORT,
       ENABLE_SECOND_PORT,
       TEST_SECOND_PORT,
       TEST_CONTROLLER,
       TEST_FIRST_PORT,
       DIAGNOSTIC_DUMP_RAM,
       DISABLE_FIRST_PORT,
       ENABLE_FIRST_PORT,
       READ_CONTROLLER_INPUT,
       BLIT_INPUT_TO_STATUS_03_TO_47,
       BLIT_INPUT_TO_STATUS_47_TO_47,
       READ_CONTROLLER_OUTPUT,
       WRITE_OUTPUT,
       WRITE_FIRST_PORT_OUTPUT,
       WRITE_SECOND_PORT_OUTPUT,
       WRITE_SECOND_PORT_INPUT)
      with Size => 8;

   for Controller_Command use
      (READ_FIRST_RAM                => 16#20#,
       WRITE_FIRST_RAM               => 16#60#,
       DISABLE_SECOND_PORT           => 16#A7#,
       ENABLE_SECOND_PORT            => 16#A8#,
       TEST_SECOND_PORT              => 16#A9#,
       TEST_CONTROLLER               => 16#AA#,
       TEST_FIRST_PORT               => 16#AB#,
       DIAGNOSTIC_DUMP_RAM           => 16#AC#,
       DISABLE_FIRST_PORT            => 16#AD#,
       ENABLE_FIRST_PORT             => 16#AE#,
       READ_CONTROLLER_INPUT         => 16#C0#,
       BLIT_INPUT_TO_STATUS_03_TO_47 => 16#C1#,
       BLIT_INPUT_TO_STATUS_47_TO_47 => 16#C2#,
       READ_CONTROLLER_OUTPUT        => 16#D0#,
       WRITE_OUTPUT                  => 16#D1#,
       WRITE_FIRST_PORT_OUTPUT       => 16#D2#,
       WRITE_SECOND_PORT_OUTPUT      => 16#D3#,
       WRITE_SECOND_PORT_INPUT       => 16#D4#);

   type Controller_Configuration is record
      First_Port_Interrupts, Second_Port_Interrupts : Boolean;
      POST_OK                                       : Boolean;
      Reserved_1                                    : Boolean;
      First_Port_Clock, Second_Port_Clock           : Boolean;
      First_Post_Translation                        : Boolean;
      Reserved_2                                    : Boolean;
   end record with Size => 8;

   for Controller_Configuration use record
      First_Port_Interrupts  at 0 range 7 .. 7;
      Second_Port_Interrupts at 0 range 6 .. 6;
      POST_OK                at 0 range 5 .. 5;
      Reserved_1             at 0 range 4 .. 4;
      First_Port_Clock       at 0 range 3 .. 3;
      Second_Port_Clock      at 0 range 2 .. 2;
      First_Post_Translation at 0 range 1 .. 1;
      Reserved_2             at 0 range 0 .. 0;
   end record;

   type Controller_Output is record
      Reset                                 : Boolean;
      A20_Gate                              : Boolean;
      Second_Port_Clock, Second_Port_Data   : Boolean;
      First_Port_Buffer, Second_Port_Buffer : Buffer_Status;
      First_Port_Clock, First_Port_Data     : Boolean;
   end record with Size => 8;

   for Controller_Output use record
      Reset              at 0 range 0 .. 0;
      A20_Gate           at 0 range 1 .. 1;
      Second_Port_Clock  at 0 range 2 .. 2;
      Second_Port_Data   at 0 range 3 .. 3;
      First_Port_Buffer  at 0 range 4 .. 4;
      Second_Port_Buffer at 0 range 5 .. 5;
      First_Port_Clock   at 0 range 6 .. 6;
      First_Port_Data    at 0 range 7 .. 7;
   end record;

   function Read_Controller_Configuration return Controller_Configuration;

end System.PS2;