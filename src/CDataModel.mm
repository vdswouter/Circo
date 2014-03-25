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
}

string CDataModel::getRandomBandPicture() {
    
    int output = CRandomGen::random_in_range_int(0, bandpicturespaths.size());
    string path = bandpicturespaths[output];
    
    return path;

}


