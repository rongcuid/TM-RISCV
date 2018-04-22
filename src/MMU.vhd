----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/22 20:02:11
-- Design Name: 
-- Module Name: MMU - BehavioralStubSSRAM
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

entity MMU is
  Port (
    clk : in std_logic;
    -- Instruction port is read-only
    inst_addr : in unsigned(31 downto 2);
    inst_data : out std_logic_vector(31 downto 0);
    inst_en : in std_logic;

    -- Data port is byte-addressible RW
    ls_addr : in unsigned(31 downto 2);
    ls_data : out std_logic_vector(31 downto 0);
    ls_be : in std_logic_vector(3 downto 0);
    ls_we : in std_logic
 );
end MMU;

-- Artificially delayed. Don't synthesize this
architecture BehavioralStub of MMU is
  subtype mem_entry_t is std_logic_vector(31 downto 0);
  type mem_data_t is array (0 to 1023) of mem_entry_t;

  -- The main memory area
  signal mem_data : mem_data_t;
  -- The pipeline
  signal inst_addr_p : unsigned(31 downto 2);
  signal inst_en_p : std_logic;
  signal ls_addr_p : unsigned(31 downto 2);
  signal ls_be_p : std_logic_vector(3 downto 0);
  signal ls_we_p : std_logic;

begin

  process (clk)
    variable ls_word : std_logic_vector(31 downto 0);
  begin
    if (rising_edge(clk)) then
      inst_addr_p <= inst_addr;
      inst_en_p <= inst_en;
      ls_addr_p <= ls_addr;
      ls_be_p <= ls_be;
      ls_we_p <= ls_we;

      inst_data <= mem_data(inst_addr_p(11 downto 2));

      ls_word := mem_data(ls_addr_p(11 downto 2));
      case ls_be_p is
        when "1111" => ls_data <= ls_word;
        when "0011" => ls_data <= ls_word;
        when "0001" => ls_data <= ls_word;
        when "1100" => ls_data(15 downto 0) <= ls_word(31 downto 16);
        when "0010" => ls_data(7 downto 0) <= ls_word(15 downto 8);
        when "0100" => ls_data(7 downto 0) <= ls_word(23 downto 16);
        when "1000" => ls_data(7 downto 0) <= ls_word(31 downto 24);
        when others => ls_data <= (others => '-');
      end case;
    end if;
  end process;

end BehavioralStub;
