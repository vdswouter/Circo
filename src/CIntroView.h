//
//  CIntroView.h
//  Circo
//
//  Created by Wim Vanhenden on 16/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "CPhoneDetector.h"

class CIntroView {
    
public:
    void setup();
    void update();
    void draw();
    
    ofEvent<float> introViewDone;
    
private:
    ofImage logo;
    int startTime;
    int endTime;
    
    bool bTimerReached;
    bool fadeOutDone;
    
    float faderval;
};