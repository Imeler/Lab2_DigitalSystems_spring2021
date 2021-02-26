----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2021 09:59:52 PM
-- Design Name: 
-- Module Name: reg_file - Structural
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

entity reg_file is
    Port ( rd1 : in STD_LOGIC_VECTOR (2 downto 0);
           rd2 : in STD_LOGIC_VECTOR (2 downto 0);
           wr : in STD_LOGIC_VECTOR (2 downto 0);
           input : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           we : in STD_LOGIC;
           rst : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR (15 downto 0);
           out2 : out STD_LOGIC_VECTOR (15 downto 0));
end reg_file;

architecture Structural of reg_file is
    constant WIDTH: integer := 16;
    
    
    -- calling out reg_module module
component reg_module IS 
    generic( n: integer := WIDTH;
             r: integer := 0);
         
    Port (clk : in STD_LOGIC;
           we : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR(n-1 downto 0);
           output : out STD_LOGIC_VECTOR(n-1 downto 0));
end component;



-- calling out mux module

component mux_8_1 is
    generic( n: integer := WIDTH);
    
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
end component;



-- calling out decoder_3_8 module

component decoder_3_8 IS
    Port ( input : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0);
           en : in STD_LOGIC);
end component;

-- Create array type for mux inputs
    type array_8_16 IS ARRAY (0 to 7) OF STD_LOGIC_VECTOR (WIDTH-1 downto 0);

    -- inputs for mux
    signal mux_in : array_8_16;

    --Enable signal for each reg)module
    signal reg_en : std_logic_vector(7 downto 0);


begin
    
    -- Instantiate Decoder
    decoder_inst: decoder_3_8
    port map( 
        en     => we,
        input  => wr,
        output => reg_en);


    -- Generate 8 register modules
    reg_module_gen :  for i in 0 to 7
    
     generate
     -- Instantiate all reg_module (s)
        reg_module_inst: reg_module
        
        generic map ( n => WIDTH,
                      r => 0)
        
        port map(
            clk => clk,
            rst => rst,
            we => reg_en(i),
            input => input,
            output => mux_in(i)
            ); 
         end generate;
            
            
       -- Instantiate first mux 
       mux1_inst : mux_8_1
       generic map( n => WIDTH)
       
       port map (
            sel   => rd1,  
           input0 => mux_in(0),
           input1 => mux_in(1),
           input2 => mux_in(2),
           input3 => mux_in(3), 
           input4 => mux_in(4),
           input5 => mux_in(5),
           input6 => mux_in(6),
           input7 => mux_in(7),
           output => out1
           );
           
        -- Instantiate second mux
        mux2_inst : mux_8_1
       generic map( n => WIDTH)
       
       port map (
            sel   => rd2,  
           input0 => mux_in(0),
           input1 => mux_in(1),
           input2 => mux_in(2),
           input3 => mux_in(3), 
           input4 => mux_in(4),
           input5 => mux_in(5),
           input6 => mux_in(6),
           input7 => mux_in(7),
           output => out2
           );
          

end Structural;
