//Design of Digital Systems Mini Project
//S1 Team 18 - Small Scale DES Algorithm Hardware Implementation
/* Team Members:
	221CS112, Arjun Ravisankar
	221CS140, Prayag Ganesh Prabhu
	221CS154, Singaraju B V Sreedakshinya */

//DES Testbench

module DES_tb;
	wire [0:7] D; //Decrypted text
	wire [0:7] C; //Ciphertext
	reg [0:7] P; //Plaintext
	reg [0:9] K; //Key
	crypt E1(P, K, 1'b0, C); //encryption
	crypt D1(C, K, 1'b1, D); //decryption

	initial 
	begin
		$dumpfile("DES.vcd");
		$dumpvars(0, DES_tb);
	end 
		
	initial 
	begin
		$display("|                          DES                         |");
		$display("--------------------------------------------------------");
		$display("| Plaintext |   Key    |  Ciphertext  |    Decrypted   |");
		$display("----------------------------------------------------------");
		$monitor("| %b%b%b%b%b%b%b%b  |%b%b%b%b%b%b%b%b%b%b|   %b%b%b%b%b%b%b%b   |    %b%b%b%b%b%b%b%b    |", P[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7], K[0], K[1], K[2], K[3], K[4], K[5], K[6], K[7], K[8], K[9], C[0], C[1], C[2], C[3], C[4], C[5], C[6], C[7], D[0], D[1], D[2], D[3], D[4], D[5], D[6], D[7]);
		//Plain text
		P = 8'b11100111;
		
		//Key
		K = 10'b1010000010;
			
	end
endmodule