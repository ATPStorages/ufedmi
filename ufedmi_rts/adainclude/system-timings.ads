package System.Timings is

   type Reliable_Clock_Source_Access is access function return Duration;
   Reliable_Clock_Source_Entry : Reliable_Clock_Source_Access;

end System.Timings;