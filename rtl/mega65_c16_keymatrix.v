`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
// C16 / Plus4 for MEGA65
//
// convert mega65 keycodes to c16 keyboard matrix
//
// port done by Paolo Pisati <p.pisati@gmail.com> in 2026 and licensed under GPL v3
// based on c16_keymatrix.v
//
// XXX a few C16 keys are not mapped: F2, up, down, left, right and play
//////////////////////////////////////////////////////////////////////////////////
module mega65_c16_keymatrix
(
	input         clk,
  input   [6:0] scancode,
  input         pressed,
	input   [7:0] row,
	output  reg   key_play = 0,
	output  [7:0] kbus
);

reg [7:0] colsel=0;
reg key_A=0,key_B=0,key_C=0,key_D=0,key_E=0,key_F=0,key_G=0,key_H=0,key_I=0,key_J=0,key_K=0,key_L=0,key_M=0,key_N=0,key_O=0,key_P=0,key_Q=0,key_R=0,key_S=0,key_T=0,key_U=0,key_V=0,key_W=0,key_X=0,key_Y=0,key_Z=0;
reg key_1=0,key_2=0,key_3=0,key_4=0,key_5=0,key_6=0,key_7=0,key_8=0,key_9=0,key_0=0,key_del=0,key_return=0,key_help=0,key_F1=0,key_F2=0,key_F3=0,key_AT=0,key_shift=0,key_comma=0,key_dot=0;
reg key_minus=0,key_colon=0,key_star=0,key_semicolon=0,key_esc=0,key_equal=0,key_plus=0,key_slash=0,key_control=0,key_space=0,key_runstop=0;
reg key_pound=0,key_down=0,key_up=0,key_left=0,key_right=0,key_home=0,key_commodore=0;
wire [7:0] rowsel;

assign rowsel=~row;

always @(posedge clk) begin

		case(scancode)
			// base code keys
			7'h0A: key_A<=pressed;
			7'h1C: key_B<=pressed;
			7'h14: key_C<=pressed;
			7'h12: key_D<=pressed;
			7'h0E: key_E<=pressed;
			7'h15: key_F<=pressed;
			7'h1A: key_G<=pressed;
			7'h1D: key_H<=pressed;
			7'h21: key_I<=pressed;
			7'h22: key_J<=pressed;
			7'h25: key_K<=pressed;
			7'h2A: key_L<=pressed;
			7'h24: key_M<=pressed;
			7'h27: key_N<=pressed;
			7'h26: key_O<=pressed;
			7'h29: key_P<=pressed;
			7'h3E: key_Q<=pressed;
			7'h11: key_R<=pressed;
			7'h0D: key_S<=pressed;
			7'h16: key_T<=pressed;
			7'h1E: key_U<=pressed;
			7'h1F: key_V<=pressed;
			7'h09: key_W<=pressed;
			7'h17: key_X<=pressed;
			7'h19: key_Y<=pressed;
			7'h0C: key_Z<=pressed;
			7'h38: key_1<=pressed;
			7'h3B: key_2<=pressed;
			7'h08: key_3<=pressed;
			7'h0B: key_4<=pressed;
			7'h10: key_5<=pressed;
			7'h13: key_6<=pressed;
			7'h18: key_7<=pressed;
			7'h1B: key_8<=pressed;
			7'h20: key_9<=pressed;
			7'h23: key_0<=pressed;
			7'h00: key_del<=pressed;
			7'h01: key_return<=pressed;
			7'h43: key_help<=pressed;
			7'h04: key_F1<=pressed;
			//9'h006: key_F2<=pressed;
			7'h05: key_F3<=pressed;
			7'h2E: key_AT<=pressed;
			7'h0F: key_shift<=pressed; // left shift
			7'h34: key_shift<=pressed; // right shift
			7'h2F: key_comma<=pressed;
			7'h2C: key_dot<=pressed;
			7'h2B: key_minus<=pressed;
			7'h2D: key_colon<=pressed;
			7'h31: key_star<=pressed;
			7'h32: key_semicolon<=pressed;
			7'h47: key_esc<=pressed;
			7'h35: key_equal<=pressed;
			7'h28: key_plus<=pressed;
			7'h37: key_slash<=pressed;
			7'h3A: key_control<=pressed;
			7'h3C: key_space<=pressed;
			7'h3F: key_runstop<=pressed;
			7'h3D: key_commodore<=pressed;

			// extended code keys
			7'h30: key_pound<=pressed;
			//9'h172: key_down<=pressed;
			//9'h175: key_up<=pressed;
			//9'h16B: key_left<=pressed;
			//9'h174: key_right<=pressed;
			7'h33: key_home<=pressed;
			7'h3A: key_control<=pressed;
			7'h3D: key_commodore<=pressed;
			7'h37: key_slash<=pressed;
			7'h01: key_return<=pressed;
			7'h00: key_del<=pressed;
			//9'h17D: key_play<=pressed;
		endcase

end

always @(posedge clk) begin
	colsel[0]<=(key_del & rowsel[0]) | (key_3 & rowsel[1]) | (key_5 & rowsel[2]) | (key_7 & rowsel[3]) | (key_9 & rowsel[4]) | (key_down & rowsel[5]) | (key_left & rowsel[6]) | (key_1 & rowsel[7]);
	colsel[1]<=(key_return & rowsel[0]) | (key_W & rowsel[1]) | (key_R & rowsel[2]) | (key_Y & rowsel[3]) | (key_I & rowsel[4]) | (key_P & rowsel[5]) | (key_star & rowsel[6]) | (key_home & rowsel[7]);
	colsel[2]<=(key_pound & rowsel[0]) | (key_A & rowsel[1]) | (key_D & rowsel[2]) | (key_G & rowsel[3]) | (key_J & rowsel[4]) | (key_L & rowsel[5]) | (key_semicolon & rowsel[6]) | (key_control & rowsel[7]);
	colsel[3]<=(key_help & rowsel[0]) | (key_4 & rowsel[1]) | (key_6 & rowsel[2]) | (key_8 & rowsel[3]) | (key_0 & rowsel[4]) | (key_up & rowsel[5]) | (key_right & rowsel[6]) | (key_2 & rowsel[7]);
	colsel[4]<=(key_F1 & rowsel[0]) | (key_Z & rowsel[1]) | (key_C & rowsel[2]) | (key_B & rowsel[3]) | (key_M & rowsel[4]) | (key_dot & rowsel[5]) | (key_esc & rowsel[6]) | (key_space & rowsel[7]);
	colsel[5]<=(key_F2 & rowsel[0]) | (key_S & rowsel[1]) | (key_F & rowsel[2]) | (key_H & rowsel[3]) | (key_K & rowsel[4]) | (key_colon & rowsel[5]) | (key_equal & rowsel[6]) | (key_commodore & rowsel[7]);
	colsel[6]<=(key_F3 & rowsel[0]) | (key_E & rowsel[1]) | (key_T & rowsel[2]) | (key_U & rowsel[3]) | (key_O & rowsel[4]) | (key_minus & rowsel[5]) | (key_plus & rowsel[6]) | (key_Q & rowsel[7]);
	colsel[7]<=(key_AT & rowsel[0]) | (key_shift & rowsel[1]) | (key_X & rowsel[2]) | (key_V & rowsel[3]) | (key_N & rowsel[4]) | (key_comma & rowsel[5]) | (key_slash & rowsel[6]) | (key_runstop & rowsel[7]);
end

assign kbus=~colsel;

endmodule
