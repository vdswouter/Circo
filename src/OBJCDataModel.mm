//
//  OBJCDataModel.m
//  Circo
//
//  Created by Wim Vanhenden on 10/03/14.
//
//

#import "OBJCDataModel.h"


static OBJCDataModel *sharedMyManager = nil;

@implementation OBJCDataModel

@synthesize songs;

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
        songs  =[[NSMutableArray alloc] initWithObjects:@"sound/Sam",@"sound/Nightfever",@"sound/Rejected",@"sound/One By One",@"sound/Never Wanted",@"sound/Dragon King",@"sound/Crazy Nights",@"sound/Broken",@"sound/Qui Je Suis",@"sound/Ambassador", nil];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [songs release];
    [super dealloc];
}

@end