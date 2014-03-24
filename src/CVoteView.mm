#include "CVoteView.h"

void CVoteView::setHitAreasIphone4NonRetina() {
    
    sam.x = 120/2;
    sam.y = 280/2;
    
    nightfever.x = 120/2;
    nightfever.y = 351/2;
    
    rejected.x = 120/2;
    rejected.y = 425/2;
    
    onebyone.x = 120/2;
    onebyone.y = 500/2;
    
    neverwanted.x = 120/2;
    neverwanted.y = 570/2;
    
    dragonking.x = 550/2;
    dragonking.y = 280/2;
    
    crazynights.x = 550/2;
    crazynights.y = 351/2;
    
    broken.x = 550/2;
    broken.y = 425/2;
    
    quijesuis.x = 550/2;
    quijesuis.y = 500/2;
    
    ambassador.x = 550/2;
    ambassador.y = 570/2;
    
    closecross.x = 870/2;
    closecross.y = 10/2;

   
}

void CVoteView::setHitAreasIphone5NonRetina() {
    sam.x = 142/2;
    sam.y = 270/2;
    
    nightfever.x = 142/2;
    nightfever.y = 345/2;
    
    rejected.x = 142/2;
    rejected.y = 415/2;
    
    onebyone.x = 142/2;
    onebyone.y = 490/2;
    
    neverwanted.x = 142/2;
    neverwanted.y = 560/2;
    
    dragonking.x = 600/2;
    dragonking.y = 272/2;
    
    crazynights.x = 600/2;
    crazynights.y = 345/2;
    
    broken.x = 600/2;
    broken.y = 420/2;
    
    quijesuis.x = 600/2;
    quijesuis.y = 490/2;
    
    ambassador.x = 600/2;
    ambassador.y = 560/2;

    closecross.x = 1035/2;
    closecross.y = 25/2;
   
}


void CVoteView::setup() {
    
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
    
    star.loadImage("images/starvote.png");
}

void CVoteView::update() {
    
}

void CVoteView::draw() {
    
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
            float f=2.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    
    for (int i=0;i<[[[CPersistantData sharedManager] tempvotes]count];++i) {
        
        
       string incoming = string([[[[CPersistantData sharedManager] tempvotes] objectAtIndex:i] UTF8String]);
        
        
        if (incoming=="sam") {
             star.draw(sam.x-(65/2), sam.y-6, 65/2,60/2);
        }
        
        if (incoming=="nightfever") {
            star.draw(nightfever.x-(65/2), nightfever.y-6, 65/2,60/2);
        }
        
        if (incoming=="rejected") {
            star.draw(rejected.x-(65/2), rejected.y-6, 65/2,60/2);
        }
        
        if (incoming=="onebyone") {
            star.draw(onebyone.x-(65/2), onebyone.y-6, 65/2,60/2);
        }
        
        if (incoming=="neverwanted") {
            star.draw(neverwanted.x-(65/2), neverwanted.y-6, 65/2,60/2);
        }
        
        if (incoming=="dragonking") {
            star.draw(dragonking.x-(65/2), dragonking.y-6, 65/2,60/2);
        }
        
        if (incoming=="crazynights") {
            star.draw(crazynights.x-(65/2), crazynights.y-6, 65/2,60/2);
        }
        
        if (incoming=="broken") {
            star.draw(broken.x-(65/2), broken.y-6, 65/2,60/2);
        }
        
        if (incoming=="quijesuis") {
            star.draw(quijesuis.x-(65/2), quijesuis.y-6, 65/2,60/2);
        }
        
        if (incoming=="ambassador") {
            star.draw(ambassador.x-(65/2), ambassador.y-6, 65/2,60/2);
        }

        
    }
    
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
        
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
        
        [[[CPersistantData sharedManager] tempvotes] addObject:@"sam"];
            
        }
    } else if (nightfever.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
        [[[CPersistantData sharedManager] tempvotes] addObject:@"nightfever"];
         }

        
    } else if (rejected.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
         [[[CPersistantData sharedManager] tempvotes] addObject:@"rejected"];
         }
        
    } else if (onebyone.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
         [[[CPersistantData sharedManager] tempvotes] addObject:@"onebyone"];
         }
        
    } else if (neverwanted.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
         [[[CPersistantData sharedManager] tempvotes] addObject:@"neverwanted"];
         }
        
    } else if (dragonking.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
          [[[CPersistantData sharedManager] tempvotes] addObject:@"dragonking"];
         }
        
    } else if (crazynights.inside(touch.x, touch.y)) {
          if([[[CPersistantData sharedManager] tempvotes] count]<5) {
          [[[CPersistantData sharedManager] tempvotes] addObject:@"crazynights"];
          }
        
    } else if (broken.inside(touch.x, touch.y)) {
         if([[[CPersistantData sharedManager] tempvotes] count]<5) {
         [[[CPersistantData sharedManager] tempvotes] addObject:@"broken"];
         }
        
    } else if (quijesuis.inside(touch.x, touch.y)) {
          if([[[CPersistantData sharedManager] tempvotes] count]<5) {
          [[[CPersistantData sharedManager] tempvotes] addObject:@"quijesuis"];
          }
        
    } else if (ambassador.inside(touch.x, touch.y)) {
        if([[[CPersistantData sharedManager] tempvotes] count]<5) {
         [[[CPersistantData sharedManager] tempvotes] addObject:@"ambassador"];
        }   
        
    } else if (closecross.inside(touch.x, touch.y)) {
        if (!fadeout) {
            fadeout = true;
        }
    } else {
        
    }
    
     [[CPersistantData sharedManager] saveData];

}
void CVoteView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchUp(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CVoteView::touchCancelled(ofTouchEventArgs & touch) {
    
}