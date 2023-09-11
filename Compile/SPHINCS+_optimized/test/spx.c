#include <stdio.h>
#include <string.h>
#include "../api.h"
#include "../params.h"
#include "../randombytes.h"
#include "../uart.h"

#define SPX_MLEN 32
#define SPX_SIGNATURES 1

int main()
{
    char band[20];

    unsigned long start_0, end_0, start_1, end_1, start_2, end_2;

    uart_tx_string("\n--- Iniciando SPX ---\n");
    //int ret = 0;
    int i;

    /* Make stdout buffer more responsive. */
    //setbuf(stdout, NULL);

     unsigned char pk[SPX_PK_BYTES];
     unsigned char sk[SPX_SK_BYTES];
     unsigned char m[SPX_MLEN] ;
     unsigned char sm[SPX_BYTES + SPX_MLEN] ;
     unsigned char mout[SPX_BYTES + SPX_MLEN];
     unsigned long long smlen;
     unsigned long long mlen;


    randombytes(m, SPX_MLEN);

    uart_tx_string("Generating keypair.. ");

    start_0 = read_cycles();
    if (crypto_sign_keypair(pk, sk)) {
        uart_tx_string("failed!\n");
        //return -1;
    }
    end_0 = read_cycles();
    uart_tx_string("successful.\n");

    
    
    uart_tx_string("Testing ");
    itoa(band, SPX_SIGNATURES, 10);
    uart_tx_string(band);
    uart_tx_string(" signatures.. \n");

    for (i = 0; i < SPX_SIGNATURES; i++) {
        uart_tx_string("  - iteration #");
        itoa(band, i, 10);
        uart_tx_string(band);
        uart_tx_string(": \n");

        start_1 = read_cycles();    
        crypto_sign(sm, &smlen, m, SPX_MLEN, sk);
        end_1 = read_cycles();

        if (smlen != SPX_BYTES + SPX_MLEN) {
            uart_tx_string("  X smlen incorrect [");
            itoa(band, smlen, 10);
            uart_tx_string(band);
            uart_tx_string(" != ");
            itoa(band, SPX_BYTES, 10);
            uart_tx_string("]! \n");
            //ret = -1;
        }
        else {
            uart_tx_string("    smlen as expected [");
            itoa(band, smlen, 10);
            uart_tx_string(band);
            uart_tx_string("].\n");
        }

        start_2 = read_cycles();
        /* Test if signature is valid. */
        if (crypto_sign_open(mout, &mlen, sm, smlen, pk)) {
            uart_tx_string("  X verification failed!\n");
            //ret = -1;
        }
        else {
            uart_tx_string("    verification succeeded.\n");
        }
        end_2 = read_cycles();


        /* Test if the correct message was recovered. */
        if (mlen != SPX_MLEN) {
            uart_tx_string("  X mlen incorrect [");
            itoa(band, mlen, 10);
            uart_tx_string(band);
            uart_tx_string(" != ");
            itoa(band, SPX_MLEN, 10);
            uart_tx_string(band);
            uart_tx_string("]!\n");

            //ret = -1;
        }
        else {
            uart_tx_string("    mlen as expected [");
            itoa(band, mlen, 10);
            uart_tx_string(band);
            uart_tx_string("].\n");
        }
        if (memcmp(m, mout, SPX_MLEN)) {
            uart_tx_string("  X output message incorrect!\n");
            //ret = -1;
        }
        else {
            uart_tx_string("    output message as expected.\n");
        }

        /* Test if signature is valid when validating in-place. */
        if (crypto_sign_open(sm, &mlen, sm, smlen, pk)) {
            uart_tx_string("  X in-place verification failed!\n");
            //ret = -1;
        }
        else {
            uart_tx_string("    in-place verification succeeded.\n");
        }

        /* Test if flipping bits invalidates the signature (it should). */

        /* Flip the first bit of the message. Should invalidate. */
        sm[smlen - 1] ^= 1;
        if (!crypto_sign_open(mout, &mlen, sm, smlen, pk)) {
            uart_tx_string("  X flipping a bit of m DID NOT invalidate signature!\n");
            //ret = -1;
        }
        else {
            uart_tx_string("    flipping a bit of m invalidates signature.\n");
        }
        sm[smlen - 1] ^= 1;

#ifdef SPX_TEST_INVALIDSIG
        int j;
        /* Flip one bit per hash; the signature is entirely hashes. */
        for (j = 0; j < (int)(smlen - SPX_MLEN); j += SPX_N) {
            sm[j] ^= 1;
            if (!crypto_sign_open(mout, &mlen, sm, smlen, pk)) {
                uart_tx_string("  X flipping bit DID NOT invalidate sig + m!\n");
                sm[j] ^= 1;
                //ret = -1;
                break;
            }
            sm[j] ^= 1;
        }
        if (j >= (int)(smlen - SPX_MLEN)) {
            uart_tx_string("    changing any signature hash invalidates signature.\n");
        }
#endif

    }

    uart_tx_string("\n--- Terminando SPX ---\n");

    uart_tx_string("--- Cycles keypair ---\n");
    print_runtime(start_0, end_0);
    uart_tx_string("--- ************** ---\n");

    uart_tx_string("--- Cycles sing ---\n");
    print_runtime(start_1, end_1);
    uart_tx_string("--- *********** ---\n");

    uart_tx_string("--- Cycles veri ---\n");
    print_runtime(start_2, end_2);
    uart_tx_string("--- *********** ---\n");

    

    return (0);
}