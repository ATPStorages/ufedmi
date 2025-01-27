package body System.Relative_Delays is

   procedure Delay_For (Time : Duration) is
   begin
      if Reliable_Clock_Source_Entry = null then
         return;
      end if;
      declare
         Start : constant Duration := Reliable_Clock_Source_Entry.all;
      begin
         loop
            if (Reliable_Clock_Source_Entry.all - Start) >= Time then
               exit;
            end if;
         end loop;
      end;
   end Delay_For;

end System.Relative_Delays;