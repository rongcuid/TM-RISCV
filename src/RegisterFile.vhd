----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/22 20:08:13
-- Design Name: 
-- Module Name: RegisterFile - Behavioral
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
entity RegisterFile is
  Port (
    clk : in std_logic;
    -- Addr 
    rs1_addr : in unsigned(4 downto 0);
    rs2_addr : in unsigned(4 downto 0);
    rd_addr : in unsigned(4 downto 0);
    -- Data
    rs1_data : out std_logic_vector(31 downto 0);
    rs2_data : out std_logic_vector(31 downto 0);
    rd_data : in std_logic_vector(31 downto 0);
    -- Control
    rd_wb : in std_logic
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
  -- 
  type registerfile_t is array (1 to 31) of reg_entry_t;
  -- 
  signal reg_data : registerfile_t;

begin

  regWrite: process (clk)
  begin
    if (rising_edge(clk)) then
      -- 
      if (rd_wb) then
        reg_data(rd_addr) <= rd_data;
      end if;
    end if;
  end process;

  -- Forwarding
  regRead: process
  begin
    rs1_data <= reg_data(rs1_addr);
    rs2_data <= reg_data(rs2_addr);
    if (rd_wb) then
      if (rd_addr = rs1_addr) then
        rs1_data <= reg_data(rd_addr);
      end if;
      if (rd_addr = rs2_addr) then
        rs2_data <= reg_data(rd_addr);
      end if;
    end if;
  end process;

end Behavioral;
