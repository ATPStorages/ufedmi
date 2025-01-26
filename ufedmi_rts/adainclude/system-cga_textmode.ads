with System.Storage_Elements;

package System.CGA_TextMode is

   type Base_Color is
      (BLACK,
       BLUE,
       GREEN,
       CYAN,
       RED,
       MAGENTA,
       BROWN,
       WHITE)
   with Size => 3;

   for Base_Color use
      (BLACK => 2#000#,
       BLUE => 2#001#,
       GREEN => 2#010#,
       CYAN => 2#011#,
       RED => 2#100#,
       MAGENTA => 2#101#,
       BROWN => 2#110#,
       WHITE => 2#111#);

   type Color is record
      Bright : Boolean;
      Color  : Base_Color;
   end record with Size => 4;

   for Color use record
      Color  at 0 range 0 .. 2;
      Bright at 0 range 3 .. 3;
   end record;

   type Screen_Character is record
      Char                   : Character;
      Foreground, Background : Color;
   end record with Size => 16;

   for Screen_Character use record
      Char       at 0 range 0 .. 7;
      Foreground at 1 range 0 .. 3;
      Background at 1 range 4 .. 7;
   end record;

   COLS : constant := 80;
   ROWS : constant := 25;

   subtype Col is Natural range 0 .. COLS - 1;
   subtype Row is Natural range 0 .. ROWS - 1;

   type Text_Buffer is array (Natural range <>) of Screen_Character;
   Output : Text_Buffer (0 .. (COLS * ROWS) - 1)
      with Address => System.Storage_Elements.To_Address (16#B8000#);

   C : Natural := 6;
   X : Natural := C;
   Y : Natural := 0;

   Foreground_Color : Color := (True, WHITE);
   Background_Color : Color := (False, BROWN);

   procedure New_Line;

   procedure Put_Char
      (Foreground : Color := Foreground_Color;
       Background : Color := Background_Color;
       Char : Character);

   procedure Put_String
      (Foreground : Color := Foreground_Color;
       Background : Color := Background_Color;
       Str : String);

   procedure Clear (Background : Color := Background_Color);

end System.CGA_TextMode;