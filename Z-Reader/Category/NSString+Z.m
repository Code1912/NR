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

-(NSString *) concat:(NSString *)str
{
    return [NSString stringWithFormat:@"%@%@",self,str];
}

-(NSMutableDictionary<NSString *, NSString*> *) getUrlArgs{
    NSMutableDictionary<NSString *, NSString*> *arrayData = [NSMutableDictionary new];
        NSRange range = [self rangeOfString:@"?"];

        NSString *propertys = [self substringFromIndex:(int)(range.location+1)];

        NSArray *subArray = [propertys componentsSeparatedByString:@"&"];

        for(int j = 0 ; j < subArray.count; j++)
        {
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
           if(dicArray.count>1)
           {
            [arrayData setObject:dicArray[1] forKey:dicArray[0]];
           }
        }
    return arrayData;
}
@end
