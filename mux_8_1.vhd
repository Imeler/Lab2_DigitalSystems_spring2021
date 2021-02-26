----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Sauvens Fleurinord
-- 
-- Create Date: 02/15/2021 08:34:39 PM
-- Design Name: 
-- Module Name: mux_8_1 - dataflow
-- Project Name: Lab2_DigitalSystems
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

entity mux_8_1 is
    generic( n: integer := 16);
    
    Port (  sel    : in STD_LOGIC_VECTOR(2 downto 0);
           input0 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input1 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input2 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input3 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input4 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input5 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input6 : in STD_LOGIC_VECTOR(n-1 downto 0);
           input7 : in STD_LOGIC_VECTOR(n-1 downto 0);
           output : out STD_LOGIC_VECTOR(n-1 downto 0));
end mux_8_1;

architecture dataflow of mux_8_1 is

begin
    with sel select
        output <= input0 WHEN "000",
                  input1 WHEN "001",
                  input2 WHEN "010",
                  input3 WHEN "011",
                  input4 WHEN "100",
                  input5 WHEN "101",
                  input6 WHEN "110",
                  input7 WHEN others;

end dataflow;
