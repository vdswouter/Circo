//
//  CRandomGen.cpp
//  Circo
//
//  Created by Wim Vanhenden on 17/03/14.
//
//

#include "CRandomGen.h"

int CRandomGen::random_in_range_int (unsigned int min, unsigned int max) {
    int base_random = rand(); /* in [0, RAND_MAX] */
    if (RAND_MAX == base_random) return random_in_range_int(min, max);
    /* now guaranteed to be in [0, RAND_MAX) */
    int range       = max - min,
    remainder   = RAND_MAX % range,
    bucket      = RAND_MAX / range;
    /* There are range buckets, plus one smaller interval
     within remainder of RAND_MAX */
    if (base_random < RAND_MAX - remainder) {
        return min + base_random/bucket;
    } else {
        return random_in_range_int (min, max);
    }
}