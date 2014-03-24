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
   
    sam.x = 145/2;
    sam.y = 170/2;
    
    nightfever.x = 145/2;
    nightfever.y = 250/2;
    
    rejected.x = 145/2;
    rejected.y = 330/2;
    
    onebyone.x = 145/2;
    onebyone.y = 410/2;
    
    neverwanted.x = 145/2;
    neverwanted.y = 490/2;
    
    dragonking.x = 540/2;
    dragonking.y = 170/2;
    
    crazynights.x = 540/2;
    crazynights.y = 250/2;
    
    broken.x = 540/2;
    broken.y = 330/2;
    
    quijesuis.x = 540/2;
    quijesuis.y = 410/2;
    
    ambassador.x = 540/2;
    ambassador.y = 490/2;
    
    closecross.x = 870/2;
    closecross.y = 10/2;
    
    
}

void CTrackView::setHitAreasIphone5NonRetina() {
    sam.x = 230/2;
    sam.y = 180/2;
    
    nightfever.x = 230/2;
    nightfever.y = 260/2;
    
    rejected.x = 230/2;
    rejected.y = 340/2;
    
    onebyone.x = 230/2;
    onebyone.y = 420/2;
    
    neverwanted.x = 230/2;
    neverwanted.y = 510/2;
    
    dragonking.x = 620/2;
    dragonking.y = 180/2;
    
    crazynights.x = 620/2;
    crazynights.y = 260/2;
    
    broken.x = 620/2;
    broken.y = 340/2;
    
    quijesuis.x = 620/2;
    quijesuis.y = 420/2;
    
    ambassador.x = 620/2;
    ambassador.y = 510/2;
    
    closecross.x = 1035/2;
    closecross.y = 25/2;

    
}


void CTrackView::setup() {
    
    onebyone = ofRectangle(0, 0, 300/2,60/2);
    crazynights = ofRectangle(0, 0, 300/2,60/2);
    nightfever = ofRectangle(0, 0, 300/2,60/2);
    sam = ofRectangle(0, 0, 300/2,60/2);
    rejected = ofRectangle(0, 0, 300/2,60/2);
    dragonking = ofRectangle(0, 0, 300/2,60/2);
    broken = ofRectangle(0, 0, 300/2,60/2);
    ambassador = ofRectangle(0, 0, 300/2,60/2);
    quijesuis = ofRectangle(0, 0, 300/2,60/2);
    neverwanted = ofRectangle(0, 0, 300/2,60/2);
    closecross = ofRectangle(0,0,80/2,80/2);
    
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
    
    ofRect(closecross);*/
    
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