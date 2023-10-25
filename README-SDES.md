# Small scale implementation of DES Algorithm

## Team members
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

