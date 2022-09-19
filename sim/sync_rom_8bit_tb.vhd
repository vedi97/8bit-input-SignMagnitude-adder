library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sync_rom_8bit_tb is
--  Port ( );
end sync_rom_8bit_tb;

architecture Behavioral of sync_rom_8bit_tb is
	constant CP : time := 10ns;

	signal clk_tb:std_logic;
	signal addr_r_tb:STD_LOGIC_VECTOR (7 downto 0);
	signal data_tb:STD_LOGIC_VECTOR (3 downto 0);

	component sync_rom_8bit is
		 Port ( clk : in STD_LOGIC;
           		addr_r : in STD_LOGIC_VECTOR (7 downto 0);
           		data : out STD_LOGIC_VECTOR (3 downto 0));
		end component sync_rom_8bit;

begin
	sync_rom_8bit_i : sync_rom_8bit
	port map(
			clk => clk_tb,
			addr_r => addr_r_tb,
			data => data_tb
			);

	process
	begin
		clk_tb <= '1';
		wait for CP/2;
		clk_tb <= '0';
		wait for CP/2;
	end process;


	process
	begin
		wait for CP;
--Testing +0 and +0 = +0
		addr_r_tb <= "00000000";
		wait for CP;
--Testing -0 and +1 = +1
		addr_r_tb <= "10000001";
		wait for CP;
--Testing -0 and -0 = +0
		addr_r_tb <= "10001000";
		wait for CP;
--Testing +4 and -0 = +4
		addr_r_tb <= "01001000";
		wait for CP;
--Testing -0 and -4 = -4
		addr_r_tb <= "10001100";
		wait for CP;
--Testing -7 and +7 = +0
		addr_r_tb <= "11111111";
		wait for CP;
--Testing -2 and +3 = +1
		addr_r_tb <= "10100011";
		wait for CP;
--Testing +3 and +7 = +0 =>OverFlow
		addr_r_tb <= "00110111";
		wait for CP;
--Testing -4 and -5 = +0 => OverFlow
		addr_r_tb <= "11001101";
		wait;
	end process;
end Behavioral;
