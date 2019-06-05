-- fsm.vhd: Finite State Machine
-- Author(s): Peter Koprda <xkoprd00@stud.fit.vutbr.cz>
-- kod1 = 3450756460
-- kod2 = 3450702584
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (
		S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,
		S1_P,S2_P,S3_P,S4_P,
		GOOD,BAD,ACCESS_GRANTED,ACCESS_DENIED,FINISH);
		
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= S1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
	
	-- kod1 = [3]450756460
	-- kod2 = [3]450702584
	when S1 =>
		if(KEY(3)='1') then
			next_state <= S2;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S1;
		end if;
		
	-- kod1 = 3[4]50756460
	-- kod2 = 3[4]50702584
	when S2 =>
		if(KEY(4)='1') then
			next_state <= S3;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S2;
		end if;
			
	-- kod1 = 34[5]0756460
	-- kod2 = 34[5]0702584
	when S3 =>
		if(KEY(5)='1') then
			next_state <= S4;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S3;
		end if;
	
	-- kod1 = 345[0]756460
	-- kod2 = 345[0]702584
	when S4 =>
		if(KEY(0)='1') then
			next_state <= S5;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S4;
		end if;
	
	-- kod1 = 3450[7]56460
	-- kod2 = 3450[7]02584
	when S5 =>
		if(KEY(7)='1') then
			next_state <= S6;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S5;
		end if;
	
	-- kod1 = 34507[5]6460
	-- kod2 = 34507[0]2584
	when S6 =>
		-- kod1
		if(KEY(5)='1') then
			next_state <= S7;
		-- kod2
		elsif(KEY(0)='1') then
			next_state <= S1_P;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S6;
		end if;
	
	-- kod1 = 345075[6]460
	when S7 =>
		if(KEY(6)='1') then
			next_state <= S8;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S7;
		end if;
	
	-- kod1 = 3450756[4]60
	when S8 =>
		if(KEY(4)='1') then
			next_state <= S9;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S8;
		end if;
	
	-- kod1 = 34507564[6]0	
	when S9 =>
		if(KEY(6)='1') then
			next_state <= S10;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S9;
		end if;
	
	-- kod1 = 345075646[0]
	when S10 =>
		if(KEY(0)='1') then
			next_state <= GOOD;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S10;
		end if;
	
	-- - - - - - - - - - - - - - - - - - - - - - - - - -
	
	-- kod2 = 345070[2]584
	when S1_P =>
		if(KEY(2)='1') then
			next_state <= S2_P;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S1_P;
		end if;
	
	-- kod2 = 3450702[5]84
	when S2_P =>
		if(KEY(5)='1') then
			next_state <= S3_P;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S2_P;
		end if;

	-- kod2 = 34507025[8]4
	when S3_P =>
		if(KEY(8)='1') then
			next_state <= S4_P;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S3_P;
		end if;
	
	-- kod2 = 345070258[4]
	when S4_P =>
		if(KEY(4)='1') then
			next_state <= GOOD;
		elsif(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= S4_P;
		end if;
	
	-- - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	-- key #
	when GOOD =>
		if(KEY(15)='1') then
			next_state <= ACCESS_GRANTED;
		elsif(KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD;
		else
			next_state <= GOOD;
		end if;
	
	-- wrong number or sign in code
	when BAD =>
		next_state <= BAD;
		if(KEY(15)='1') then
			next_state <= ACCESS_DENIED;
		end if;
	
	-- - - - - - - - - - - - - - - - - - - - - - - - - -
	
	-- kod1 = 3450756460 or kod2 = 3450702584
	when ACCESS_GRANTED =>
		next_state <= ACCESS_GRANTED;
		if(CNT_OF='1') then
			next_state <= FINISH;
		end if;
	
	-- kod1 /= 3450756460 or kod2 /= 3450702584
	when ACCESS_DENIED =>
		next_state <= ACCESS_DENIED;
		if(CNT_OF='1') then
			next_state <= FINISH;
		end if;
	
	-- - - - - - - - - - - - - - - - - - - - - - - - - -
	
   -- print message on screen
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= S1; 
      end if;
   
	-- - - - - - - - - - - - - - - - - - - - - - - - - - 
	
	-- nothing happens
   when others =>
      null;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
	
	when ACCESS_DENIED =>
		FSM_CNT_CE <= '1';
		FSM_MX_LCD <= '1';
		
		if(CNT_OF ='0') then
			FSM_LCD_WR <= '1';
		end if;
		
	when ACCESS_GRANTED =>
		FSM_CNT_CE <= '1';
		FSM_MX_MEM <= '1';
		FSM_MX_LCD <= '1';
		
		if(CNT_OF = '0')then
			FSM_LCD_WR <= '1';
		end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
		if(KEY(15)='1') then
			FSM_LCD_ClR <= '1';
		elsif(KEY(14 downto 0) /= "000000000000000") then
			FSM_LCD_WR <= '1';
		end if;
   end case;
end process output_logic;

end architecture behavioral;

