----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2024 21:15:07
-- Design Name: 
-- Module Name: instruction_processor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_processor is
  Port (clk, reset: in std_logic;
  DoData, RD, WR: out std_logic;
  PC: inout std_logic_vector(15 downto 0);
  instruction_register: out std_logic_vector(7 downto 0);
  IOM,ALE,S1,S0 : out std_logic;
  A: out std_logic_vector(15 downto 8);
  AD: inout std_logic_vector(7 downto 0));
end instruction_processor;

architecture Behavioral of instruction_processor is
signal pc_int :std_logic_vector(15 downto 0):= "0000000000000000";
signal next_pc: std_logic_vector(15 downto 0):= "0000000000000000";
signal branch: std_logic:= '1';
signal int_inst: std_logic_vector(7 downto 0);
type instruction_decoder_state is (T1, T2, T3);
signal curr_state, next_state: instruction_decoder_state:= T1;
begin
process is
begin
if rising_edge(clk) then
    if reset='1' then
        curr_state <= T1;
        next_state <= T1;
        pc_int <= "0000000000000000";
        next_pc <= "0000000000000000";
        PC <= "0000000000000000";
    else
        if curr_state = T1 then
            DoData <= '0';
            WR <= '0';
            RD <= '0';
            pc_int <= PC;
            A <= pc_int(15 downto 8);
            AD <= pc_int(7 downto 0);
            ALE <= '1';
            next_pc <= pc_int;
            next_state <= T2;
        elsif curr_state = T2 then
            IOM <= '0';
            S1 <= '1';
            S0 <= '1';
            ALE <='0';
            WR <= '1';
            RD <= '0';
            int_inst <= AD;
            next_state <= T3;
            next_pc <= pc_int;
        elsif curr_state = T3 then
            IOM <= '0';
            S1 <= '1';
            S0 <= '1';
            ALE <='0';
            WR <= '0';
            RD <= '1';
            if branch = '1' then
                next_pc <= std_logic_vector(unsigned(pc_int) + 1);
                instruction_register <= int_inst;
                DoData <= '1';
            end if;
            pc_int <= next_pc;
            next_state <= T1;
        end if; 
        PC <= next_pc;
        curr_state <= next_state;
    end if;
end if;
end process;
end Behavioral;
