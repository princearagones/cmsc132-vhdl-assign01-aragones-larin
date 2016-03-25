-- Author: 	Prince Aragones
--			Magi Larin
-- Date:	March 25, 2016 
-- Program Description: Mr. Fox's alarm system in Boggis, Bunce, and Bean farm storages using IN and OUT buzzers

--Library statements
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity t1l_aragones_larin is
	port(alarm:out std_logic;
	i: in std_logic_vector(5 downto 0)); -- this stands for the gates
	-- i(0), i(1), and i(2) are Boggis in, Bunce in, Bean in Buzzer respectively
	-- i(3), i(4), and i(5) are Boggis out, Bunce out, Bean out Buzzer respectively
end entity t1l_aragones_larin;

--Architecture Defintion
architecture makeAlarm of t1l_aragones_larin is
begin
	process (i(5),i(4),i(3), i(2), i(1), i(0)) is
	begin
		-- if at least 1 of the IN buzzer is on, and at least 1 of the OUT buzzer is on
		if(((i(0)='1') or (i(1)='1') or (i(2)='1')) and
			((i(3)='1') or (i(4)='1') or (i(5)='1')))
			then alarm <= '1';
		else
			alarm <= '0';
		end if;
	end process;
end architecture makeAlarm;
