//
//  CBAndPicture.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CBAndPicture.h"

void CBAndPicture::setup() {
    bwshader.load("shaders/BWShader");
    
    contrastshader.load("shaders/ContrastShader");
    
    
    image.allocate(ofGetWidth(),ofGetHeight(),OF_IMAGE_COLOR_ALPHA);
    
    current.allocate(ofGetWidth(), ofGetHeight());
    
    contrastfbo.allocate(ofGetWidth(), ofGetHeight());

}

void CBAndPicture::update() {
    
}

void CBAndPicture::draw() {
    
}

void CBAndPicture::changeImage() {
    

    //image.clear();
    string path = CDataModel::getInstance()->getRandomBandPicture();
    image.loadImage(path);
    
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
    
    /*current.begin();
    image.draw(0, 0, ofGetWidth(), ofGetHeight());
    current.end();*/
    
}