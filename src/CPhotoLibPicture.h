//
//  CPhotoLibPicture.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once 

#include "ofMain.h"
#include "CPLibrary.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

class CPhotoLibPicture {
    
public:
    
    
     ofFbo current;
    void setup();
    void update();
    void draw();
    bool changeImage();
    
    
private:
    
    ofImage image;
  
    ofFbo       contrastfbo;
    ofShader    bwshader;
    ofShader    contrastshader;
    
};