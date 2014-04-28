//
//  CBGContainer.cpp
//  Circo
//
//  Created by Wim Vanhenden on 30/03/14.
//
//

#include "CBGContainer.h"

#include "CRandomGen.h"

void CBGContainer::setup() {
    fadeshader.load("shaders/FadeShader");
    bandpicture.setup();
    libpicture.setup();
    twitterpicture.setup();
    bisActive = false;
    
}

void CBGContainer::update() {
    
    if (bisActive) {
        
        if (bDoTransitionIn && !bDoTransitionOut) {
            fadeIn();
        }  else if (!bDoTransitionIn && bDoTransitionOut) {
            fadeOut();
        }
    }
}

void CBGContainer::draw() {
    
    if (bisActive) {
        enlargerval+=0.1;
        ofEnableAlphaBlending();
        fadeshader.begin();
        fadeshader.setUniform1f("alpha", fadeval);
        image->draw(-enlargerval, -enlargerval, (float)ofGetWidth()+enlargerval,(float)ofGetHeight()+enlargerval);
        fadeshader.end();
        ofDisableAlphaBlending();
    }
}

void CBGContainer::fadeIn() {
    fadeval+=0.003;
    if (fadeval>=0.4) {
        fadeval = 0.4;
        bDoTransitionIn = false;
    }
}


void CBGContainer::fadeOut() {
    fadeval-=0.003;
    if (fadeval<=0) {
        fadeval = 0;
        bisActive = false;
        bDoTransitionOut = false;
    }
}

void CBGContainer::startFadeIn() {
    fadeval = 0;
    enlargerval =0;
    bisActive = true;
    bDoTransitionIn = true;
    bDoTransitionOut = false;
    int decider = CRandomGen::random_in_range_int(0, 101);
    if (decider>-1) {
        bandpicture.changeImage();
        image = &bandpicture.current;
    } else {
        
        if (libpicture.changeImage()) {
            image = &libpicture.current;
        } else {
            bandpicture.changeImage();
            image = &bandpicture.current;
        }
    }
}

void CBGContainer::startFadeOut() {
    fadeval  = 0.4;
    bDoTransitionIn = false;
    bDoTransitionOut = true;
}


void CBGContainer::insertTweetPicture(string _path) {
    if (twitterpicture.changeImage(_path)) {
        image = &twitterpicture.current;
    }
}
