-- Author: 	Prince Aragones
--			Magi Larin
-- Date:	March 25, 2016 
--Description: Test Bench

--Library statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Entity Definition
entity t1l_aragones_larin_tb is
	-- constants are defined here
	constant MAX_COMB: integer := 64;	-- number of input combinations 
	constant DELAY: time := 10 ns;		-- delay value in testing
end entity t1l_aragones_larin_tb;

--Architecture Defintion
architecture tb of t1l_aragones_larin_tb is
	--Signal declarations
	signal alarm: std_logic;	-- alarm data indicator from the UUT
	signal i: std_logic_vector(5 downto 0); 	-- inputs to UUT
	
	component t1l_aragones_larin is
		port(alarm:out std_logic;
		i: in std_logic_vector(5 downto 0)); -- this stands for the gates
		-- i(0) and i(1) are Boggis in and out buzzer respectively
		-- i(2) and i(3) are Bunce in and out buzzer respectively
		-- i(4) and i(5) are Bean in and out buzzer respectively
	end component t1l_aragones_larin;
	
begin
	-- instantiate the unit under test
	UUT: component t1l_aragones_larin port map(alarm, i);
	-- main process: generate test vectors and check results
	main: process is
		variable temp: unsigned(5 downto 0);
		variable expected_alarm: std_logic;	
		variable error_count: integer := 0;	--number of simulation errors
		
	begin
		report "Start simulation.";
		
		--generate all possible input values
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			i(5) <= std_logic(temp(5));
			i(4) <= std_logic(temp(4));
			i(3) <= std_logic(temp(3));
			i(2) <= std_logic(temp(2));
			i(1) <= std_logic(temp(1));
			i(0) <= std_logic(temp(0));
			
			--compute expected values
			if(count<9 or count=16 or count=24 or count=32 or 
				count=40 or count=48 or count=56) 
				then expected_alarm := '0';
			else
				expected_alarm := '1';
			end if;
			
			wait for DELAY;	--wait, and then compare with UUT outputs
			
			-- check if output is the same as the expected value
			assert ((expected_alarm = alarm))
				report "ERROR: Expected valid " &
					std_logic'image(expected_alarm) & " but found " &
					std_logic'image(alarm) &
					" at time " & time'image(now);
				
			-- increment number of errors	
			if(expected_alarm /= alarm) then
				error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		
		-- report errors
		assert (error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
		
		-- there are no errors			
		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait;	-- This will finish the simulation
	end process;
end architecture tb;
				 
			
