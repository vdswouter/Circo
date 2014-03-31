//
//  CBAndPicture.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CTwitterPicture.h"

#import "Reachability.h"



void CTwitterPicture::setup() {
    bwshader.load("shaders/BWShader");
    
    contrastshader.load("shaders/ContrastShader");
    
    current.allocate(ofGetWidth(), ofGetHeight());
    
    contrastfbo.allocate(ofGetWidth(), ofGetHeight());
    
}

void CTwitterPicture::update() {
    
    /*if(image.isAllocated()){
        if (!bisAllocated) {
            current.begin();
            contrastshader.begin();
            contrastshader.setUniform1f("contrast", 4);
            contrastshader.setUniform1f("alpha", 0.4);
            image.draw(0, 0, ofGetWidth(),ofGetHeight());
            contrastshader.end();
            current.end();
            
            float f = 0;
            ofNotifyEvent(twitterPictureLoaded,f,this);
            bisAllocated = true;
        }
    }*/
    
}

void CTwitterPicture::draw() {
    
    
}

bool CTwitterPicture::changeImage(string _path) {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable) {
        //No internet
        return false;
    }
    else if (status == ReachableViaWiFi) {
        //WiFi
        image.loadImage(_path);
        current.begin();
        contrastshader.begin();
        contrastshader.setUniform1f("contrast", 4);
        contrastshader.setUniform1f("alpha", 0.4);
        image.draw(0, 0, ofGetWidth(),ofGetHeight());
        contrastshader.end();
        current.end();
        return true;

    }
    else if (status == ReachableViaWWAN) 
    {
        return false;
        //3G
        //cout<<"3G"<<endl;
    }
    [reachability stopNotifier];
    /*
    //image.clear();
    image.loadImage(_path);
    //image.clear();
     bisAllocated = false;
    //loader.loadFromURL(image,_path);
   
    
     current.begin();
     contrastshader.begin();
     contrastshader.setUniform1f("contrast", 4);
     contrastshader.setUniform1f("alpha", 0.4);
     image.draw(0, 0, ofGetWidth(),ofGetHeight());
     contrastshader.end();
     current.end();
    
    */
    /*
     current.begin();
     bwshader.begin();
     bwshader.setUniform1f("alpha", 1);
     contrastfbo.draw(0, 0);
     bwshader.end();
     current.end();*/
}