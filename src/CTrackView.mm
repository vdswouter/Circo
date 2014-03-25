//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CTrackView.h"
#import "CSoundPlayer.h"

void CTrackView::setHitAreasIphone4NonRetina() {
   
    sam.x = 140/2;
    sam.y = 238/2;
    
    nightfever.x = 140/2;
    nightfever.y = 312/2;
    
    rejected.x = 140/2;
    rejected.y = 386/2;
    
    onebyone.x = 140/2;
    onebyone.y = 460/2;
    
    neverwanted.x = 140/2;
    neverwanted.y = 534/2;
    
    dragonking.x = 572/2;
    dragonking.y = 238/2;
    
    crazynights.x = 572/2;
    crazynights.y = 312/2;
    
    broken.x = 572/2;
    broken.y = 386/2;
    
    quijesuis.x = 572/2;
    quijesuis.y = 460/2;
    
    ambassador.x = 572/2;
    ambassador.y = 534/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;
    
    
}

void CTrackView::setHitAreasIphone5NonRetina() {
    
    sam.x = 238/2;
    sam.y = 238/2;
    
    nightfever.x = 238/2;
    nightfever.y = 312/2;
    
    rejected.x = 238/2;
    rejected.y = 386/2;
    
    onebyone.x = 238/2;
    onebyone.y = 460/2;
    
    neverwanted.x = 238/2;
    neverwanted.y = 534/2;
    
    dragonking.x = 669/2;
    dragonking.y = 238/2;
    
    crazynights.x = 669/2;
    crazynights.y = 312/2;
    
    broken.x = 669/2;
    broken.y = 386/2;
    
    quijesuis.x = 669/2;
    quijesuis.y = 460/2;
    
    ambassador.x = 669/2;
    ambassador.y = 534/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;

    
}


void CTrackView::setup() {
    
    float width = 252;
    float height = 56;
    
    onebyone = ofRectangle(0, 0, width/2,height/2);
    crazynights = ofRectangle(0, 0, width/2,height/2);
    nightfever = ofRectangle(0, 0, width/2,height/2);
    sam = ofRectangle(0, 0, width/2,60/2);
    rejected = ofRectangle(0, 0, width/2,height/2);
    dragonking = ofRectangle(0, 0, width/2,height/2);
    broken = ofRectangle(0, 0, width/2,height/2);
    ambassador = ofRectangle(0, 0, width/2,height/2);
    quijesuis = ofRectangle(0, 0, width/2,height/2);
    neverwanted = ofRectangle(0, 0, width/2,height/2);
    closecross = ofRectangle(0,0,90/2,90/2);
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        image.loadImage("images/trackscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/trackscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/trackscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/trackscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
}

void CTrackView::update() {
    
}

void CTrackView::draw() {
    
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
            float f=1.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    ofDisableAlphaBlending();
    
    /*
    ofRect(onebyone);
    ofRect(crazynights);
    ofRect(nightfever);
    ofRect(sam);
    ofRect(rejected);
    
    ofRect(dragonking);
    ofRect(broken);
    ofRect(ambassador);
    ofRect(quijesuis);
    ofRect(neverwanted);
    
    ofRect(closecross);
    */
    
    ofSetColor(255, 255, 255,255);
    
}


void CTrackView::touchDown(ofTouchEventArgs & touch) {
    
     if(sam.inside(touch.x, touch.y)) {
         [[CSoundPlayer sharedManager]playSongWithid:0];
     } else if (nightfever.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:1];
         
     } else if (rejected.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:2];
         
     } else if (onebyone.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:3];
         
     } else if (neverwanted.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:4];
         
     } else if (dragonking.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:5];
         
     } else if (crazynights.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:6];
         
     } else if (broken.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:7];
         
     } else if (quijesuis.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:8];
         
     } else if (ambassador.inside(touch.x, touch.y)) {
          [[CSoundPlayer sharedManager]playSongWithid:9];
         
     } else if (closecross.inside(touch.x, touch.y)) {
         if (!fadeout) {
             fadeout = true;
         }
     } else {
         
     }
    
    /*if (!fadeout) {
        fadeout = true;
    }*/
}
void CTrackView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchUp(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchCancelled(ofTouchEventArgs & touch) {
    
}