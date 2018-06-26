--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:50:35 03/26/2018
-- Design Name:   
-- Module Name:   C:/Users/PedroHenrique/Documents/Projeto_TCC/TCC/Teste.vhd
-- Project Name:  TCC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Base
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package matrix is
    type matrix is array(0 to 3) of std_logic_vector (0 to 3);
end package matrix;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use work.matrix.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Teste IS
END Teste;
 
ARCHITECTURE behavior OF Teste IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Base
    PORT(
         D : IN  matrix;
         xn : IN  std_logic_vector(0 to 3);
         output : OUT  std_logic_vector(0 to 3)
        );
    END COMPONENT;
    

   --Inputs
   signal D : matrix;
   signal xn : std_logic_vector(0 to 3) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(0 to 3);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Base PORT MAP (
          D => D,
          xn => xn,
          output => output
        );
D <= ("1010", "1111", "0001", "0111");
xn <= "1111";
END;
