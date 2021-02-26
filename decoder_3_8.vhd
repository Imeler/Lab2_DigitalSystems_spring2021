----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Sauvens Fleurinord
-- 
-- Create Date: 02/15/2021 08:54:08 PM
-- Design Name: 
-- Module Name: decoder_3_8 - dataflow
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

entity decoder_3_8 is
    Port ( input : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0);
           en : in STD_LOGIC);
end decoder_3_8;

architecture dataflow of decoder_3_8 is
signal enw: std_logic_vector(3 downto 0);

begin
  enw <= en & input;
    WITH enw SELECT
        output <= "00000001"  WHEN "1000",
                  "00000010"  WHEN "1001",
                  "00000100"  WHEN "1010",
                  "00001000"  WHEN "1011",
                  "00010000"  WHEN "1100",
                  "00100000"  WHEN "1101",
                  "01000000"  WHEN "1110",
                  "10000000"  WHEN "1111",
                  "00000000"  WHEN others;

end dataflow;
