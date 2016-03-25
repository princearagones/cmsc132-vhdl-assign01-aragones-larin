library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t1l_aragones_larin_tb is
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns;
end entity t1l_aragones_larin_tb;

architecture tb of t1l_aragones_larin_tb is
	signal alarm: std_logic;
	signal i: std_logic_vector(5 downto 0); 
	
	component t1l_aragones_larin is
		port(alarm:out std_logic;
		i: in std_logic_vector(5 downto 0)); -- this stands for the gates
		-- i(0) and i(1) are Boggis in and out buzzer respectively
		-- i(2) and i(3) are Bunce in and out buzzer respectively
		-- i(4) and i(5) are Bean in and out buzzer respectively
	end component t1l_aragones_larin;
	
begin
	UUT: component t1l_aragones_larin port map(alarm, i);
	main: process is
		variable temp: unsigned(5 downto 0);
		variable expected_alarm: std_logic;
		variable error_count: integer := 0;
		
	begin
		report "Start simulation.";
		
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			i(5) <= std_logic(temp(5));
			i(4) <= std_logic(temp(4));
			i(3) <= std_logic(temp(3));
			i(2) <= std_logic(temp(2));
			i(1) <= std_logic(temp(1));
			i(0) <= std_logic(temp(0));
			
			
			if(count<9 or count=16 or count=24 or count=32 or 
				count=40 or count=48 or count=56) 
				then expected_alarm := '0';
			else
				expected_alarm := '1';
			end if;
			
			wait for DELAY;
			
			assert ((expected_alarm = alarm))
				report "ERROR: Expected valid " &
					std_logic'image(expected_alarm) & " but found " &
					std_logic'image(alarm) &
					" at time " & time'image(now);
					
			if(expected_alarm /= alarm) then
				error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		
		assert (error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait;
	end process;
end architecture tb;
				 
			
