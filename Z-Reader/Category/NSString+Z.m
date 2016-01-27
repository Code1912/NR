//
//  NSString+Z.m
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "NSString+Z.h"

@implementation NSString(Z)
-(NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL) isNullOrEmpty
{
    
    return  self==nil||[self isEqualToString:[NSString empty]];
}

-(BOOL) isNullOrWhiteSpaceEmpty
{
     return self==nil||[[self trim] isEqualToString:[NSString empty]];
}
+(BOOL) isNullOrEmpty:(NSString *)str
{
      return  str==nil||[str isEqualToString:[NSString empty]];
}
+(BOOL) isNullOrWhiteSpaceEmpty:(NSString *)str;
{
    return str==nil||[[str trim] isEqualToString:[NSString empty]];
}
-(NSURL*) toURL
{
    return  [NSURL URLWithString:self];
}
-(NSURL*) toEncodeURL;
{
    NSString *encodedString=[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return  [NSURL URLWithString:encodedString];
}

+(NSString *) empty
{
    return  @"";
}
+(NSString *) format:(NSString*)format,...
{
    va_list args;
    va_start(args, format);
    NSString* str=   [ [NSString new]initWithFormat:format,args ];
    va_end(args);
    return str;
}
-(NSString *) concat:(NSString *)str
{
    return [NSString stringWithFormat:@"%@%@",self,str];
}
 
@end
