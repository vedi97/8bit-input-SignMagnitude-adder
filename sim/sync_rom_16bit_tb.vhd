library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sync_rom_16bit_tb is
--  Port ( );
end sync_rom_16bit_tb;

architecture Behavioral of sync_rom_16bit_tb is
	constant CP : time := 10ns;

	signal clk_tb:std_logic;
	signal addr_r_tb:STD_LOGIC_VECTOR (15 downto 0);
	signal data_tb:STD_LOGIC_VECTOR (7 downto 0);

	component sync_rom_16bit is
		 Port ( clk : in STD_LOGIC;
           		addr_r : in STD_LOGIC_VECTOR (15 downto 0);
           		data : out STD_LOGIC_VECTOR (7 downto 0));
		end component sync_rom_16bit;

begin
	sync_rom_16bit_i : sync_rom_16bit
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
		addr_r_tb <= "0000000000000000";
		wait for CP;
--Testing +0 and -0 = +0
		addr_r_tb <= "0000000010000000";
		wait for CP;
--Testing -0 and +1 = +1
		addr_r_tb <= "1000000000000001";
		wait for CP;
--Testing -0 and -0 = +0
		addr_r_tb <= "0000000000000000";
		wait for CP;
--Testing +12 and -0 = +12
		addr_r_tb <= "0000110010000000";
		wait for CP;
--Testing -0 and -4 = -4
		addr_r_tb <= "1000000010000100";
		wait for CP;

		addr_r_tb <= "1000111000001110";
		wait for CP;

		addr_r_tb <= "1011010001111011";
		wait for CP;

		addr_r_tb <= "0011111100111111";
		wait for CP;

		addr_r_tb <= "1000111110100111";
		wait;
	end process;
end Behavioral;
