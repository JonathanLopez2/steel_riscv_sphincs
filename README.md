# Hardware-Software desing of SPHINCS+

This repository presents an implementations under the tightly coupled processor design on a RISC-V type processor called steel for the SPHINCS+ a post-quantum cryptography scheme.

This design implements by software the 24 of 36 possible instances of the scheme, specifying hash functions and concrete parameters for the security level, tree dimensions, WOTS+ and FORS.See the table below for a summary of the parameter sets. These parameters target the NIST security categories 1, 3 and 5; for each category, there is a parameter set geared towards either small signatures or fast signature generation.

|                   | n    | h   | d  | log(t) | k   | w   | bit security | pk bytes | sk bytes | sig bytes |
|-------------------|------|-----|----|--------|-----|-----|--------------|----------|----------|-----------|
| SPHINCS+-128s     | 16   | 63  | 7  | 12     | 14  | 16  | 133          | 32       | 64       | 7,856     |
| SPHINCS+-128f     | 16   | 66  | 22 | 6      | 33  | 16  | 128          | 32       | 64       | 17,088    |
| SPHINCS+-192s     | 24   | 63  | 7  | 14     | 17  | 16  | 193          | 48       | 96       | 16,224    |
| SPHINCS+-192f     | 24   | 66  | 22 | 8      | 33  | 16  | 194          | 48       | 96       | 35,664    |
| SPHINCS+-256s     | 32   | 64  | 8  | 14     | 22  | 16  | 255          | 64       | 128      | 29,792    |
| SPHINCS+-256f     | 32   | 68  | 17 | 9      | 35  | 16  | 255          | 64       | 128      | 49,856    |

Hardware modules were created for two functions used in the scheme:
* SHAKE-256
* HARAKA

The contents of the folders are as follows:

* **Compile:** There are the files necessary to be able to modify the compiler and add additional instructions to work with the hardware in the processor, in addition to the SPHINCS+ software reference and the optimized reference of the proposed job.
* **RTL:** Verilog and SystemVerilog files of the job are located.
* **TEST:** Software written in Python to compare with hardware simulations of hashed modules.