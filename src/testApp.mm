#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){
    
    
    //ofSetLogLevel(OF_LOG_SILENT);
    
    ofSetFrameRate(60);
    
    //set orientation
    ofSetOrientation(OF_ORIENTATION_90_RIGHT);
    
    //always set up background
    backgroundlayer.setup();
    
    //always do intro animation
    introview = new CIntroView();
    introview->setup();
    CDataModel::getInstance()->screenmode = INTRO_SCREEN;
    ofAddListener(introview->introViewDone ,this,&testApp::introscreenDone);
    
    
    //set up visualizer
    CVisualizer::getInstance()->setup();
    
    
    //always set up these
    //1. set up acces to phot lib. This can take a few seconds
    [[CPLibrary sharedManager] setup];
    //2. data model for band images
    CDataModel::getInstance()->setup();
    //3. the sound player
    [[CSoundPlayer sharedManager] setup];
    //5. set up font controller
    NCFontController::getInstance()->setup();
    
    //set up main render fbo
    mainrender.allocate(ofGetWidth(), ofGetHeight());
    mainrender.begin();
    ofClear(255, 255, 254,255);
    mainrender.end();
    
    //set up navigation view
    navigationview = NULL;
    
    //set twitter view
    twitterview = NULL;
    
    //tap timer stuff
    btapTimerIsRunning = false;
    

}

//--------------------------------------------------------------
void testApp::update(){
    
    //tap timer stuff
    if (btapTimerIsRunning) {
    
    int timer = ofGetElapsedTimeMillis() - tapstartime;
    if(timer >= tapendtime && !btapTimerReached) {
        if (CDataModel::getInstance()->screenmode == VISUALIZER_SCREEN) {
            [[CSoundPlayer sharedManager] playNextSong];
            
        } else if (CDataModel::getInstance()->screenmode == VOICE_INTRO_SCREEN) {
            bootforreal();
        }
        btapTimerReached = true;
        btapTimerIsRunning = false;
    }
    }
    
    backgroundlayer.update();
    
    if (introview) {
        introview->update();
    }
   

    CVisualizer::getInstance()->update();
    
    if (navigationview) {
        navigationview->update();
    }
    
    if (twitterview) {
        
        drawCompleteSceneInFbo();
        twitterview->update(mainrender);
    }
    
}

//--------------------------------------------------------------
void testApp::draw() {

    
    if (twitterview) {
        twitterview->draw();
    } else {
        
        drawCompleteScene();

    }
}

//--------------------------------------------------------------
void testApp::drawCompleteScene() {
    backgroundlayer.draw();
    if (introview) {
        introview->draw();
    }
    
    CVisualizer::getInstance()->draw();
   
    if (navigationview) {
        navigationview->draw();
    }
}


//--------------------------------------------------------------
void testApp::drawCompleteSceneInFbo() {
    mainrender.begin();
        drawCompleteScene();
    mainrender.end();

}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    
    if (!btapTimerIsRunning) {
        btapTimerIsRunning = true;
        tapstartime = ofGetElapsedTimeMillis();
        tapendtime = 200;
        btapTimerReached = false;
    } else {
        btapTimerIsRunning = false;
        btapTimerReached = true;
    }
    
    if (touch.id>0) {
        if (twitterview==NULL) {
            twitterview = new CTwitterScreen();
            ofAddListener(twitterview->twitterScreenDone, this, &testApp::twitterScreenRemove);
            twitterview->setup();
        }
        
    }
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    btapTimerIsRunning = false;
    btapTimerReached = true;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    /*if (touch.id>0) {
        if (twitterview) {
            delete twitterview;
            twitterview = NULL;
        }
    }*/
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    if (CDataModel::getInstance()->screenmode == VISUALIZER_SCREEN) {
        CDataModel::getInstance()->screenmode = NAVIGATION_SCREEN;
        navigationview = new CNavigationView();
        navigationview->setup();
        ofAddListener(navigationview->removeNavigationView ,this,&testApp::removeNavigationView);
    }
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}
//--------------------------------------------------------------
void testApp::introscreenDone(float &f) {
  
    ofRemoveListener(introview->introViewDone ,this,&testApp::introscreenDone);
    delete introview;
    introview = NULL;
    
    if (![[CPersistantData sharedManager] firstrun]) {
        [[CSoundPlayer sharedManager] playIntroVoice];
        CDataModel::getInstance()->screenmode = VOICE_INTRO_SCREEN;
    } else {
        bootforreal();
    }
}

//--------------------------------------------------------------
void testApp::introvoicedone() {
    //bootforreal();
    
    
}

void testApp::bootforreal() {
    
   [[CPersistantData sharedManager] setFirstrun:true];
   [[CPersistantData sharedManager] saveData];

    [[CSoundPlayer sharedManager]playSongWithid: [[CPersistantData sharedManager] currentsong]];
    
    CDataModel::getInstance()->screenmode = VISUALIZER_SCREEN;
    
    //start running background screen
    backgroundlayer.startWithBAndPicture();
    CTriggerController::getInstance()->setup();
    ofAddListener(CTriggerController::getInstance()->twitterTimerTrigger,this,&testApp::twitterTimerGO);
    
}

void testApp::removeNavigationView(float &f){
    delete navigationview;
    navigationview = NULL;
     CDataModel::getInstance()->screenmode = VISUALIZER_SCREEN;
}

void testApp::twitterTimerGO(float &f) {
    if (twitterview==NULL) {
        twitterview = new CTwitterScreen();
        ofAddListener(twitterview->twitterScreenDone, this, &testApp::twitterScreenRemove);
        twitterview->setup();
    }
}

void  testApp::twitterScreenRemove(float &f) {
    ofRemoveListener(twitterview->twitterScreenDone, this, &testApp::twitterScreenRemove);
    delete twitterview;
    twitterview = NULL;
}

