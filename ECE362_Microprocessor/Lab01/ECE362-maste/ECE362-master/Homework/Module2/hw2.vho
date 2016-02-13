-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity mem92c12 is
  port (
    PA0 : in std_logic;
    PA1 : in std_logic;
    PA2 : in std_logic;
    PA3 : in std_logic;
    PA4 : in std_logic;
    PA5 : in std_logic;
    PA6 : in std_logic;
    PA7 : in std_logic;
    ECLK : in std_logic;
    RW : in std_logic;
    CS : out std_logic;
    OE : out std_logic;
    WE : out std_logic;
    LA8 : out std_logic;
    LA9 : out std_logic;
    LA10 : out std_logic;
    LA11 : out std_logic;
    LA12 : out std_logic;
    LA13 : out std_logic;
    LA14 : out std_logic;
    LA15 : out std_logic
  );
end mem92c12;

architecture NetList of mem92c12 is

  signal PA0PIN : std_logic;
  signal PA1PIN : std_logic;
  signal PA2PIN : std_logic;
  signal PA3PIN : std_logic;
  signal PA4PIN : std_logic;
  signal PA5PIN : std_logic;
  signal PA6PIN : std_logic;
  signal PA7PIN : std_logic;
  signal ECLKPIN : std_logic;
  signal RWPIN : std_logic;
  signal CSCOM : std_logic;
  signal OECOM : std_logic;
  signal WECOM : std_logic;
  signal LA8Q : std_logic;
  signal LA9Q : std_logic;
  signal LA10Q : std_logic;
  signal LA11Q : std_logic;
  signal LA12Q : std_logic;
  signal LA13Q : std_logic;
  signal LA14Q : std_logic;
  signal LA15Q : std_logic;
  signal T_0 : std_logic;
  signal T_1 : std_logic;
  signal T_2 : std_logic;
  signal GATE_T_0_A : std_logic;
  signal GATE_T_2_A : std_logic;

begin
  IN_PA0_I_1:   IBUF port map ( O=>PA0PIN, I0=>PA0 );
  IN_PA1_I_1:   IBUF port map ( O=>PA1PIN, I0=>PA1 );
  IN_PA2_I_1:   IBUF port map ( O=>PA2PIN, I0=>PA2 );
  IN_PA3_I_1:   IBUF port map ( O=>PA3PIN, I0=>PA3 );
  IN_PA4_I_1:   IBUF port map ( O=>PA4PIN, I0=>PA4 );
  IN_PA5_I_1:   IBUF port map ( O=>PA5PIN, I0=>PA5 );
  IN_PA6_I_1:   IBUF port map ( O=>PA6PIN, I0=>PA6 );
  IN_PA7_I_1:   IBUF port map ( O=>PA7PIN, I0=>PA7 );
  IN_ECLK_I_1:   IBUF port map ( O=>ECLKPIN, I0=>ECLK );
  IN_RW_I_1:   IBUF port map ( O=>RWPIN, I0=>RW );
  OUT_CS_I_1:   OBUF port map ( O=>CS, I0=>CSCOM );
  OUT_OE_I_1:   OBUF port map ( O=>OE, I0=>OECOM );
  OUT_WE_I_1:   OBUF port map ( O=>WE, I0=>WECOM );
  OUT_LA8_I_1:   OBUF port map ( O=>LA8, I0=>LA8Q );
  OUT_LA9_I_1:   OBUF port map ( O=>LA9, I0=>LA9Q );
  OUT_LA10_I_1:   OBUF port map ( O=>LA10, I0=>LA10Q );
  OUT_LA11_I_1:   OBUF port map ( O=>LA11, I0=>LA11Q );
  OUT_LA12_I_1:   OBUF port map ( O=>LA12, I0=>LA12Q );
  OUT_LA13_I_1:   OBUF port map ( O=>LA13, I0=>LA13Q );
  OUT_LA14_I_1:   OBUF port map ( O=>LA14, I0=>LA14Q );
  OUT_LA15_I_1:   OBUF port map ( O=>LA15, I0=>LA15Q );
  FF_LA8_I_1:   DFF port map ( D=>PA0PIN, Q=>LA8Q, CLK=>ECLKPIN );
  FF_LA9_I_1:   DFF port map ( D=>PA1PIN, Q=>LA9Q, CLK=>ECLKPIN );
  FF_LA10_I_1:   DFF port map ( D=>PA2PIN, Q=>LA10Q, CLK=>ECLKPIN );
  FF_LA11_I_1:   DFF port map ( D=>PA3PIN, Q=>LA11Q, CLK=>ECLKPIN );
  FF_LA12_I_1:   DFF port map ( D=>PA4PIN, Q=>LA12Q, CLK=>ECLKPIN );
  FF_LA13_I_1:   DFF port map ( D=>PA5PIN, Q=>LA13Q, CLK=>ECLKPIN );
  FF_LA14_I_1:   DFF port map ( D=>PA6PIN, Q=>LA14Q, CLK=>ECLKPIN );
  FF_LA15_I_1:   DFF port map ( D=>PA7PIN, Q=>LA15Q, CLK=>ECLKPIN );
  GATE_T_0_I_1:   AND2 port map ( O=>T_0, I1=>ECLKPIN, I0=>GATE_T_0_A );
  GATE_T_0_I_2:   INV port map ( O=>GATE_T_0_A, I0=>LA15Q );
  GATE_T_1_I_1:   AND2 port map ( O=>T_1, I1=>RWPIN, I0=>ECLKPIN );
  GATE_T_2_I_1:   AND2 port map ( O=>T_2, I1=>ECLKPIN, I0=>GATE_T_2_A );
  GATE_T_2_I_2:   INV port map ( O=>GATE_T_2_A, I0=>RWPIN );
  GATE_CS_I_1:   INV port map ( I0=>T_0, O=>CSCOM );
  GATE_OE_I_1:   INV port map ( I0=>T_1, O=>OECOM );
  GATE_WE_I_1:   INV port map ( I0=>T_2, O=>WECOM );

end NetList;
