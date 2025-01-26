with System.Storage_Elements;

package System.CGA_TextMode is

   type Color is (BLACK, BRIGHT);

   for Color'Size use 4;
   for Color use (BLACK => 0, BRIGHT => 7);

   type Text_Buffer_Char is
      record
         Ch : Character;
         Fg : Color;
         Bg : Color;
      end record;

   for Text_Buffer_Char use
      record
         Ch at 0 range 0 .. 7;
         Fg at 1 range 0 .. 3;
         Bg at 1 range 4 .. 7;
      end record;

   type Text_Buffer is array (Natural range <>) of Text_Buffer_Char;

   COLS : constant := 80;
   ROWS : constant := 25;

   subtype Col is Natural range 0 .. COLS - 1;
   subtype Row is Natural range 0 .. ROWS - 1;

   Output : Text_Buffer (0 .. (COLS * ROWS) - 1);
   for Output'Address use System.Storage_Elements.To_Address (16#B8000#);

   X : Natural := 0;
   Y : Natural := 0;

   procedure New_Line;

   procedure Put_Char (Fg, Bg : Color; Ch : Character);
   procedure Put_String (Fg, Bg : Color; S : String);
   procedure Clear (Bg : Color);

end System.CGA_TextMode;