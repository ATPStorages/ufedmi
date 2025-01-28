with Interfaces; use Interfaces;

package System.PIC is
   pragma Pure;
   pragma No_Elaboration_Code_All;

   procedure Beep_Speaker (Frequency : Unsigned_32);
   procedure Stop_Speaker;
end System.PIC;