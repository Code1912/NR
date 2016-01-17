//
//  NSString+Z.h
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Z)
-(NSString *)trim;
-(BOOL) isNullOrEmpty;
-(BOOL) isNullOrWhiteSpaceEmpty;
+(NSString *) empty;
+(NSString *) format:(NSString*)format,...;
-(NSURL*) toURL;
-(NSURL*) toEncodeURL;
@end
