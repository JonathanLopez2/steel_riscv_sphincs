
// //This code was taken from the SPHINCS reference implementation and is public domain.

// #include <fcntl.h>
// #include <unistd.h>
// #include <stdio.h>


// #include "randombytes.h"

// static int fd = -1;

// void randombytes(unsigned char *x, unsigned long long xlen)
// {
//     printf("size: %lld \n",xlen);
//     int i;

//     if (fd == -1) {
//         for (;;) {
//             fd = open("/dev/urandom", O_RDONLY);
//             if (fd != -1) {
//                 break;
//             }
//             sleep(1);
//         }
//     }

//     fd = 3;

//     //printf("fd: %d \n",fd);

//     while (xlen > 0) {
//         //printf("x: %u \n",x);
//         if (xlen < 1048576) {
//             i = xlen;
//         }
//         else {
//             i = 1048576;
//         }
//         i = read(fd, x, i);
//         //printf("x: %u \n",x);
//         if (i < 1) {
//             sleep(1);
//             continue;
//         }
//         //printf("i: %d \n",i);
//         x += i;
//         //printf("x: %u \n",x);
//         xlen -= i;
//     }
// }


#include "randombytes.h"

void randombytes(unsigned char * x,unsigned long long xlen) {
    
    unsigned char band[96] = "iudsgf73rv 3$&d#gv8r10934v59$#%#$&#/(FGFCR43r8btcn 09qasdwuer83183rcnu093r°!##$$&jgfvniri90u";
    if (xlen == 16)
    {
        for (int i = 0; i < 16; ++i)
        {
            x[i] = band[i+60];
        }
    }
    else if (xlen == 24)
    {
        for (int i = 0; i < 24; ++i)
        {
            x[i] = band[i+44];
        }
    }
    else if (xlen == 32)
    {
        for (int i = 0; i < 32; ++i)
        {
            x[i] = band[i+54];
        }
    }
    else if (xlen == 48)
    {
        for (int i = 0; i < 48; ++i)
        {
            x[i] = band[i+40];
        }
    }
    else if (xlen == 72)
    {
        for (int i = 0; i < 72; ++i)
        {
            x[i] = band[i+10];
        }
    }
    else if (xlen == 96)
    {
        for (int i = 0; i < 96; ++i)
        {
            x[i] = band[i];
        }
    }

    //printf("r:%s\n\n", x);
}



// /**
//  * WARNING
//  *
//  * This file generates a PREDICTABLE and NOT AT ALL RANDOM sequence of bytes.
//  *
//  * Its purpose is to support our testing suite and it MUST NOT be used in any
//  * scenario where you are expecting actual cryptography to happen.
// */

// #include "randombytes.h"
// #include <stdint.h>
// #include <stdio.h>


// static uint32_t seed[32] = { 3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3,
//                              2, 3, 8, 4, 6, 2, 6, 4, 3, 3, 8, 3, 2, 7, 9, 5
//                            };
// static uint32_t in[12];
// static uint32_t out[8];
// static int32_t outleft = 0;

// #define ROTATE(x, b) (((x) << (b)) | ((x) >> (32 - (b))))
// #define MUSH(i, b) x = t[i] += (((x ^ seed[i]) + sum) ^ ROTATE(x, b));

// static void surf(void) {
//     uint32_t t[12];
//     uint32_t x;
//     uint32_t sum = 0;
//     int32_t r;
//     int32_t i;
//     int32_t loop;

//     for (i = 0; i < 12; ++i) {
//         t[i] = in[i] ^ seed[12 + i];
//     }
//     for (i = 0; i < 8; ++i) {
//         out[i] = seed[24 + i];
//     }
//     x = t[11];
//     for (loop = 0; loop < 2; ++loop) {
//         for (r = 0; r < 16; ++r) {
//             sum += 0x9e3779b9;
//             MUSH(0, 5)
//             MUSH(1, 7)
//             MUSH(2, 9)
//             MUSH(3, 13)
//             MUSH(4, 5)
//             MUSH(5, 7)
//             MUSH(6, 9)
//             MUSH(7, 13)
//             MUSH(8, 5)
//             MUSH(9, 7)
//             MUSH(10, 9)
//             MUSH(11, 13)
//         }
//         for (i = 0; i < 8; ++i) {
//             out[i] ^= t[i + 4];
//         }
//     }
// }

// void randombytes(unsigned char *x, unsigned long long xlen) {
//     printf("Entry\n");
//     printf("size: %lld \n",xlen);
//     while (xlen > 0) {
//         if (!outleft) {
//             if (!++in[0]) {
//                 if (!++in[1]) {
//                     if (!++in[2]) {
//                         ++in[3];
//                     }
//                 }
//             }
//             surf();
//             outleft = 8;
//         }
//         *x = (unsigned char) out[--outleft];
//         ++x;
//         --xlen;
//     }
//     //printf("Entry\n");
// }


// // void randombytes(unsigned char *x, unsigned long long xlen) {
// //     while (xlen > 0) {
// //         int i;
// //         if (xlen < 1048576) {
// //             i = xlen;
// //         }
// //         else {
// //             i = 1048576;
// //         }

// //         if (!outleft) {
// //             if (!++in[0]) {
// //                 if (!++in[1]) {
// //                     if (!++in[2]) {
// //                         ++in[3];
// //                     }
// //                 }
// //             }
// //             surf();
// //             outleft = 8;
// //         }
// //         //printf("out: %u \n",out[--outleft]);
// //         //printf("out[%lld]: %c \n",xlen,out[outleft]);
// //         //printf("out: %u \n",out);
// //         //printf("out[%lld]: %u \n",xlen,out[--outleft]);
// //         //printf("i: %d \n",i);
// //         //i = read(3, x, i);
// //         x += i;
// //         xlen -= i;
// //         printf("random in:%u\n\n", x);
// //     }
// //     printf("random in:%u\n\n", x);
// //     //printf("random in:%s\n\n", x);
// // }

