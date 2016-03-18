
-- VHDL Test Bench Created from source file mem92c12.vhd -- Mon Oct 01 13:37:13 2012
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT mem92c12
	PORT(
		RW : IN std_logic;
		PA7 : IN std_logic;
		PA6 : IN std_logic;
		PA5 : IN std_logic;
		PA4 : IN std_logic;
		PA3 : IN std_logic;
		PA2 : IN std_logic;
		PA1 : IN std_logic;
		PA0 : IN std_logic;
		ECLK : IN std_logic;          
		WE : OUT std_logic;
		OE : OUT std_logic;
		LA9 : OUT std_logic;
		LA8 : OUT std_logic;
		LA15 : OUT std_logic;
		LA14 : OUT std_logic;
		LA13 : OUT std_logic;
		LA12 : OUT std_logic;
		LA11 : OUT std_logic;
		LA10 : OUT std_logic;
		CS : OUT std_logic
		);
	END COMPONENT;

	SIGNAL WE :  std_logic;
	SIGNAL RW :  std_logic;
	SIGNAL PA7 :  std_logic;
	SIGNAL PA6 :  std_logic;
	SIGNAL PA5 :  std_logic;
	SIGNAL PA4 :  std_logic;
	SIGNAL PA3 :  std_logic;
	SIGNAL PA2 :  std_logic;
	SIGNAL PA1 :  std_logic;
	SIGNAL PA0 :  std_logic;
	SIGNAL OE :  std_logic;
	SIGNAL LA9 :  std_logic;
	SIGNAL LA8 :  std_logic;
	SIGNAL LA15 :  std_logic;
	SIGNAL LA14 :  std_logic;
	SIGNAL LA13 :  std_logic;
	SIGNAL LA12 :  std_logic;
	SIGNAL LA11 :  std_logic;
	SIGNAL LA10 :  std_logic;
	SIGNAL ECLK :  std_logic;
	SIGNAL CS :  std_logic;

BEGIN

	uut: mem92c12 PORT MAP(
		WE => WE,
		RW => RW,
		PA7 => PA7,
		PA6 => PA6,
		PA5 => PA5,
		PA4 => PA4,
		PA3 => PA3,
		PA2 => PA2,
		PA1 => PA1,
		PA0 => PA0,
		OE => OE,
		LA9 => LA9,
		LA8 => LA8,
		LA15 => LA15,
		LA14 => LA14,
		LA13 => LA13,
		LA12 => LA12,
		LA11 => LA11,
		LA10 => LA10,
		ECLK => ECLK,
		CS => CS
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
