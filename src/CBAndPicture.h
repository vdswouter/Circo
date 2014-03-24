//
//  CBAndPicture.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "CDataModel.h"

class CBAndPicture {
    
private:
    ofImage image;
    ofFbo contrastfbo;
    ofShader    bwshader;
    ofShader    contrastshader;
    
    
public:
    
    
    
    ofFbo current;
    void changeImage();
    void setup();
    void update();
    void draw();

};