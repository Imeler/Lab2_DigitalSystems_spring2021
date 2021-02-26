----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2021 08:57:55 AM
-- Design Name: 
-- Module Name: reg_file_tb - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file_tb is
--  Port ( );
end reg_file_tb;

architecture Behavioral of reg_file_tb is

-- Component declaration
component reg_file is 
    Port ( rd1 : in STD_LOGIC_VECTOR (2 downto 0);
           rd2 : in STD_LOGIC_VECTOR (2 downto 0);
           wr : in STD_LOGIC_VECTOR (2 downto 0);
           input : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           we : in STD_LOGIC;
           rst : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR (15 downto 0);
           out2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Period to wait for one clock jcycle
constant PERIOD :  time := 40 ns;

-- Test bench signals
     signal      rd1    :  STD_LOGIC_VECTOR (2 downto 0);
     signal      rd2    :  STD_LOGIC_VECTOR (2 downto 0);
     signal      wr     :  STD_LOGIC_VECTOR (2 downto 0);
     signal      input  :  STD_LOGIC_VECTOR (15 downto 0);
     signal      clk    :  STD_LOGIC;
     signal      we     :  STD_LOGIC;
     signal      rst    :  STD_LOGIC;
     signal      out1   :  STD_LOGIC_VECTOR (15 downto 0);
     signal      out2   :  STD_LOGIC_VECTOR (15 downto 0);


begin

    -- Instantiate reg_file
    reg_file_inst: reg_file
    port map(
        rd1    => rd1,
        rd2    => rd2,
        wr     => wr,
        input  => input,
        clk    => clk,
        we     => we,
        rst    => rst,
        out1   => out1,
        out2   => out2
        );
        
      -- generate clock signal
      clk_gen : process
        begin
            clk  <= '0';
            wait for PERIOD/2;
            clk  <= '1';
            wait for PERIOD/2;
        end process;
        
        -- Test bench statement
        tb: process
        begin
            wait for PERIOD;
            -- Instantiate all inputs and reset all registers to 0
            rst <= '0';
            we <= '0';
            rd1 <= "000";
            rd2 <= "000";
            wr  <= "000";
            input <= conv_std_logic_vector(0,16);
              
            wait for PERIOD;
            
            -- release reset button
            rst <= '1';
            
            -- test wrting to each register
            we <= '1';
            for i in 0 to 7 loop
                wr <= conv_std_logic_vector(i,3);
                input <= conv_std_logic_vector(i+16,16);
                wait for PERIOD;
                rd1 <= conv_std_logic_vector(i,3);
                end loop; 
         
                wait for period;
                
                -- test rd1 and rd2
                rd1 <= conv_std_logic_vector(4,3);
                rd2 <= conv_std_logic_vector(5,3);
                wait for PERIOD;
                
                -- Test writing to each register with write enable off
                we <= '0';
                for i in 0 to 7 loop
                wr <= conv_std_logic_vector(i,3);
                input <= conv_std_logic_vector(i,16);
                wait for PERIOD;
                rd2 <= conv_std_logic_vector(i,3);
                end loop; 
                
                wait for PERIOD;
                
                -- Test reset button
                rst <= '0';
                wait for PERIOD;
                rst <= '1';
                wait for PERIOD;
                
                -- Check every register is reset to 0
                for i in 0 to 7 loop
                    wr <= conv_std_logic_vector(i,3);
                    rd1 <= conv_std_logic_vector(i,3);
                    rd2 <= conv_std_logic_vector(i,3);
                    wait for PERIOD;
                end loop;
                
                wait;
                end process;

end Behavioral;
