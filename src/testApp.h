#pragma once

#include "ofMain.h"

#include "CTriggerController.h"
#include "CDataModel.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "CIntroView.h"
#include "CBackGroundLayer.h"
#include "CNavigationView.h"
#include "CTwitterScreen.h"
#include "CVisualizer.h"
#include "CTriggerController.h"
#include "NCFontController.h"

#import "OBJCDataModel.h"
#import "CSoundPlayer.h"
#import "CPLibrary.h"
#import "CPersistantData.h"




class testApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void introscreenDone(float &f);
    
        void introvoicedone();
    
        void bootforreal();
    
        CBackGroundLayer    backgroundlayer;
    
        ofFbo               mainrender;
    
        //introview
        CIntroView          *introview;
    
        //navigation view
        CNavigationView     *navigationview;
        void                removeNavigationView(float &f);
    
        //twitter screen
        CTwitterScreen      *twitterview;
        void                twitterTimerGO(float &f);
        void                twitterScreenRemove(float &f);
    
    
        //tap timer
        float tapstartime;
        float tapendtime;
        bool btapTimerReached;
        bool btapTimerIsRunning;
    
        //general
        void drawCompleteScene();
        void drawCompleteSceneInFbo();
        bool bfirstfocus;
    
};


