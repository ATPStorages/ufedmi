package Ada.Text_IO is

   type Status is (OK, WARNING, ERROR);

   procedure Status_Line (State : Status; Category : String);

   procedure Begin_Section;
   procedure End_Section;

   procedure Put_Line (Line : String);

   procedure Put (Line : String);

end Ada.Text_IO;