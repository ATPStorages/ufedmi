with System.Unsigned_Types;
package System.Img_Uns is

   subtype Unsigned is Unsigned_Types.Unsigned;

   procedure Image_Unsigned
     (Value        : Unsigned;
      Value_Image : in out String;
      Image_Length : out Natural);

end System.Img_Uns;