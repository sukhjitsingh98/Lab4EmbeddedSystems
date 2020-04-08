library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
  Port ( 
     clk: in std_logic;
     vga_hs, vga_vs: out std_logic;
     vga_r, vga_b: out std_logic_vector(4 downto 0);
     vga_g: out std_logic_vector(5 downto 0)
  );
end image_top;

----------------------clk div------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity clock_div is
  Port (
    clk: in std_logic;
    div: out std_logic
  );
end clock_div;

architecture Behavioral of clock_div is
    signal counter : std_logic_vector(26 downto 0) := (others => '0');
begin
process (clk)
    begin  
        --Need gap of 4 clock pulses   
        if rising_edge(clk) then
            if(unsigned(counter)<4) then --check this
                counter<=std_logic_vector(unsigned(counter)+1);
            else
                counter<=(others => '0');
            end if;
            
            if(unsigned(counter)<1) then --do some math
               div<='1';
            else
                div<='0';
            end if;
        end if;
    end process;

end Behavioral;
------------------------------end clk div--------------
architecture Behavioral of image_top is
component clock_div
  Port (
    clk: in std_logic;
    div: out std_logic
  );
end component;
component picture
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;
component pixel_pusher
  Port (
    clk,en, vid, VS : in std_logic;
    pixel: in std_logic_vector(7 downto 0);
    hcount: in std_logic_vector(9 downto 0);
    R, B: out std_logic_vector(4 downto 0);
    G: out std_logic_vector(5 downto 0);
    addr: out std_logic_vector(17 downto 0)   
  );
end component;
component vga_ctrl
  Port ( 
    clk, clk_en : in std_logic;
    vcount, hcount: out std_logic_vector(9 downto 0);
    vid, hs, vs : out std_logic := '1'
  );
end component;
    signal addrSig: std_logic_vector(17 downto 0);
    signal divOut: std_logic;
    signal doutaSig: std_logic_vector(7 downto 0);
    signal vsSig,vidSig: std_logic;
    --vcountSig goes nowhere but needed a signal for it
    signal vcountSig,hcountSig: std_logic_vector(9 downto 0);
    
begin
    vga_vs <= vsSig;
    
    clk_div: clock_div
    port map(
        clk => clk,
        div => divOut
    );
    
    pic: picture
    port map(
       clka => divOut,
       addra => addrSig,
       douta => doutaSig
    );
    
    pixPush: pixel_pusher
    port map(
        clk => clk,
        en => divOut,
        vs => vsSig,
        vid => vidSig,
        pixel => doutaSig,
        hcount => hcountSig,
        addr => addrSig,
        R => vga_r,
        B => vga_b,
        G => vga_g
    );

    vgaCtr: vga_ctrl
    port map(
        clk_en =>divOut,
        clk=>clk,
        hcount => hcountSig,
        vcount=>vcountSig,
        vid => vidSig,
        hs => vga_hs,
        vs => vsSig
    );
    
end Behavioral;
