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


class CTwitterPicture {
    
private:
    ofImage image;
    
    ofFbo       contrastfbo;
    ofShader    bwshader;
    ofShader    contrastshader;
    
public:
    
    ofFbo current;
    void setup();
    void update();
    void draw();
    void changeImage(string _path);
    
};