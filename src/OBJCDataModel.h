//
//  OBJCDataModel.h
//  Circo
//
//  Created by Wim Vanhenden on 10/03/14.
//
//

#import <Foundation/Foundation.h>


@interface OBJCDataModel : NSObject {
    NSMutableArray *songs;
}

@property (nonatomic, retain) NSMutableArray *songs;

+ (id)sharedManager;

@end