//
//  CIntroView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 16/03/14.
//
//

#include "CIntroView.h"


void CIntroView::setup() {
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        logo.loadImage("images/background_4_retina_logo.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        logo.loadImage("images/background_4_retina_logo.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        logo.loadImage("images/background_5_retina_logo.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        logo.loadImage("images/background_5_retina_logo.png");
    }
    
    startTime = ofGetElapsedTimeMillis();
    
    endTime = startTime+2000;
    
    faderval = 255;
    
    fadeOutDone = false;
}

void CIntroView::update() {
    
    if (!fadeOutDone) {
        
        int timer = ofGetElapsedTimeMillis() - startTime;
        
        if(timer >= endTime && !bTimerReached) {
            bTimerReached = true;
        }
        
        if (bTimerReached) {
            faderval = faderval-3;
        }
        
        if (faderval <= 0) {
            faderval=0;
            float f = 0;
            fadeOutDone = true;
            ofNotifyEvent(introViewDone,f,this);
            
        }
    }
    
}

void CIntroView::draw() {
    if(!fadeOutDone) {
        ofEnableAlphaBlending();
        
        if (faderval<255) {
            ofSetColor(255, 255, 254,faderval);
        }
        
        logo.draw(0, 0, ofGetWidth(),ofGetHeight());
        ofDisableAlphaBlending();
        
        ofSetColor(255, 255, 255,255);
    }
    
}