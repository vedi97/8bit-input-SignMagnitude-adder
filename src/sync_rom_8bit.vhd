library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use std.textio.all;
use ieee.std_logic_textio.all;

entity sync_rom_8bit is
    Generic(
        ADDR_WIDTH : integer:=8;
        DATA_WIDTH : integer:=4
    );
    Port ( clk : in STD_LOGIC;
           addr_r : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           data : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end sync_rom_8bit;

architecture Behavioral of sync_rom_8bit is

constant ROM_DEPTH : integer := 2**ADDR_WIDTH-1;

type rom_type is array (0 to 2**ADDR_WIDTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);

impure function init_rom return rom_type is
    file text_file_8_bit : text open READ_MODE is "../data/rom_8_sign_mag.txt";
    file text_file_16_bit : text open READ_MODE is "../data/rom_16_sign_mag.txt";
    variable text_line : line;
    variable rom_content : rom_type ;
    variable value: std_logic_vector(DATA_WIDTH-1 downto 0);
begin
    for i in 0 to ROM_DEPTH -1 loop
        if ADDR_WIDTH = 8 then
            readline(text_file_8_bit, text_line);
        else
            readline(text_file_16_bit, text_line);
        end if;
        read(text_line, value);
        rom_content(i) := value;
    end loop;
    return rom_content;
    
    end function;

signal rom: rom_type := init_rom;


begin

  process(clk)
  begin
    if (clk'event and clk = '1') then
       data <= rom(to_integer(unsigned(addr_r)));
    end if;
  end process;
end Behavioral;
