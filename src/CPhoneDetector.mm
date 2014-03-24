//
//  CPhoneDetector.cpp
//  Circo
//
//  Created by Wim Vanhenden on 16/03/14.
//
//

#include "CPhoneDetector.h"



int CPhoneDetector::detectPhone() {
    
    float width = ofGetWidth();
    
    if (width==480) {
       return C_IPHONE_4_NON_RETINA;
    }
    
    if (width==568) {
        return C_IPHONE_5_NON_RETINA;
    }
    
    if (width==960) {
        return C_IPHONE_4_RETINA;
    }
    
    if (width==1136) {
        return C_IPHONE_5_RETINA;
    }
    
    return 0;
    
};
