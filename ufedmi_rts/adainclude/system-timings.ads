package System.Timings is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   type Reliable_Clock_Source_Access is access function return Duration;
   Reliable_Clock_Source_Entry : Reliable_Clock_Source_Access;

end System.Timings;