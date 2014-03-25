//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CQueView.h"

void CQueView::setHitAreasIphone4NonRetina() {
    
    
    lmrbutton.x=843/2;
    lmrbutton.y=18/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;
    
    fbbutton.x = 155/2;
    fbbutton.y = 535/2;
    
}

void CQueView::setHitAreasIphone5NonRetina() {
    
    lmrbutton.x=1017/2;
    lmrbutton.y=25/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;
    
    fbbutton.x = 269/2;
    fbbutton.y = 551/2;

}


void CQueView::setup() {
    
    
    closecross = ofRectangle(0,0,90/2,90/2);
    fbbutton = ofRectangle(0,0,658/2,72/2);
    lmrbutton = ofRectangle(0,0,90/2,90/2);
    
    blmrscreenselected = false;
    
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
    
     //ofRect(closecross);
     //ofRect(fbbutton);
     //ofRect(lmrbutton);
    
    
    if (lmrview!=NULL) {
        lmrview->draw();
    }
     
    
    ofSetColor(255, 255, 255,255);
    
}


void CQueView::touchDown(ofTouchEventArgs & touch) {
    
    
    if(!blmrscreenselected) {
        
        if(lmrbutton.inside(touch.x, touch.y)) {
            
            blmrscreenselected = true;
            lmrview = new CLMRView();
            lmrview->setup();
            ofAddListener(lmrview->removeView ,this,&CQueView::removeThisView);
            
        } else if (closecross.inside(touch.x, touch.y)) {
            if (!fadeout) {
                fadeout = true;
            }
        } else if (fbbutton.inside(touch.x, touch.y)) {
            NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/57654651250"];
            if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
                [[UIApplication sharedApplication] openURL:facebookURL];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
            }
        } else {
            
        }
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

void CQueView::removeThisView(float &f) {
    
    if (f==6) {
        ofRemoveListener(lmrview->removeView ,this,&CQueView::removeThisView);
        delete lmrview;
        lmrview = NULL;
    }
    
   
    blmrscreenselected = false;
    
}

