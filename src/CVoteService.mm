//
//  CVoteService.cpp
//  Circo
//
//  Created by Wim Vanhenden on 30/03/14.
//
//

#include "CVoteService.h"



CVoteService* CVoteService::m_pSingleton = NULL;

CVoteService::CVoteService() {
    
}

CVoteService::~CVoteService() { }


CVoteService* CVoteService::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CVoteService;
    
    return m_pSingleton;
}

bool CVoteService::doVote(int songnumber) {
    
    std::stringstream url;
    url << "http://demo.littlemissrobot.com:2346/vote/" << songnumber;
	// Now parse the JSON
    
	bool parsingSuccessful = result.open(url.str());
    
	if (parsingSuccessful) {
        return true;
	} else {
        return false;
	}
    
    return false;
}