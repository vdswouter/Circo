//
//  CPhoneDetector.h
//  Circo
//
//  Created by Wim Vanhenden on 16/03/14.
//
//

#pragma once
#include "ofMain.h"

enum iPhoneModel{
	C_IPHONE_4_NON_RETINA = 1,
	C_IPHONE_4_RETINA = 2,
    C_IPHONE_5_NON_RETINA = 3,
    C_IPHONE_5_RETINA = 4,
};

class CPhoneDetector {
    
public:
    static int detectPhone();    
};