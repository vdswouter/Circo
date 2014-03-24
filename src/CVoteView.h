#pragma once
#include "ofMain.h"
#include "CPhoneDetector.h"

#import "CPersistantData.h"

class CVoteView {
    
public:
    
    void setup();
    void update();
    void draw();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    ofEvent<float> removeView;
    
    
private:
    
    ofImage image;
    
    float fadeval;
    
    float backgroundfadeval;
    
    bool fadein;
    bool fadeout;
    
    ofRectangle onebyone;
    ofRectangle crazynights;
    ofRectangle nightfever;
    ofRectangle sam;
    ofRectangle rejected;
    ofRectangle dragonking;
    ofRectangle broken;
    ofRectangle ambassador;
    ofRectangle quijesuis;
    ofRectangle neverwanted;
    ofRectangle closecross;
    
    void setHitAreasIphone4NonRetina();
    void setHitAreasIphone5NonRetina();
    
    ofImage star;
    
};