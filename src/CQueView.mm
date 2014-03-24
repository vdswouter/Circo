//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CQueView.h"

void CQueView::setHitAreasIphone4NonRetina() {
    
    touchrectanglevote.x = 55;
    touchrectanglevote.y = 145;
    
    touchrectangleque.x= 200;
    touchrectangleque.y = 145;
    
    touchrectangletracks.x = 345;
    touchrectangletracks.y = 145;
}

void CQueView::setHitAreasIphone5NonRetina() {
    
    touchrectanglevote.x = 100;
    touchrectanglevote.y = 145;
    
    touchrectangleque.x= 240;
    touchrectangleque.y = 145;
    
    touchrectangletracks.x = 385;
    touchrectangletracks.y = 145;
}


void CQueView::setup() {
    
    
    touchrectanglevote = ofRectangle(0, 0, 80, 100);
    touchrectangleque = ofRectangle(0,0,80,100);
    touchrectangletracks = ofRectangle(0,0,80,100);
    
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        image.loadImage("images/quescreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/quescreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/quescreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/quescreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
}

void CQueView::update() {
    
}

void CQueView::draw() {
    
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
            
            float f=0.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    ofDisableAlphaBlending();
    
    ofSetColor(255, 255, 255,255);
    
}


void CQueView::touchDown(ofTouchEventArgs & touch) {
    if (!fadeout) {
        fadeout = true;
    }
}
void CQueView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CQueView::touchUp(ofTouchEventArgs & touch) {
    
}
void CQueView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CQueView::touchCancelled(ofTouchEventArgs & touch) {
    
}