------------------------------------------------------------------------------
--                                                                          --
--               S Y S T E M . S T O R A G E _ E L E M E N T S              --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 2002-2024, Free Software Foundation, Inc.         --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the implementation dependent sections of this file.      --
--                                                                          --
------------------------------------------------------------------------------

--  Warning: declarations in this package are ambiguous with respect to the
--  extra declarations that can be introduced into System using Extend_System.
--  It is a good idea to avoid use clauses for this package.

package System.Storage_Elements with
  Always_Terminates
is
   pragma Pure;
   --  Note that we take advantage of the implementation permission to make
   --  this unit Pure instead of Preelaborable; see RM 13.7.1(15). In Ada 2005,
   --  this is Pure in any case (AI-362).

   type Storage_Offset is range -Memory_Size / 2 .. Memory_Size / 2 - 1;

   subtype Storage_Count is Storage_Offset range 0 .. Storage_Offset'Last;

   type Storage_Element is mod 2 ** Storage_Unit;
   for Storage_Element'Size use Storage_Unit;

   pragma Universal_Aliasing (Storage_Element);
   --  This type is used by the expander to implement aggregate copy

   type Storage_Array is
     array (Storage_Offset range <>) of aliased Storage_Element;
   for Storage_Array'Component_Size use Storage_Unit;

   --  Address arithmetic

   function "+" (Left : Address; Right : Storage_Offset) return Address;
   function "+" (Left : Storage_Offset; Right : Address) return Address;
   pragma Import (Intrinsic, "+");

   function "-" (Left : Address; Right : Storage_Offset) return Address;
   function "-" (Left, Right : Address) return Storage_Offset;
   pragma Import (Intrinsic, "-");

   function "mod"
     (Left  : Address;
      Right : Storage_Offset) return Storage_Offset;
   pragma Import (Intrinsic, "mod");

   --  Conversion to/from integers

   type Integer_Address is mod Memory_Size;

   function To_Address (Value : Integer_Address) return Address;
   pragma Import (Intrinsic, To_Address);

   function To_Integer (Value : Address) return Integer_Address;
   pragma Import (Intrinsic, To_Integer);

end System.Storage_Elements;
