//
//  CPLibrary.m
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#import "CPLibrary.h"
#include "CRandomGen.h"

static CPLibrary *sharedMyManager = nil;

@implementation CPLibrary


#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        
        
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

-(void) setup {
    library = [[ALAssetsLibrary alloc] init];
    allassets = [[NSMutableArray alloc]init];
    [self getPictureURLS];
}

-(void) getPictureURLS {
    
    ALAssetsGroupEnumerationResultsBlock assetEnumerator = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        
        if (result!=NULL) {
            
            [allassets addObject:result];
        }
    };
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultblock =^(ALAssetsGroup *group, BOOL *stop) {
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        [group enumerateAssetsUsingBlock:assetEnumerator];
        
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror){
        
    };
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:resultblock failureBlock:failureblock];
}


-(UIImage*) getRandomPicture {
    
    if ([allassets count]>0) {
    
    int val = CRandomGen::random_in_range_int(0, [allassets count]);
        
    ALAssetRepresentation *rep;
    
    rep = [[allassets objectAtIndex:val] defaultRepresentation];
    
    return [UIImage imageWithCGImage:[rep fullScreenImage]];
    }
    
    return NULL;
    
}

@end