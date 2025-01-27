package System.Relative_Delays is

   type Reliable_Clock_Source_Access is access function return Duration;
   Reliable_Clock_Source_Entry : Reliable_Clock_Source_Access;

   procedure Delay_For (Time : Duration);

end System.Relative_Delays;