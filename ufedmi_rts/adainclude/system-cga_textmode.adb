package body System.CGA_TextMode is

   procedure New_Line is
   begin
      X := 0;
      Y := Y + 1;
      if Y > ROWS then
         Clear;
         Y := 0;
      end if;
   end New_Line;

   --------------
   -- Put_Char --
   --------------

   procedure Put_Char
      (Foreground : Color := Foreground_Color;
       Background : Color := Background_Color;
       Char : Character)
   is
   begin
      if Char = ASCII.LF or else Y = ROWS then
         New_Line;
         if Char = ASCII.LF then
            return;
         end if;
      end if;
      Output (Y * COLS + X) := (Char, Foreground, Background);
      X := X + 1;
      if X = COLS then
         New_Line;
      end if;
   end Put_Char;

   ----------------
   -- Put_String --
   ----------------

   procedure Put_String
      (Foreground : Color := Foreground_Color;
       Background : Color := Background_Color;
       Str : String)
   is
   begin
      for I in Str'Range loop
         Put_Char (Foreground, Background, Str (I));
      end loop;
   end Put_String;

   -----------
   -- Clear --
   -----------

   procedure Clear (Background : Color := Background_Color)
   is
   begin
      for C in Col'Range loop
         for R in Row'Range loop
            Output (R * COLS + C) := (' ', Background, Background);
         end loop;
      end loop;
      X := 0;
      Y := 0;
   end Clear;

end System.CGA_TextMode;