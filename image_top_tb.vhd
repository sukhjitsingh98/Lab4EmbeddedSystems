library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is
component image_top is
Port ( 
    clk: in std_logic;
    vga_hs, vga_vs: out std_logic;
    vga_r, vga_b: out std_logic_vector(4 downto 0);
    vga_g: out std_logic_vector(5 downto 0)
  );
end component;
signal clock : std_logic;
signal vgaHSsig, vgaVSsig : std_logic;
signal vgaRsig, vgaBsig: std_logic_vector(4 downto 0);
signal vgaGsig : std_logic_vector(5 downto 0);


begin


image : image_top port map( 
  clk => clock,
  vga_r => vgaRsig,
  vga_b => vgaBsig,
  vga_g => vgaGsig,
  vga_hs => vgaHSsig,
  vga_vs => vgaVSsig
  );


process 
begin
clock <= '1';
wait for 4ns;
clock <= '0';
wait for 4ns;
end process;


end Behavioral;
