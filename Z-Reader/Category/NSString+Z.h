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

-(NSURL*) toURL;
-(NSURL*) toEncodeURL;
-(NSString *) concat:(NSString *)str;
+(BOOL) isNullOrEmpty:(NSString *)str;
+(BOOL) isNullOrWhiteSpaceEmpty:(NSString *)str;
-(NSMutableDictionary<NSString *, NSString*> *) getUrlArgs;
@end
