//
//  CPhoneSelector.cpp
//  CircoNonNative
//
//  Created by Wim Vanhenden on 10/03/14.
//
//

#include "CDataModel.h"
#include "CRandomGen.h"


CDataModel* CDataModel::m_pSingleton = NULL;

CDataModel::CDataModel() {
}

CDataModel::~CDataModel() {
}

CDataModel* CDataModel::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CDataModel;
    return m_pSingleton;
}

void CDataModel::setup() {
    
    for (int i=0;i<28;++i) {
        //string mystring = "images/band/"+ofToString(i)+".png";
        string mystring = "images/band/"+ofToString(i)+".jpg";
        bandpicturespaths.push_back(mystring);
    }
    
    songtitles.push_back("S.A.M");
    songtitles.push_back("Nightfever");
    songtitles.push_back("Rejected");
    songtitles.push_back("One By One");
    songtitles.push_back("Never Wanted");
    songtitles.push_back("Dragon King");
    songtitles.push_back("Crazy Nights");
    songtitles.push_back("Broken");
    songtitles.push_back("Qui Je Suis");
    songtitles.push_back("Ambassador");
    
    
    songreferences.push_back("sam");
    songreferences.push_back("nightfever");
    songreferences.push_back("rejected");
    songreferences.push_back("onebyone");
    songreferences.push_back("neverwanted");
    songreferences.push_back("dragonking");
    songreferences.push_back("crazynights");
    songreferences.push_back("broken");
    songreferences.push_back("quijesuis");
    songreferences.push_back("ambassador");
    
    screenfadestep = 6.0f;
}

string CDataModel::getRandomBandPicture() {
    
    int output = CRandomGen::random_in_range_int(0, bandpicturespaths.size());
    string path = bandpicturespaths[output];
    
    return path;

}


