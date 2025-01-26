with Ada.Text_IO; use Ada.Text_IO;
with System.Low_Level; use System.Low_Level;
with System.CGA_TextMode; use System.CGA_TextMode;

procedure Main is
begin
   Clear;
   Disable_Interrupts;
   Put_Line ("UFEDMI starting...");
   Status_Line (OK, "Dummy information");
   Begin_Section;
   Put_Line ("Stuff A");
   Put_Line ("Stuff B");
   Status_Line (OK, "End");
   End_Section;
   Status_Line (WARNING, "Dummy warning");
   Status_Line (ERROR, "Dummy error");
   Begin_Section;
   Put_Line ("Issue");
   Put_Line ("End");
   End_Section;
end Main;