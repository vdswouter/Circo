//
//  CPhotoLibPicture.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CPhotoLibPicture.h"


void CPhotoLibPicture::setup() {
    bwshader.load("shaders/BWShader");
    
    contrastshader.load("shaders/ContrastShader");
    
    
    image.allocate(ofGetWidth(),ofGetHeight(),OF_IMAGE_COLOR_ALPHA);
    
    current.allocate(ofGetWidth(), ofGetHeight());
    
    contrastfbo.allocate(ofGetWidth(), ofGetHeight());

}

void CPhotoLibPicture::update() {
    

}

void CPhotoLibPicture::draw() {
  
}

bool CPhotoLibPicture::changeImage() {
   
    
    if (ofxiOSUIImageToOFImage([[CPLibrary sharedManager] getRandomPicture], image)) {
        
        contrastfbo.begin();
        contrastshader.begin();
        contrastshader.setUniform1f("contrast", 4);
        contrastshader.setUniform1f("alpha", 1);
        image.draw(0, 0, ofGetWidth(),ofGetHeight());
        contrastshader.end();
        contrastfbo.end();
        
        current.begin();
        bwshader.begin();
        bwshader.setUniform1f("alpha", 0.4);
        contrastfbo.draw(0, 0);
        bwshader.end();
        current.end();
        
        return true;
    }
    
    return false;
    
}