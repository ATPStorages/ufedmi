with Ada.Text_IO; use Ada.Text_IO;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;

procedure Main is
   I : Integer := 0;
begin
   Clear (BLACK);
   Disable_Interrupts;
   Put_Line ("UFEDMI starting...");
   for L in 1 .. 100 loop
      Put_Line ("Dummy" & L'Image);
      for X in 1 .. 100000000 loop
         I := I + X;
      end loop;
   end loop;
   Put_Line (I'Image);
   loop
      null;
   end loop;
end Main;