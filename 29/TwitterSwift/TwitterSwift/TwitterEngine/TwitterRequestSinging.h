//
//  TwitterRequestSinging.h
//  TwitterEngine
//
//  Created by Luong Huy Duc on 26/11/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TwitterRequestSinging : NSObject

+ (void)signRequest:(NSMutableURLRequest *)request withToken:(NSString *)tokenString tokenSecret:(NSString *)tokenSecretString verifier:(NSString *)verifierString key:(NSString *)key secret:(NSString *)theSecret;

@end
