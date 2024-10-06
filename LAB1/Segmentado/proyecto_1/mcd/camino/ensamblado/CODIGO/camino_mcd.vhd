--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;		
use ieee.std_logic_1164.all;		
use ieee.numeric_std.all;
use work.param_disenyo_pkg.all;
use work.componentes_pkg.all;
--! @image html camino_1.png 

entity camino_mcd is
   port (reloj, pcero, pe_a, pe_b: std_logic;
	ini: std_logic;
	a, b: in st_dat;
	s: out st_dat;
	ig, meu: out std_logic);
end camino_mcd;

architecture estruc of camino_mcd is
	signal reg_a, reg_b: st_dat;
	signal mx_a: st_dat;
	signal mx_ent_a, mx_ent_b: st_dat;
	signal sub: st_dat;


	signal t_ig: std_logic;
	signal t_meu: std_logic;
	signal t_meu_n: std_logic;
begin
	rega: RD_N_pe port map (reloj => reloj, pcero => pcero, pe => pe_a, e => mx_ent_a, s => reg_a);
	regb: RD_N_pe port map (reloj => reloj, pcero => pcero, pe => pe_b, e => mx_ent_b, s => reg_b);

	mxa: mux2 port map (d0 => reg_b, d1 => sub, SEL => t_meu_n, s => mx_a);

	muxa_ent: mux2 port map (d0 => mx_a, d1 => a, SEL => ini, s => mx_ent_a);
	muxb_ent: mux2 port map (d0 => reg_a, d1 => b, SEL => ini, s => mx_ent_b);

	menor: menqu port map (L1 => reg_a, L2 => reg_b, meu => t_meu);

	resta: sumador port map (a => reg_a, b => reg_b, s => sub);

	ig_cero: igual_cero port map (L1 => reg_b, ig => t_ig);

	s <= reg_a;
	ig <= t_ig;
	meu <= t_meu;
	t_meu_n <= not t_meu;

end estruc;
