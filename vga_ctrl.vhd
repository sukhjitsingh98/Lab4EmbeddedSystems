library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
  Port ( 
    clk, clk_en : in std_logic;
    vcount, hcount: out std_logic_vector(9 downto 0);
    vid, hs, vs : out std_logic := '1'
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

--timing generator signals
signal horizCounter: std_logic_vector(9 downto 0) := (others=>'0'); --799 is 1100011111 which is 10 digits
signal vertiCounter: std_logic_vector(9 downto 0) := (others=>'0'); --524 is 1000001100 which is 10 digits
signal vidSig: std_logic :='1';
signal hsSig,vsSig: std_logic := '1';

begin
hcount <= horizCounter;
vcount <= vertiCounter;
vid<=vidSig;hs<=hsSig;vs<=vsSig;
--timing generator
process(clk)
begin
    if(rising_edge(clk) and clk_en='1')then
    
        --Horizontal
        if(unsigned(horizCounter) <799) then
            --Increment the counter
            horizCounter <= std_logic_vector(unsigned(horizCounter)+1);
        else
            horizCounter <= (others =>'0'); --Reset
        end if;--new
        
        --Vertical
        if(unsigned(horizCounter) = 799) then
            if(unsigned(vertiCounter) <= 524) then
                --Clock tick & enable = 1 & horizontal counter reset to 0
                vertiCounter <= std_logic_vector(unsigned(vertiCounter)+1);
            else
                vertiCounter <= (others => '0'); --Reset
            end if;
        end if; 
    

        if(unsigned(horizCounter)<640 and unsigned(vertiCounter)<479)then
            vidSig<= '1';
        else
            vidSig <= '0';
        end if;
        if((unsigned(horizCounter)>=656) and (unsigned(horizCounter)<752))then
            hsSig <= '0';
        else
            hsSig <= '1';
        end if;
        if((unsigned(vertiCounter)>=490) and (unsigned(vertiCounter)<492)) then
            vsSig <= '0';
        else
            vsSig <= '1';
        end if;

end if;
end process;
end Behavioral;
