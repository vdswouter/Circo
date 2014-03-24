//
//  CPLibrary.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>


@interface CPLibrary : NSObject {
    ALAssetsLibrary *library;
    
    NSMutableArray *allassets;
    
}


-(void) setup;

-(void) getPictureURLS;

-(UIImage*) getRandomPicture;

+ (id)sharedManager;


@end