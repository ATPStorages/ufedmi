with System.CGA_TextMode; use System.CGA_TextMode;

package body Ada.Text_IO is

   procedure Put_Line (Line : String) is
   begin
      Put (Line & ASCII.LF);
   end Put_Line;

   procedure Put (Line : String) is
   begin
      Put_String (Str => Line);
   end Put;

end Ada.Text_IO;