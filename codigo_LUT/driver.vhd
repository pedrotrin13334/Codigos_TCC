----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2018 02:22:06 PM
-- Design Name: 
-- Module Name: driver - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity driver is
 Port ( sig : in STD_LOGIC;
        clk : in STD_LOGIC;
        str_out : out STD_LOGIC_VECTOR(7 downto 0);
        timer_out : out unsigned( 7 downto 0);
        clk_ctrl1 : out STD_LOGIC;
        enab : out STD_LOGIC
        );
end driver;

architecture Behavioral of driver is

signal sig_out : unsigned( 7 downto 0) := (others => '0');
signal  timer : unsigned(7 downto 0) := (others => '0');
signal sample : STD_LOGIC := '0';
signal clk_ctrl: STD_LOGIC := '0';
signal enable : STD_LOGIC := '0'; 
signal clk_sup : STD_LOGIC := '0';

--type MEM is array (105 downto 0) of integer range 0 to 255;
--constant SAMP : MEM := (17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,16 ,17 ,17 ,18 ,17 ,16 ,17 ,18 ,18 ,16 ,15 ,18 ,19 ,17 ,13 ,15 ,22 ,23 ,12 ,0 ,17 ,84 ,182 ,254 ,254 ,182 ,84 ,17 ,0 ,12 ,23 ,22 ,15 ,13 ,17 ,19 ,18 ,15 ,16 ,18 ,18 ,17 ,16 ,17 ,18 ,17 ,17 ,16 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17 ,17) ;
type MEM is array (165 downto 0) of integer range 0 to 255;
--constant SAMP : MEM := (19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 17 , 17 , 19 , 12 , 0 , 36 , 154 , 255 , 255 , 154 , 36 , 0 , 12 , 19 , 17 , 17 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 );
constant SAMP : MEM := ( 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 17 , 17 , 19 , 12 , 0 , 36 , 154 , 255 , 255 , 154 , 36 , 0 , 12 , 19 , 17 , 17 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 , 19 );
constant T_sig: integer := 500000;
constant T_clk: integer := 1;
constant samples_len: integer := 166;
constant T_samples: integer := T_sig / samples_len;
constant num_samp : integer := T_samples/T_clk; 


begin


clk_ctrl1 <= clk_ctrl; 
enab <= enable;
--clk_ctrl <= clk;

Beginning: process(sig)
    begin
    if (sig'event and sig='1') then --or (sig'event and sig='0') then
    --str_out <= "00001000";
    --clk_ctrl <= clk;
     enable <= '1'; 
    
    --clk_ctrl1 <= '0';
    
    end if;
end process;
    
clk_ctr: process(enable,clk_sup)
    begin
    if enable = '1' then
    
    clk_ctrl <= clk_sup;
    elsif enable = '0' then
    clk_ctrl <= '0'; 
    end if;
end process;

clk_div: process(clk,enable)
    variable counter : integer := 0;
    begin
        if enable = '1' then
            if (clk'event and clk='1') then
                if counter = num_samp/2 then
                counter := 0;
                 clk_sup <= not clk_sup;
                else
                
                counter := counter + 1;
                end if;
            end if;
        else
        clk_sup <= '0'; 
        end if;
end process;


process(clk_ctrl)
    begin
        if (rising_edge(clk_ctrl)) then --or falling_edge(clk_ctrl)) then
        
        timer <= timer + 1; 
            
            if timer = to_unsigned((samples_len-1),timer'length) then
            
            timer <= to_unsigned(0,timer'length); 
            
        
            
            end if;
            
            if timer = to_unsigned(0,timer'length) then
            sample <= sig;
            end if; 
            
            if sample = '1' then
                if sig_out = to_unsigned((samples_len - 1),sig_out'length) then
                sig_out <= to_unsigned(0,sig_out'length);
                
                else
            
                sig_out <= sig_out + 1 ;
                
                end if;
            else
            
            sig_out <= "00000000";
            
            end if;
        
        end if;
end process;

timer_out <= sig_out;
str_out <= std_logic_vector(to_unsigned(SAMP(to_integer(sig_out)), str_out'length));
end Behavioral;
