----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2024 08:52:02 AM
-- Design Name: 
-- Module Name: ip_simcheck - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ip_simcheck is
--  Port ( );
end ip_simcheck;

architecture Behavioral of ip_simcheck is

component instruction_processor is 
Port (clk, reset: in std_logic;
  DoData, RD, WR: out std_logic;
  PC: inout std_logic_vector(15 downto 0);
  instruction_register: out std_logic_vector(7 downto 0);
  IOM,ALE,S1,S0 : out std_logic;
  A: out std_logic_vector(15 downto 8);
  AD: inout std_logic_vector(7 downto 0));
end component instruction_processor;

signal rd, wr, iom, s1, s0: std_logic:= '1';
signal clock, Reset, dodata, ale: std_logic:= '0';
signal a, ad, ins_reg: std_logic_vector(7 downto 0);
signal pc: std_logic_vector(15 downto 0);

begin

ins_pr : instruction_processor 
    port map(clk => clock, 
    reset => Reset, 
    DoData => dodata, 
    RD => rd, 
    WR => wr, 
    PC => pc, 
    instruction_register => ins_reg,
    IOM => iom,
    ALE => ale,
    S1 => s1,
    S0 => s0,
    A => a,
    AD => ad
    );

process is
begin
pc <= "0001001010011010";
clock <= '1';
wait for 10ns;
clock <= '0';
wait for 10ns;
ad <= "10100010";
clock <= '1';
wait for 10ns;
clock <= '0';
wait for 10ns;
clock <= '1';
wait for 10ns;
clock <= '0';
wait for 10ns;
wait;
end process;

end Behavioral;
