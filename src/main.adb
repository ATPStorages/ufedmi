with Ada.Text_IO; use Ada.Text_IO;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;

procedure Main is
begin
   Clear;
   Disable_Interrupts;
   Put_Line ("UFEDMI starting...");
end Main;