package body System.CGA_TextMode is

   --------------
   -- Put_Char --
   --------------

   procedure Put_Char (Fg, Bg : Color; Ch : Character) is
   begin
      Output (Y * COLS + X) := (Ch, Fg, Bg);
      X := X + 1;
      if X = COLS then
         X := 0;
         Y := Y + 1;
      end if;
   end Put_Char;

   ----------------
   -- Put_String --
   ----------------

   procedure Put_String (Fg, Bg : Color; S : String) is
   begin
      for I in S'Range loop
         if S (I) = ASCII.LF then
            X := 0;
            Y := Y + 1;
            goto Continue;
         end if;
         Put_Char (Fg, Bg, S (I));
         <<Continue>>
      end loop;
   end Put_String;

   -----------
   -- Clear --
   -----------

   procedure Clear (Bg : Color) is
   begin
      for C in Col'Range loop
            X := C;
         for R in Row'Range loop
            Y := R;
            Put_Char (Bg, Bg, ' ');
         end loop;
      end loop;
      X := 0;
      Y := 0;
   end Clear;

end System.CGA_TextMode;