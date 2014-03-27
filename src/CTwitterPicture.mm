//
//  CBAndPicture.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CTwitterPicture.h"



void CTwitterPicture::setup() {
    bwshader.load("shaders/BWShader");
    
    contrastshader.load("shaders/ContrastShader");
    
    current.allocate(ofGetWidth(), ofGetHeight());
    
    contrastfbo.allocate(ofGetWidth(), ofGetHeight());
    
    bisAllocated = false;
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

void CTwitterPicture::changeImage(string _path) {
    
    
    
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
    
    
    /*
     current.begin();
     bwshader.begin();
     bwshader.setUniform1f("alpha", 1);
     contrastfbo.draw(0, 0);
     bwshader.end();
     current.end();*/
}