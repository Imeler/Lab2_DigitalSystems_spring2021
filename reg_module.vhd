----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Sauvens Fleurinord
-- 
-- Create Date: 02/15/2021 07:31:45 PM
-- Design Name: 
-- Module Name: reg_module - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_module is

generic( n :  integer := 4;
         r : integer := 0);
        
    Port (clk : in STD_LOGIC;
           we : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR(n-1 downto 0);
           output : out STD_LOGIC_VECTOR(n-1 downto 0));
end reg_module;

architecture Behavioral of reg_module is

constant r_value : STD_LOGIC_VECTOR(n-1 downto 0) := conv_std_logic_vector(r,n);

begin
   P1: process (rst, clk)
         begin
            IF rst = '0' THEN
                 output <= r_value;
          ELSIF  rising_edge(clk)  THEN
               IF we = '1'    THEN
                 output <= input;
            END IF;
        END IF;
     END process;

end Behavioral;
