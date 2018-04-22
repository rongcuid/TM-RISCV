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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
  Port (
    -- 输入，地址 
    rs1_addr : in unsigned(4 downto 0);
    rs2_addr : in unsigned(4 downto 0);
    rd_addr : in unsigned(4 downto 0);
    -- 数据。
    rs1_data : out std_logic_vector(31 downto 0);
    rs2_data : out std_logic_vector(31 downto 0);
    rd_data : in std_logic_vector(31 downto 0);
    -- 控制
    rd_wb : in std_logic
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
  -- 寄存器的宽度是32位
  type reg_entry is std_logic_vector(31 downto 0);
  -- RV32架构一共有32个寄存器,x0-x31。其中x0读写忽略
  signal reg_data : array (1 to 31) of reg_entry;

begin

  regWrite: process (clk)
  begin
    if (rising_edge(clk)) then
      -- 每一时钟周期，若rd_wb（rd端写入writeback）则写入
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
