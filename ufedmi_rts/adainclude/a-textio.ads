with System.Low_Level;

package Ada.Text_IO is
   pragma No_Elaboration_Code_All;

   type Status is (OK, WARNING, ERROR);

   COM : System.Low_Level.CPU_Pin := System.Low_Level.NONE;

   procedure Status_Line (State : Status; Category : String);

   procedure Begin_Section;
   procedure End_Section;

   procedure Put_Line (Line : String);

   procedure Put (Line : String);

end Ada.Text_IO;