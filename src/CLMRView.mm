//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CLMRView.h"

void CLMRView::setHitAreasIphone4NonRetina() {
    
    closecross.x = 33/2;
    closecross.y = 17/2;

}

void CLMRView::setHitAreasIphone5NonRetina() {
    closecross.x = 33/2;
    closecross.y = 17/2;
}


void CLMRView::setup() {
    
    
    closecross = ofRectangle(0,0,90/2,90/2);

    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        image.loadImage("images/lmrscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/lmrscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/lmrscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/lmrscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
}

void CLMRView::update() {
    
}

void CLMRView::draw() {
    
    ofEnableAlphaBlending();
    if (fadein) {
        ofSetColor(255, 255, 254, fadeval);
        
        fadeval+=6;
        
        if (fadeval>=255) {
            ofRegisterTouchEvents(this);
            fadeval= 255;
            fadein = false;
        }
    }
    
    if (fadeout) {
        ofSetColor(255, 255, 254, fadeval);
        fadeval -=6;
        if (fadeval<=0) {
            fadeval= 0;
            fadeout = false;
            ofUnregisterTouchEvents(this);
            
            float f=6.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    ofDisableAlphaBlending();
    /*
    ofRect(closecross);
    ofRect(fbbutton);
    ofRect(lmrbutton);
    */
    
    ofSetColor(255, 255, 255,255);
    
}

void CLMRView::touchDown(ofTouchEventArgs & touch) {
    if (closecross.inside(touch.x, touch.y)) {
        if (!fadeout) {
            fadeout = true;
        }
    }
}
void CLMRView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CLMRView::touchUp(ofTouchEventArgs & touch) {
    
}
void CLMRView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CLMRView::touchCancelled(ofTouchEventArgs & touch) {
    
}