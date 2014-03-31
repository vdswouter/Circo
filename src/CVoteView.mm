#include "CVoteView.h"
#include "CDataModel.h"

#include "CVoteService.h"

void CVoteView::startTimer(float time) {
    starttime = ofGetElapsedTimeMillis();
    endtime = time;
    bTimerReached = false;
    bTimerIsRunning  =true;
    
}

void CVoteView::stopTimer() {
    bTimerReached = true;
    bTimerIsRunning  =false;
}

void CVoteView::startFadeOut() {
    if (!fadeout) {
        stopTimer();
        fadeout = true;
    }
}


void CVoteView::setHitAreasIphone4NonRetina() {
    
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
    
    xposvotenumber =360/2;
    yposvotenumber =190/2;
    
}

void CVoteView::setHitAreasIphone5NonRetina() {
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
    
    xposvotenumber =410/2;
    yposvotenumber =195/2;
    
}


void CVoteView::setup() {
    
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
        image.loadImage("images/votscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/votscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/votscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/votscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
    
    timertime = 10000.0f;
    startTimer(timertime);
    
    star.loadImage("images/starvote.png");
}

void CVoteView::update() {
    if (bTimerIsRunning) {
        
        int timer = ofGetElapsedTimeMillis() - starttime;
        if(timer >= endtime && !bTimerReached) {
            bTimerReached = true;
            bTimerIsRunning = false;
            startFadeOut();
        }
    }
}

void CVoteView::draw() {
    
    ofEnableAlphaBlending();
    if (fadein) {
        ofSetColor(255, 255, 254, fadeval);
        
        fadeval+=CDataModel::getInstance()->screenfadestep;
        
        if (fadeval>=255) {
            ofRegisterTouchEvents(this);
            fadeval= 255;
            fadein = false;
            float f=2.0f;
            ofNotifyEvent(viewReady, f, this);
        }
    }
    
    if (fadeout) {
        ofSetColor(255, 255, 254, fadeval);
        fadeval -=CDataModel::getInstance()->screenfadestep;
        if (fadeval<=0) {
            fadeval= 0;
            fadeout = false;
            ofUnregisterTouchEvents(this);
            float f=2.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    for (int i=0;i<[[[CPersistantData sharedManager] tempvotes]count];++i) {
        
        string incoming = string([[[[CPersistantData sharedManager] tempvotes] objectAtIndex:i] UTF8String]);
        
        if (incoming=="sam") {
            star.draw(sam.x-(65/2)+(70/2), sam.y-5, 65/2,60/2);
        }
        
        if (incoming=="nightfever") {
            star.draw(nightfever.x-(65/2)+(30/2), nightfever.y-3, 65/2,60/2);
        }
        
        if (incoming=="rejected") {
            star.draw(rejected.x-(65/2)+(45/2), rejected.y-3, 65/2,60/2);
        }
        
        if (incoming=="onebyone") {
            star.draw(onebyone.x-(65/2)+(30/2), onebyone.y-3, 65/2,60/2);
        }
        
        if (incoming=="neverwanted") {
            star.draw(neverwanted.x-(65/2), neverwanted.y-3, 65/2,60/2);
        }
        
        if (incoming=="dragonking") {
            star.draw(dragonking.x-(65/2)+(30/2), dragonking.y-3, 65/2,60/2);
        }
        
        if (incoming=="crazynights") {
            star.draw(crazynights.x-(65/2)+(20/2), crazynights.y-5, 65/2,60/2);
        }
        
        if (incoming=="broken") {
            star.draw(broken.x-(65/2)+(70/2), broken.y-5, 65/2,60/2);
        }
        
        if (incoming=="quijesuis") {
            star.draw(quijesuis.x-(65/2)+(30/2), quijesuis.y-5, 65/2,60/2);
        }
        
        if (incoming=="ambassador") {
            star.draw(ambassador.x-(65/2)+(20/2), ambassador.y-4, 65/2,60/2);
        }
    }
    
    ofSetColor(255, 200, 50, fadeval);
    
    int count = 5-[[[CPersistantData sharedManager] tempvotes]count];
    NCFontController::getInstance()->nanum24.drawString(ofToString(count), xposvotenumber, yposvotenumber);
    
    ofDisableAlphaBlending();
    
    /*ofRect(onebyone);
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


void CVoteView::touchDown(ofTouchEventArgs & touch) {
    
    if(sam.inside(touch.x, touch.y)) {
        
        stopTimer();
        startTimer(timertime);
        
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"sam")) {
                if (CVoteService::getInstance()->doVote(0)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"sam"];
                } else {
                 
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                    message:@"No internets, No vote for you!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
            
        }
    } else if (nightfever.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"nightfever")) {
                if (CVoteService::getInstance()->doVote(1)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"nightfever"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
        
    } else if (rejected.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"rejected")) {
                if (CVoteService::getInstance()->doVote(2)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"rejected"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (onebyone.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"onebyone")) {
                if (CVoteService::getInstance()->doVote(3)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"onebyone"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (neverwanted.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"neverwanted")) {
                if (CVoteService::getInstance()->doVote(4)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"neverwanted"];
                }
            }
        }
        
    } else if (dragonking.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"dragonking")) {
                if (CVoteService::getInstance()->doVote(5)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"dragonking"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (crazynights.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"crazynights")) {
                if (CVoteService::getInstance()->doVote(6)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"crazynights"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (broken.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"broken")) {
                if (CVoteService::getInstance()->doVote(7)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"broken"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (quijesuis.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"quijesuis")) {
                if (CVoteService::getInstance()->doVote(8)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"quijesuis"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (ambassador.inside(touch.x, touch.y)) {
        stopTimer();
        startTimer(timertime);
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
            if (!checkifVoteIsClicked(@"ambassador")) {
                if (CVoteService::getInstance()->doVote(9)) {
                    [[[CPersistantData sharedManager] tempvotes] addObject:@"ambassador"];
                }else {
                    
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"OOPS"
                                                                     message:@"No internets, No vote for you!"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease];
                    [alert show];
                }
            }
        }
        
    } else if (closecross.inside(touch.x, touch.y)) {
        startFadeOut();
    }
    
    [[CPersistantData sharedManager] saveData];
    
}

bool CVoteView::checkifVoteIsClicked(NSString *_incoming) {
    
    [[[CPersistantData sharedManager] tempvotes] count];
    
    for (int i =0; i< [[[CPersistantData sharedManager] tempvotes] count]; ++i) {
        
        //NSLog(@"%@",[[[CPersistantData sharedManager] tempvotes]objectAtIndex:i]);
        
        if ([[[[CPersistantData sharedManager] tempvotes]objectAtIndex:i] isEqualToString:_incoming]) {
            return true;
        }
        
    }
    
    return false;
}

void CVoteView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchUp(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchCancelled(ofTouchEventArgs & touch) {
    
}