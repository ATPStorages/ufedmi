with System.CGA_TextMode; use System.CGA_TextMode;
with System.Serial;

package body Ada.Text_IO is

   Status_Colors : constant array (Status'First .. Status'Last) of Color :=
      ((True, GREEN), (True, BROWN), (True, RED));

   procedure Status_Line (State : Status; Category : String) is
      Saved_Foreground : constant Color := Foreground_Color;
   begin
      C := C - 6;
      X := C;
      Put ("[");
      Foreground_Color := Status_Colors (State);
      case State is
         when OK      => Put ("INF");
         when WARNING => Put ("WRN");
         when ERROR   => Put ("ERR");
      end case;
      Foreground_Color := Saved_Foreground;
      Put ("] ");
      C := C + 6;
      Put_Line (Category
         (Category'First .. Category'Size / Category'Component_Size));
   end Status_Line;

   procedure Begin_Section is
   begin
      C := C + 1;
      X := C;
   end Begin_Section;

   procedure End_Section is
   begin
      C := C - 1;
      X := C;
   end End_Section;

   procedure Put_Line (Line : String) is
   begin
      Put (Line & ASCII.LF);
   end Put_Line;

   procedure Put (Line : String) is
      use type System.Low_Level.CPU_Pin;
   begin
      if COM /= System.Low_Level.NONE then
         System.Serial.Serial_Write_String (COM, Line);
      end if;
      Put_String (Str => Line);
   end Put;

end Ada.Text_IO;