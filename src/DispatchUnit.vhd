----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/22 21:17:34
-- Design Name: 
-- Module Name: DispatchUnit - Behavioral
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

entity DispatchUnit is
  Port (
    clk : in std_logic;
    -- To IPFQ
    inst : in inst_t;
    -- To RF
    rs1_addr : out unsigned(4 downto 0);
    rs2_addr : out unsigned(4 downto 0);
    rd_addr : out unsigned(4 downto 0);
    rd_wb : out std_logic;
    rs1_data : in reg_entry_t;
    rs2_data : in reg_entry_t;
    rd_data : out reg_entry_t;
    -- To INTQ
    -- To LSQ
    -- To CSRQ
 );
end DispatchUnit;

architecture Behavioral of DispatchUnit is

begin


end Behavioral;
