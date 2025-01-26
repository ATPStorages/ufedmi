with System.Storage_Elements;

with Interfaces; use Interfaces;
with System.Low_Level; use System.Low_Level;

procedure Main is

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


   type Text_Buffer is
     array (Natural range <>) of Text_Buffer_Char;


   COLS : constant := 80;
   ROWS : constant := 24;   

   subtype Col is Natural range 0 .. COLS - 1;
   subtype Row is Natural range 0 .. ROWS - 1;


   Output : Text_Buffer (0 .. (COLS * ROWS) - 1);
   for Output'Address use System.Storage_Elements.To_Address (16#B8000#);


   --------------
   -- Put_Char --
   --------------

   procedure Put_Char (X : Col; Y : Row; Fg, Bg : Color; Ch : Character) is
   begin
      Output (Y * COLS + X) := (Ch, Fg, Bg);
   end Put_Char;

   ----------------
   -- Put_String --
   ----------------

   procedure Put_String (X : Col; Y : Row; Fg, Bg : Color; S : String) is
      C : Natural := 0;
   begin
      for I in S'Range loop
         Put_Char (X + C, Y, Fg, Bg, S (I));
         C := C + 1;
      end loop;
   end Put_String;

   -----------
   -- Clear --
   -----------

   procedure Clear (Bg : Color) is
   begin
      for X in Col'Range loop
         for Y in Row'Range loop
            Put_Char (X, Y, Bg, Bg, ' ');
         end loop;
      end loop;
   end Clear;

   I : Unsigned_32 := 0;
begin
   Clear (BLACK);
   Put_String (1, 1, BLACK, BRIGHT, "Now running.                   Counter:");
   Put_String (1, 2, BLACK, BRIGHT, "                                       ");
   Put_String (1, 3, BLACK, BRIGHT, "---------------------------------------");

   Disable_Interrupts;

   while (True) loop
      I := I + 1;
      Put_String (1, 2, BRIGHT, BLACK, I'Image);
      delay 1.0;
   end loop;
end Main;