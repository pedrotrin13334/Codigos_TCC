----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:36:50 03/16/2018 
-- Design Name: 
-- Module Name:    Base - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
package matrix is
    type matrix is array(0 to 3) of std_logic_vector (0 to 3);
end package matrix;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.matrix.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Base is
    Port ( D : matrix ;
           xn : in  STD_LOGIC_VECTOR(0 to 3);
           output : out  STD_LOGIC_VECTOR(0 to 3) );
end Base;

architecture Behavioral of Base is

signal aux : matrix;

begin

gen_init: for i in 0 to 3 generate

aux(i)(0) <= xn(0) and D(i)(0);

end generate gen_init;

try : for j in 0 to 3 generate
gen : for i in 1 to 3 generate
 aux(j)(i) <= (xn(i) and D(j)(i)) OR aux(j)(i-1) ;
end generate gen;
end generate try;

another : for i in 0 to 3 generate
output(i) <= aux(i)(3);
end generate another;
end Behavioral;

