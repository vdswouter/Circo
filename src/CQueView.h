#pragma once
#include "ofMain.h"
#include "CPhoneDetector.h"
#include "CQueView.h"
#include "CLMRView.h"

class CQueView {
    
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
    
    ofRectangle closecross;
    ofRectangle lmrbutton;
    ofRectangle fbbutton;
    
    
    void setHitAreasIphone4NonRetina();
    void setHitAreasIphone5NonRetina();
    
    CLMRView    *lmrview;
    bool        blmrscreenselected;
    
    void       removeThisView(float &f);
    
};