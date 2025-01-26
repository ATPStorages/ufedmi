package body System.CGA_TextMode is

   procedure New_Line is
   begin
      X := 0;
      Y := Y + 1;
      if Y > ROWS then
         Clear (BLACK);
         Y := 0;
      end if;
   end New_Line;

   --------------
   -- Put_Char --
   --------------

   procedure Put_Char (Fg, Bg : Color; Ch : Character) is
   begin
      if Ch = ASCII.LF or else Y = ROWS then
         New_Line;
         if Ch = ASCII.LF then
            return;
         end if;
      end if;
      Output (Y * COLS + X) := (Ch, Fg, Bg);
      X := X + 1;
      if X = COLS then
         New_Line;
      end if;
   end Put_Char;

   ----------------
   -- Put_String --
   ----------------

   procedure Put_String (Fg, Bg : Color; S : String) is
   begin
      for I in S'Range loop
         Put_Char (Fg, Bg, S (I));
      end loop;
   end Put_String;

   -----------
   -- Clear --
   -----------

   procedure Clear (Bg : Color) is
   begin
      for C in Col'Range loop
         for R in Row'Range loop
            Output (R * COLS + C) := (' ', Bg, Bg);
         end loop;
      end loop;
      X := 0;
      Y := 0;
   end Clear;

end System.CGA_TextMode;