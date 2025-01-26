package body System is

   procedure Overflow_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Overflow_Check;

   procedure Range_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Range_Check;

   procedure Index_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Index_Check;

   procedure Length_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Length_Check;

   procedure Invalid_Check
      (File : Address;
       Line : Integer)
   is
      pragma Unreferenced (File);
      pragma Unreferenced (Line);
   begin
      null;
   end Invalid_Check;

end System;