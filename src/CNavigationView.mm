//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CNavigationView.h"
#include "CDataModel.h"

void CNavigationView::startTimer(float time) {
    starttime = ofGetElapsedTimeMillis();
    endtime = time;
    bTimerReached = false;
    bTimerIsRunning  =true;

}

void CNavigationView::stopTimer() {
    bTimerReached = true;
    bTimerIsRunning  =false;
}


void CNavigationView::setHitAreasIphone4NonRetina() {
    
    touchrectanglevote.x = 55;
    touchrectanglevote.y = 110;
    
    touchrectangleque.x= 200;
    touchrectangleque.y = 110;
    
    touchrectangletracks.x = 345;
    touchrectangletracks.y = 110;
}

void CNavigationView::setHitAreasIphone5NonRetina() {
    
    touchrectanglevote.x = 100;
    touchrectanglevote.y = 110;
    
    touchrectangleque.x= 240;
    touchrectangleque.y = 110;
    
    touchrectangletracks.x = 385;
    touchrectangletracks.y = 110;
}


void CNavigationView::setup() {
    
    
    touchrectanglevote = ofRectangle(0, 0, 80, 100);
    touchrectangleque = ofRectangle(0,0,80,100);
    touchrectangletracks = ofRectangle(0,0,80,100);
    
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        image.loadImage("images/navigation_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/navigation_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/navigation_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/navigation_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
    
    bdoNotDraw = false;
    
    queview =NULL;
    trackview = NULL;
    voteview = NULL;
    bscreenisselected = false;
    
    startTimer(5000);
}

void CNavigationView::update() {
    
    //tap timer stuff
    if (bTimerIsRunning) {
        
        int timer = ofGetElapsedTimeMillis() - starttime;
        if(timer >= endtime && !bTimerReached) {
            bTimerReached = true;
            bTimerIsRunning = false;
            fadeout = true;
            
        }
    }
    
    if (queview!=NULL) {
        queview->update();
    }
    
    if (trackview!=NULL) {
        trackview->update();
    }
    
    if (voteview!=NULL) {
        voteview->update();
    }
    
}

void CNavigationView::draw() {
    
    
    if (!bdoNotDraw) {
    
    ofEnableAlphaBlending();
    if (fadein) {
        ofSetColor(255, 255, 254, fadeval);
        
        fadeval+=CDataModel::getInstance()->screenfadestep;
        
        if (fadeval>=255) {
            ofRegisterTouchEvents(this);
            fadeval= 255;
            fadein = false;
        }
    }
    
    if (fadeout) {
        ofSetColor(255, 255, 254, fadeval);
        fadeval -=CDataModel::getInstance()->screenfadestep;
        if (fadeval<=0) {
            fadeval= 0;
            fadeout = false;
            ofUnregisterTouchEvents(this);
            ofNotifyEvent(removeNavigationView, fadeval, this);
        }
    }
        
    //ofRect(touchrectangletracks);
    //ofRect(touchrectanglevote);
    //ofRect(touchrectangleque);
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    }

    
    ofDisableAlphaBlending();
    
    if (queview!=NULL) {
        queview->draw();
    }
    
    if (trackview!=NULL) {
        trackview->draw();
    }
    
    if (voteview!=NULL) {
        voteview->draw();
    }
    
    ofSetColor(255, 255, 255,255);
}


void CNavigationView::touchDown(ofTouchEventArgs & touch) {
    
   
    
    if (!bscreenisselected) {
        
        stopTimer();
        
        if(touchrectangletracks.inside(touch.x, touch.y)) {
            bscreenisselected = true;
            trackview = new CTrackView();
            trackview->setup();
            ofAddListener(trackview->removeView ,this,&CNavigationView::removeSubView);
            ofAddListener(trackview->viewReady ,this,&CNavigationView::subViewReady);
        
            
        } else if (touchrectangleque.inside(touch.x, touch.y)) {
            bscreenisselected = true;
            queview = new CQueView();
            queview->setup();
            ofAddListener(queview->removeView ,this,&CNavigationView::removeSubView);
             ofAddListener(queview->viewReady ,this,&CNavigationView::subViewReady);
            
        } else if(touchrectanglevote.inside(touch.x, touch.y)) {
            bscreenisselected = true;
            voteview = new CVoteView();
            voteview->setup();
            ofAddListener(voteview->removeView ,this,&CNavigationView::removeSubView);
            ofAddListener(voteview->viewReady ,this,&CNavigationView::subViewReady);
        } else {
            if (!fadeout) {
                fadeout = true;
            }
        }
    }
}
void CNavigationView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CNavigationView::touchUp(ofTouchEventArgs & touch) {
    
}
void CNavigationView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CNavigationView::touchCancelled(ofTouchEventArgs & touch) {
    
}


void CNavigationView::subViewReady(float &f) {
    bdoNotDraw = true;
   
    
    if (f==0) {
         ofRemoveListener(queview->viewReady ,this,&CNavigationView::subViewReady);
    }
    
    if (f==1) {
        ofRemoveListener(trackview->viewReady ,this,&CNavigationView::subViewReady);
    }
    
    if (f==2) {
         ofRemoveListener(voteview->viewReady ,this,&CNavigationView::subViewReady);
    }
}


void CNavigationView::removeSubView(float &f) {
    
    if (f==0) {
        ofRemoveListener(queview->removeView ,this,&CNavigationView::removeSubView);
        delete queview;
        queview = NULL;
    }
    
    if (f==1) {
        ofRemoveListener(trackview->removeView ,this,&CNavigationView::removeSubView);
        delete trackview;
        trackview = NULL;
    }
    
    if (f==2) {
        ofRemoveListener(voteview->removeView ,this,&CNavigationView::removeSubView);
        delete voteview;
        voteview = NULL;
    }
    
    
    ofUnregisterTouchEvents(this);
    float faa=0;
    ofNotifyEvent(removeNavigationView, faa, this);
    
    //bscreenisselected = false;
    //startTimer(5000);
}
