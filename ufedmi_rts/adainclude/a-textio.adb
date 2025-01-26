package body Ada.Text_IO is

   LF : constant Character := Character'Val (10);

   procedure Put_Line (Line : String) is
   begin
      Put (Line & LF);
   end Put_Line;

   procedure Put (Line : String) is
   begin
      null;
   end Put;

end Ada.Text_IO;