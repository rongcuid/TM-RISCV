----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/22 20:08:13
-- Design Name: 
-- Module Name: ExecInt - Behavioral
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

use work.Common.all;

entity ExecInt is
  Port (
    op1 : std_logic_vector(31 downto 0);
    op2 : std_logic_vector(31 downto 0);
    op : op_t;
    result : std_logic_vector(31 downto 0)
    );
end ExecInt;

architecture Behavioral of ExecInt is

begin

  process
    variable op1_conv, op2_conv : unsigned(31 downto 0);
  begin
    op1_conv := to_unsigned(op1);
    op2_conv := to_unsigned(op2);
    case op is
      when op_add => result <= op1_conv + op2_conv;
      when op_sub => result <= op1_conv - op2_conv;
      when op_sll => result <= op1_conv sll op2_conv;
      when op_slt => if (signed(op1_conv) < signed(op2_conv)) then
                       result <= 16#1#;
                     else
                       result <= 16#0#;
                     end if;
      when op_sltu => if (op1_conv < op2_conv) then
                        result <= 16#1#;
                      else
                        result <= 16#0#;
                      end if;
      when op_xor => result <= op1_conv xor op2_conv;
      when op_srl => result <= op1 srl op2;
      when op_sra => result <= op1 sra op2;
      when op_or => result <= op1 or op2;
      when op_and => result <= op1 and op2;
    end case;
  end process;
  

end Behavioral;
