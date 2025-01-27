with Interfaces;
package System.PS2.Keyboard is

   type Keyboard_Command is
      (CONFIGURE_LOCKS,
       ECHO,
       CONFIGURE_CODE_SET,
       IDENTIFY,
       CONFIGURE_TYPEMATIC,
       ENABLE_SCAN_CODES,
       DISABLE_SCAN_CODES,
       RESET_PARAMETERS,
       SET_TYPEMATIC_ALL_SET_3,
       SET_PRESS_RELEASE_ALL_SET_3,
       SET_PRESS_ONLY_ALL_SET_3,
       RESET_ALL_SET_3,
       SET_TYPEMATIC_SPECIFIC_SET_3,
       SET_PRESS_RELEASE_SPECIFIC_SET_3,
       SET_PRESS_ONLY_SPECIFIC_SET_3,
       RESEND_LAST,
       RESET_AND_TEST)
      with Size => 8;

   for Keyboard_Command use
      (CONFIGURE_LOCKS                  => 16#ED#,
       ECHO                             => 16#EE#,
       CONFIGURE_CODE_SET               => 16#F0#,
       IDENTIFY                         => 16#F2#,
       CONFIGURE_TYPEMATIC              => 16#F3#,
       ENABLE_SCAN_CODES                => 16#F4#,
       DISABLE_SCAN_CODES               => 16#F5#,
       RESET_PARAMETERS                 => 16#F6#,
       SET_TYPEMATIC_ALL_SET_3          => 16#F7#,
       SET_PRESS_RELEASE_ALL_SET_3      => 16#F8#,
       SET_PRESS_ONLY_ALL_SET_3         => 16#F9#,
       RESET_ALL_SET_3                  => 16#FA#,
       SET_TYPEMATIC_SPECIFIC_SET_3     => 16#FB#,
       SET_PRESS_RELEASE_SPECIFIC_SET_3 => 16#FC#,
       SET_PRESS_ONLY_SPECIFIC_SET_3    => 16#FD#,
       RESEND_LAST                      => 16#FE#,
       RESET_AND_TEST                   => 16#FF#);

   type Keyboard_Response is
      (ERROR_LOW,
       SELF_TEST_OK,
       ECHO,
       ACKNOWLEDGED,
       SELF_TEST_FAILURE_COMMAND,
       SELF_TEST_FAILURE_POWER,
       RESEND,
       ERROR_HIGH)
      with Size => 8;

   for Keyboard_Response use
      (ERROR_LOW                 => 16#00#,
       SELF_TEST_OK              => 16#AA#,
       ECHO                      => 16#EE#,
       ACKNOWLEDGED              => 16#FA#,
       SELF_TEST_FAILURE_COMMAND => 16#FC#,
       SELF_TEST_FAILURE_POWER   => 16#FD#,
       RESEND                    => 16#FE#,
       ERROR_HIGH                => 16#FF#);

   type Scan_Code_Array is array (Character range <>) of Interfaces.Unsigned_8;

   Set_3_Scan_Codes : constant Scan_Code_Array ('A' .. 'Z') :=
      (16#1C#, 16#32#, 16#21#, 16#23#, 16#24#, 16#2B#, 16#34#, 16#33#, 16#43#,
       16#3B#, 16#42#, 16#4B#, 16#3A#, 16#31#, 16#44#, 16#4D#, 16#15#, 16#2D#,
       16#1b#, 16#2C#, 16#3C#, 16#2A#, 16#1D#, 16#22#, 16#35#, 16#1A#);

end System.PS2.Keyboard;