----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 09:02:58 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - Behavioral
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

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is

component vga_ctrl is 
port ( clk,clk_en : in std_logic;
       hcount, vcount : out std_logic_vector(9 downto 0);
       vid, hs, vs : out std_logic
       );
end component;

signal enable : std_logic := '1';

signal clock : std_logic;
signal hcountSig, vcountSig : std_logic_vector(9 downto 0);
signal vidSig, hsSig, vsSig : std_logic;

begin

vga_control : vga_ctrl port map(
    clk => clock,
    clk_en => enable,
    hcount => hcountSig,
    vcount => vcountSig,
    vid  => vidSig,
    hs => hsSig,
    vs => vsSig
    );
    
process 
begin
clock <= '1';
wait for 4ns;
clock <= '0';
wait for 4ns;
end process;
end Behavioral;
