# Small Scale DES Algorithm Hardware Implementation
## Team details
```
Semester: 3rd Sem B. Tech. CSE
Section: S1
```
### Team members
1. 221CS112, Arjun Ravisankar, arjunravisankar.221cs112@nitk.edu.in, 6360968991
2. 221CS140, Prayag Ganesh Prabhu, prayagganeshprabhu.221cs140@nitk.edu.in, 9353997270
3. 221CS154, Singaraju B V Sreedakshinya, singarajubvsreedakshinya.221cs154@nitk.edu.in, 9606180825

## Abstract
Encryption is the process of converting data into a code to prevent unauthorised access to it. An encryption algorithm converts the original text into an alternative, unreadable form known as ciphertext. Decryption is the reverse process in which the ciphertext is converted back into original text by an authorised user using a key or password, to access the original information.

In the digital era we live in, encryption is vital to ensure the protection of confidential information and messages, financial transactions, classified military communications and matters of national security. The global cyber security landscape has seen increased threats in recent years.
Cybercrime has been exhibiting an upward trend globally. Therefore, cryptography is a field of prime importance in these times. 

Most high-level encryption algorithms such as DES (Data Encryption Standard) are implemented as software models only. Hardware models are rare, and most of the existing ones use complex components such as FPGAs (Field Programmable Gate Arrays). We decided to implement it as a hardware model utilising simpler components. Hardware models are known to be significantly faster, more secure (resisting timing/power analysis attacks) and efficient than software models. Our model will implement a scaled-down, simpler version of the DES algorithm for the purpose of quick and urgent classified communication. Our choice of DES was due to its well-known status as a standard encryption algorithm and as a highly influential precursor in the development of modern cryptographic techniques and will be a good first choice for hardware implementation.

## Project Overview
The project involves designing a digital circuit for the S-DES algorithm, which includes key generation, initial permutation, substitution-permutation network, and final permutation. The primary goal of the project is to implement a hardware version of the S-DES encryption and decryption processes and provide a practical educational resource for learning about hardware design, cryptography, and digital logic.

## Working

The key is passed to the key generator subcircuit. After splitting the bits, left shift and contraction permutation operations are performed to obtain subkeys K1 and K2.
The plaintext is passed to the initial permutation subcircuit. Inside the subcircuit, splitting of bits and permutation is done.
 From the resulting 8 bits, the right half is passed to the round function subcircuit which includes
(a) expanded permutation, 
(b) bitwise XOR with K1 (encryption)/K2 (decryption)
(c) substitution using S-boxes operations, 
(d) transposition (P-box),
(e) bitwise XOR with the left half obtained from the initial permutation 
(f) combination with the right half from the initial permutation. 
The left half is now swapped with the right half in the "4-bit swap" step. 
The right half of the resulting 8-bit intermediate is passed to the round subcircuit, in which only the key used for XOR is changed (K2 for encryption and K1 for decryption). 
The new 8 bit-intermediate undergoes inverse initial permutation and the result is the ciphertext (encryption)/decrypted text (decryption).

### Block Diagram
![image](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/161fbd28-971a-43f9-b778-49626509bd02)

### Functional Table
![image](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/60e448ce-a19c-4254-967e-5649162627fb)


## Logisim Circuit
![Overall](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/0b6a3caf-d163-4eb5-ae9e-e660075bd66b)

![Key](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/f47a7573-8ff8-4aea-9f6e-557c1cd314bd)

![INITIAL PERMUTATION](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/86d56e42-2c20-48a2-aa13-c79ed532576c)

![Round ](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/15845e2c-82ef-4c54-b033-02a8b3983a66)

![4 - BIT SWAP](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/ea1a5226-b772-4736-b1ca-adb5726cac9d)

![INVERSE INITIAL PERMUTATION](https://github.com/SreeDakshinya/S1-T18-Small-Scale-DES-Algorithm-Hardware-Implementation/assets/127178102/804a0bc3-17f5-4d80-adc1-e804f91a0846)

## Verilog Code

(Assumption made while writing Verilog code: Verilog being a hardware description language offers us the flexibility to use the input as an array of bits, and not necessarily as a single entity. Bitwise operations can be performed easily on the array elements by accessing them with their indices, hence eliminating the need for the usage of counters, bit selectors, comparators and registers for bit-by-bit selection.
We have harnessed this capability of Verilog while writing the code which simulates the functioning of our entire circuit, and hence, a few structural differences can be noticed between the Logisim circuit diagrams and the Verilog code.)

```
//Design of Digital Systems Mini Project
//S1 Team 18 - Small Scale DES Algorithm Hardware Implementation

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


module encryption(plaintext, key, ciphertext);
    input [0:7] plaintext;
    input [0:9] key;
    output [0:7] ciphertext;
    wire [0:7] initial_permute;
    wire [0:3] left_half;
    wire [0:3] right_half;
    wire [0:7] expanded_permute;
    wire [0:9] initial_key_permute;
    wire [0:4] key_left;
    wire [0:4] key_right;
    wire [0:4] shifted_left;
    wire [0:4] shifted_right;
    wire [0:9] shifted_key1;
    wire [0:7] key1;
    wire [0:4] shifted2_left;
    wire [0:4] shifted2_right;
    wire [0:9] shifted_key2;
    wire [0:7] after_xor1;
    wire [0:3] left_xor1;
    wire [0:3] right_xor1;
    wire [0:1] comp1xor1;
    wire [0:1] comp2xor1;
    wire [0:3] compxor1;
    wire [0:3] transxor1;
    wire [0:7] key2;
    wire [0:3] new_right_half;
    wire [0:3] new_left_half;
    wire [0:7] expanded_permute2;
    wire [0:7] after_xor2;
    wire [0:3] left_xor2;
    wire [0:3] right_xor2;
    wire [0:1] comp1xor2;
    wire [0:1] comp2xor2;
    wire [0:3] compxor2;
    wire [0:3] transxor2;
    wire [0:3] new_new_right_half;
    wire [0:3] new_new_left_half;
    wire [0:7] last_step;
   


    //Generating keys 1 and 2
    permutation_P10 Pten(key, initial_key_permute);
    divide10 D10(initial_key_permute, key_left, key_right);
    left_shift_1 LS1(key_left, key_right, shifted_left, shifted_right);
    combine10 C10(shifted_left, shifted_right, shifted_key1);
    permutation_P8 PP8(shifted_key1, key1);
    left_shift_2 LS2(shifted_left, shifted_right, shifted2_left, shifted2_right);
    combine10 C10_(shifted2_left, shifted2_right, shifted_key2);
    permutation_P8 PP8_(shifted_key2, key2);


    //Operations on plaintext
    initial_permutation IP(plaintext, initial_permute);
    divide8 D8(initial_permute, left_half, right_half);
   
    //Round1
    expansion EP(right_half, expanded_permute);
    eight_bit_xor EBX(expanded_permute, key1, after_xor1);
    divide8 D8_(after_xor1, left_xor1, right_xor1);
    S_box_1 S1(left_xor1, comp1xor1);
    S_box_2 S2(right_xor1, comp2xor1);
    combine4 C4(comp1xor1, comp2xor1, compxor1);
    transposition_P_box TPB(compxor1, transxor1);
    four_bit_xor FBX(left_half, transxor1, new_right_half);
    assign new_left_half = right_half;


    //Round2
    expansion EP_(new_right_half, expanded_permute2);
    eight_bit_xor ebx(expanded_permute2, key2, after_xor2);
    divide8 D8__(after_xor2, left_xor2, right_xor2);
    S_box_1 S1_(left_xor2, comp1xor2);
    S_box_2 S2_(right_xor2, comp2xor2);
    combine4 C4_(comp1xor2, comp2xor2, compxor2);
    transposition_P_box tpb(compxor2, transxor2);
    four_bit_xor fbx(new_left_half, transxor2, new_new_left_half);
    assign new_new_right_half = new_right_half;


    combine8 C8__(new_new_left_half, new_new_right_half, last_step);
    inverse_initial_permutation IIP(last_step, ciphertext);
endmodule


module decryption(plaintext, key, ciphertext);
    input [0:7] plaintext;
    input [0:9] key;
    output [0:7] ciphertext;
    wire [0:7] initial_permute;
    wire [0:3] left_half;
    wire [0:3] right_half;
    wire [0:7] expanded_permute;
    wire [0:9] initial_key_permute;
    wire [0:4] shifted_left;
    wire [0:4] shifted_right;
    wire [0:9] shifted_key1;
    wire [0:7] key1;
    wire [0:4] shifted2_left;
    wire [0:4] shifted2_right;
    wire [0:9] shifted_key2;
    wire [0:7] after_xor1;
    wire [0:3] left_xor1;
    wire [0:3] right_xor1;
    wire [0:1] comp1xor1;
    wire [0:1] comp2xor1;
    wire [0:3] compxor1;
    wire [0:3] transxor1;
    wire [0:7] key2;
    wire [0:3] new_right_half;
    wire [0:3] new_left_half;
    wire [0:7] expanded_permute2;
    wire [0:7] after_xor2;
    wire [0:3] left_xor2;
    wire [0:3] right_xor2;
    wire [0:1] comp1xor2;
    wire [0:1] comp2xor2;
    wire [0:3] compxor2;
    wire [0:3] transxor2;
    wire [0:3] new_new_right_half;
    wire [0:3] new_new_left_half;
    wire [0:7] last_step;
    wire [0:4] key_left;
    wire [0:4] key_right;




    //Generating keys 1 and 2
    permutation_P10 Pten(key, initial_key_permute);
    divide10 D10(initial_key_permute, key_left, key_right);
    left_shift_1 LS1(key_left, key_right, shifted_left, shifted_right);
    combine10 C10(shifted_left, shifted_right, shifted_key1);
    permutation_P8 PP8(shifted_key1, key1);
    left_shift_2 LS2(shifted_left, shifted_right, shifted2_left, shifted2_right);
    combine10 C10_(shifted2_left, shifted2_right, shifted_key2);
    permutation_P8 PP8_(shifted_key2, key2);
   
    //Operations on plaintext
    initial_permutation IP(plaintext, initial_permute);
    divide8 D8(initial_permute, left_half, right_half);
   
    //Round1
    expansion EP(right_half, expanded_permute);
    eight_bit_xor EBX(expanded_permute, key2, after_xor1);
    divide8 D8_(after_xor1, left_xor1, right_xor1);
    S_box_1 S1(left_xor1, comp1xor1);
    S_box_2 S2(right_xor1, comp2xor1);
    combine4 C4(comp1xor1, comp2xor1, compxor1);
    transposition_P_box TPB(compxor1, transxor1);
    four_bit_xor FBX(left_half, transxor1, new_right_half);
    assign new_left_half = right_half;


    //Round2
    expansion EP_(new_right_half, expanded_permute2);
    eight_bit_xor ebx(expanded_permute2, key1, after_xor2);
    divide8 D8__(after_xor2, left_xor2, right_xor2);
    S_box_1 S1_(left_xor2, comp1xor2);
    S_box_2 S2_(right_xor2, comp2xor2);
    combine4 C4_(comp1xor2, comp2xor2, compxor2);
    transposition_P_box tpb(compxor2, transxor2);
    four_bit_xor fbx(new_left_half, transxor2, new_new_left_half);
    assign new_new_right_half = new_right_half;


    combine8 C8__(new_new_left_half, new_new_right_half, last_step);
    inverse_initial_permutation IIP(last_step, ciphertext);
endmodule
```

### Test Bench
```
module DES_tb;
    wire [0:7] D;
    wire [0:7] C;
    reg [0:7] P;
    reg [0:9] K;
    encryption E1(P, K, C);
    decryption D1(C, K, D);


    initial
    begin
        $dumpfile("DES.vcd");
        $dumpvars(0, DES_tb);
    end
       
    initial
    begin
        $display("|                          DES                         |");       $display("--------------------------------------------------------");
        $display("| Plaintext |   Key    |  Ciphertext  |    Decrypted   |");
        $display("----------------------------------------------------------");
        $monitor("| %b%b%b%b%b%b%b%b  |%b%b%b%b%b%b%b%b%b%b|   %b%b%b%b%b%b%b%b   |    %b%b%b%b%b%b%b%b    |", P[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7], K[0], K[1], K[2], K[3], K[4], K[5], K[6], K[7], K[8], K[9], C[0], C[1], C[2], C[3], C[4], C[5], C[6], C[7], D[0], D[1], D[2], D[3], D[4], D[5], D[6], D[7]);
        //Plain text
        P = 8'b11100111;
       
        //Key
        K = 10'b1010000010;
           
    end
endmodule
```

## Folders 

### 1. Verilog
    It contains the main file and the test bench file along with the output file.
    To use the Verilog files:-
    Step 1
        Open the test bench file (S1-T18-DES-tb.v)

    Step 2
        Update the plaintext and the key.

    Step 3
        Run the code for the encrypted and the decrypted text.

### 2. Logisim
    It consists of the overall S-DES algorithm circuit.
    To use this circuit:-
    Step 1
        Click on the "Reset" button to reset the circuit. 

    Step 2
        Enter the values of the plaintext (for encryption) or ciphertext (for decryption) (under input) and key (under key).

    Step 3
        For encryption, set E/D to 0. For decryption, set it to 1.

    Step 4
        Click on the "Clock" button for at least 40 times.

    Step 5
        The desired output (ciphertext for encryption and plaintext for decryption) will appear in the "Output" box. 

### 3. Screenshots
    It contains the snippets of all the subcircuits of the final circuit and outputs of some sample inputs.

### 4. Block Diagram and Functional Table
    It contains the block diagram which displays the flow of execution of our circuit and the functional table of our circuit which shows the working of every part of the circuit with the help of an example.

## References

1. https://page.math.tu-berlin.de/~kant/teaching/hess/krypto-ws2006/des.htm 
    Author - J. Orlin Grabbe

2. https://ieeexplore.ieee.org/document/1161506 
    Authors - T. Arich , M. Eleuldj

3. William Stallings, Cryptography and Network Security 4ed.       
    Chapter 3 (Block Ciphers and the Data Encryption Standard)

4. M. Morris Mano, Digital Design With an Introduction to the Verilog HDL 6ed.

5. https://core.ac.uk/download/pdf/230495337.pdf 
    Authors - Deepak Guled, Nagaraj Angadi, Soumya Gali, Vidya M, Deepti Raj   

