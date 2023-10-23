//Design of Digital Systems Mini Project
//S1 Team 18 - Small Scale DES Algorithm Hardware Implementation
/* Team Members:
	221CS112, Arjun Ravisankar
	221CS140, Prayag Ganesh Prabhu
	221CS154, Singaraju B V Sreedakshinya */

//DES Functions

module initial_permutation(I, O); //Initial Permutation
	input [0:7] I; //Input text (Plaintext to be encrypted / Ciphertext to be decrypted)
	output [0:7] O; //Initial permuted text
	
	assign O[0] = I[1];
	assign O[1] = I[5];
	assign O[2] = I[2];
	assign O[3] = I[0];
	assign O[4] = I[3];
	assign O[5] = I[7];
	assign O[6] = I[4];
	assign O[7] = I[6];
endmodule

module inverse_initial_permutation(I, O); //Reversal of the initial permutation (which was performed on the Plaintext to be encrypted / Ciphertext to be decrypted)
	input [0:7] I; //Outputs of 2nd L-R XOR and right half output of Swap function 
	output [0:7] O; //Encrypted Plaintext or Decrypted Ciphertext
	
	assign O[0] = I[3];
	assign O[1] = I[0];
	assign O[2] = I[2];
	assign O[3] = I[4];
	assign O[4] = I[6];
	assign O[5] = I[1];
	assign O[6] = I[7];
	assign O[7] = I[5];
endmodule

module transposition_P_box(I, O); //Transposition (permutation) of 4-bit data
	input [0:3] I; //4-bit intermediate input
	output [0:3] O; //4-bit output
	
	assign O[0] = I[1];
	assign O[1] = I[3];
	assign O[2] = I[2];
	assign O[3] = I[0];
endmodule

module four_bit_swap(I1, I2, O1, O2); //Module for swapping the left and right halves
	input [0:3] I1; //Input left half
	input [0:3] I2; //Input right half
	output [0:3] O1; //Output left half
	output [0:3] O2; //Output right half
	
	assign O1 = I2;
	assign O2 = I1;
endmodule

module four_bit_xor(I1, I2, O); //XOR operation of left half of result of Initial Permutation and result of P-box 
	input [0:3] I1; //Left half of result of Initial Permutation of 8-bit text of that round
	input [0:3] I2; //Right half of result of Initial Permutation of 8-bit text of that round
	output[0:3] O; //4-bit output

	assign O[0] = I1[0]^I2[0];
	assign O[1] = I1[1]^I2[1];
	assign O[2] = I1[2]^I2[2];
	assign O[3] = I1[3]^I2[3];
endmodule

//Key Manipulation Functions

module permutation_P10(I, O); //Initial Permutation of the 10-bit key entered
	input [0:9] I; //Given 10-bit key
	output [0:9] O; //10-bit result of key-permutation

	assign O[0] = I[2];
	assign O[1] = I[4];
	assign O[2] = I[1];
	assign O[3] = I[6];
	assign O[4] = I[3];
	assign O[5] = I[9];
	assign O[6] = I[0];
	assign O[7] = I[8];
	assign O[8] = I[7];
	assign O[9] = I[5];
endmodule

module permutation_P8(I, O); //Selecting 8 bits from 10-bit data and permuting the bits
	input [0:9] I; //10-bit intermediate data
	output [0:7] O; //8-bit intermediate output 
	
	assign O[0] = I[5];
	assign O[1] = I[2];
	assign O[2] = I[6];
	assign O[3] = I[3];
	assign O[4] = I[7];
	assign O[5] = I[4];
	assign O[6] = I[9];
	assign O[7] = I[8];
endmodule

module divide10(I, O1, O2); //Dividing 10 bit data into 2 halves
	input[0:9] I; //10-bit intermediate input
	output [0:4] O1; //5-bit left half
	output [0:4] O2; //5-bit right half
	
	assign O1[0] = I[0];
	assign O1[1] = I[1];
	assign O1[2] = I[2];
	assign O1[3] = I[3];
	assign O1[4] = I[4];
	assign O2[0] = I[5];
	assign O2[1] = I[6];
	assign O2[2] = I[7];
	assign O2[3] = I[8];
	assign O2[4] = I[9];
endmodule
	
module combine10(I1, I2, O); //Module for combining 2 5-bit intermediate inputs into 10-bit text 
	input[0:4] I1; //5-bit left intermediate input
	input [0:4] I2; //5-bit intermediate right input
	output [0:9] O; //10-bit intermediate output text
	
	assign O[0] = I1[0];
	assign O[1] = I1[1];
	assign O[2] = I1[2];
	assign O[3] = I1[3];
	assign O[4] = I1[4];
	assign O[5] = I2[0];
	assign O[6] = I2[1];
	assign O[7] = I2[2];
	assign O[8] = I2[3];
	assign O[9] = I2[4];
endmodule

module divide8(I, O1, O2); //Module for splitting 8 bit data into 2 halves of 4 bits each
	input[0:7] I; //8 bit input which is to be divided into left half and right half
	output [0:3] O1; //4 bit left half
	output [0:3] O2; // 4 bit right half
	
	assign O1[0] = I[0];
	assign O1[1] = I[1];
	assign O1[2] = I[2];
	assign O1[3] = I[3];
	assign O2[0] = I[4];
	assign O2[1] = I[5];
	assign O2[2] = I[6];
	assign O2[3] = I[7];
endmodule
	
module combine8(I1, I2, O);
	input[0:3] I1;
	input [0:3] I2;
	output [0:7] O;
	
	assign O[0] = I1[0];
	assign O[1] = I1[1];
	assign O[2] = I1[2];
	assign O[3] = I1[3];
	assign O[4] = I2[0];
	assign O[5] = I2[1];
	assign O[6] = I2[2];
	assign O[7] = I2[3];
endmodule

module combine4(I1, I2, O); //Combining two 2-bit intermediate inputs into 4-bit data
	input[0:1] I1; //2-bit left half
	input [0:1] I2; //2-bit right half
	output [0:3] O; //4-bit output
	
	assign O[0] = I1[0];
	assign O[1] = I1[1];
	assign O[2] = I2[0];
	assign O[3] = I2[1];
endmodule

module left_shift_1(I1, I2, O1, O2); //Module for 1-bit circular shift of each half
	input[0:4] I1; //4-bit input 1 (left half of previous step) 
	input [0:4] I2; //4-bit input 2 (right half of previous step)
	output [0:4] O1; //4-bit output 1 (left half)
	output [0:4] O2; //4-bit output 2 (right half)
	
	assign O1[0] = I1[1]; 
	assign O1[1] = I1[2];
	assign O1[2] = I1[3];
	assign O1[3] = I1[4];
	assign O1[4] = I1[0];
	assign O2[0] = I2[1];
	assign O2[1] = I2[2];
	assign O2[2] = I2[3];
	assign O2[3] = I2[4];
	assign O2[4] = I2[0];
endmodule
	
module left_shift_2(I1, I2, O1, O2); //Module for 2-bit circular shift of each half
	input[0:4] I1; //4-bit input 1 (left half of previous step)
	input [0:4] I2; //4-bit input 2 (right half of previous step)
	output [0:4] O1; //4-bit output 1 (left half)
	output [0:4] O2; //4-bit output 2 (right half)
	
	assign O1[0] = I1[2];
	assign O1[1] = I1[3];
	assign O1[2] = I1[4];
	assign O1[3] = I1[0];
	assign O1[4] = I1[1];
	assign O2[0] = I2[2];
	assign O2[1] = I2[3];
	assign O2[2] = I2[4];
	assign O2[3] = I2[0];
	assign O2[4] = I2[1];
endmodule

module expansion(ip,e); //Module for expanding 4-bit data into 8-bit output by repeating the bits and permuting them
	input [4:7]ip; //4-bit intermediate data
	output [0:7]e; //8-bit expanded data

	assign e[0]=ip[7];
	assign e[1]=ip[4];
	assign e[2]=ip[5];
	assign e[3]=ip[6];
	assign e[4]=ip[5];
	assign e[5]=ip[6];
	assign e[6]=ip[7];
	assign e[7]=ip[4];
endmodule

module eight_bit_xor(e,key,ex); //XOR operation of 8-bit intermediate text with 8-bit key (generated by key circuit)
	input [0:7]e; //8-bit text
	input [0:7]key; //8-bit key
	output [0:7]ex; //8-bit output

	xor (ex[0],e[0],key[0]);
	xor (ex[1],e[1],key[1]);
	xor (ex[2],e[2],key[2]);
	xor (ex[3],e[3],key[3]);
	xor (ex[4],e[4],key[4]);
	xor (ex[5],e[5],key[5]);
	xor (ex[6],e[6],key[6]);
	xor (ex[7],e[7],key[7]);
endmodule

module S_box_1(ex,s1); //Substitution box 1 for left half of output of data-key-xor-operation
	input [0:3]ex; //4-bit left half input
	output [0:1]s1; //2-bit output 
	wire w1,w2; //temporary variables for the k-map implementation
	
	xor(w1,ex[2],ex[3]);
	xor(w2,ex[1],ex[3]);
	assign s1[0]= ( !ex[0] && !ex[1] && ex[3]) || ( !ex[0] && ex[1] && !ex[2] && !ex[3] ) || ( ex[0] && w1 ) || ( ex[1] && ex[2] && !ex[3] ) || ( ex[0] && ex[1]  && ( ex[2] || ex[3]));
	assign s1[1]= ( !ex[2] && (ex[3] || !ex[0] || ex[1] )) || (ex[0] && w2 );
endmodule

module S_box_2(ex,s2); //Substitution box 2 for right half of output of data-key-xor-operation
	input [0:3]ex; //4-bit right half input
	output [0:1]s2; //2-bit output 
	wire w3,w4; //temporary variables for the k-map implementation

	xnor (w3,ex[1],ex[2]);
	xnor (w4,ex[2],ex[3]);
	assign s2[0]= (ex[0] && !ex[1] && !ex[2]) || (!ex[0] && ex[1] && ex[2]) || ( ex[3] && w3 ) || ( !ex[0] && ex[1] && !ex[3]);
	assign s2[1]= ( !ex[0] && ex[2] && !ex[3] ) || ( !ex[0] && ex[1] && ex[3] ) || ( ex[0] && w4 );
endmodule

module key_generator(key, key1, key2);
	input [0:9] key;
	wire [0:9] initial_key_permute;
	wire [0:4] key_left;
	wire [0:4] key_right;
	wire [0:4] shifted_left;
	wire [0:4] shifted_right;
	wire [0:9] shifted_key1;
	output [0:7] key1;
	wire [0:4] shifted2_left;
	wire [0:4] shifted2_right;
	wire [0:9] shifted_key2;
	output [0:7] key2;

	//Generating keys 1 and 2
	permutation_P10 Pten(key, initial_key_permute);
	divide10 D10(initial_key_permute, key_left, key_right);
	left_shift_1 LS1(key_left, key_right, shifted_left, shifted_right);
	combine10 C10(shifted_left, shifted_right, shifted_key1);
	permutation_P8 PP8(shifted_key1, key1);
	left_shift_2 LS2(shifted_left, shifted_right, shifted2_left, shifted2_right);
	combine10 C10_(shifted2_left, shifted2_right, shifted_key2);
	permutation_P8 PP8_(shifted_key2, key2);
endmodule	

module round(left_half, right_half, key, new_left_half, new_right_half);
	wire [0:7] initial_permute;
	input [0:3] left_half;
	input [0:3] right_half;
	wire [0:7] expanded_permute;
	input [0:7] key;
	wire [0:7] after_xor;
	wire [0:3] left_xor;
	wire [0:3] right_xor;
	wire [0:1] comp1xor;
	wire [0:1] comp2xor;
	wire [0:3] compxor;
	wire [0:3] transxor;
	output [0:3] new_right_half;
	output [0:3] new_left_half;
	
	//Round
	expansion EP(right_half, expanded_permute);
	eight_bit_xor EBX(expanded_permute, key, after_xor);
	divide8 D8_(after_xor, left_xor, right_xor);
	S_box_1 S1(left_xor, comp1xor);
	S_box_2 S2(right_xor, comp2xor);
	combine4 C4(comp1xor, comp2xor, compxor);
	transposition_P_box TPB(compxor, transxor);
	four_bit_xor FBX(left_half, transxor, new_left_half);
	assign new_right_half = right_half;
endmodule

module crypt(plaintext, key, mode, ciphertext);
	input [0:7] plaintext;
	input [0:9] key;
	input mode;
	output [0:7] ciphertext;
	wire [0:7] initial_permute;
	wire [0:3] left_half;
	wire [0:3] right_half;
	wire [0:7] key1;
	wire [0:7] key2;
	reg [0:7] K1;
	reg [0:7] K2;
	wire [0:3] new_right_half;
	wire [0:3] new_left_half;
	wire [0:3] new_right_half1;
	wire [0:3] new_left_half1;
	wire [0:3] new_new_right_half;
	wire [0:3] new_new_left_half;
	wire [0:7] last_step;
	

	//Generating keys 1 and 2
	key_generator K(key, key1, key2);

	//Operations on plaintext
	initial_permutation IP(plaintext, initial_permute);
	divide8 D8(initial_permute, left_half, right_half);
	
	//Mode 0 - encryption, 1 - decryption
	//For decryption, order of the subkeys used for rounds 1 and 2 must be reversed (the order is unchanged during encryption)
	//This is carried out in the following procedural block
	always @*
	begin
		if(mode==1'b0)
		begin
			K1 = key1;
			K2 = key2;
		end
		else
		begin
			K1 = key2;
			K2 = key1;
		end
	end


	//Round1
	round R1(left_half, right_half, K1, new_left_half, new_right_half);
	four_bit_swap FBS(new_left_half, new_right_half, new_left_half1, new_right_half1);
	//Round2
	round R2(new_left_half1, new_right_half1, K2, new_new_left_half, new_new_right_half);

	combine8 C8__(new_new_left_half, new_new_right_half, last_step);
	inverse_initial_permutation IIP(last_step, ciphertext);
endmodule