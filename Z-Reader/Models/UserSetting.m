//
//  UserSetting.m
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "UserSetting.h"

@implementation UserSetting
static UserSetting* intance=nil;
-(instancetype)init
{
    if(self=[super init])
    {
        self.mainColor=[[UIColor new] initWithRed:71/255.0 green:179/255.0 blue:168/255.0 alpha:1];
        self.backColor=[UIColor whiteColor];
        self.titleColor=[[UIColor new]initWithRed:51/255.0 green:51/255.0  blue:51/255.0  alpha:1];
        self.contentColor=[[UIColor new]initWithRed:102/255.0 green:102/255.0  blue:102/255.0  alpha:1];
        self.headerFontSize=17;
        self.titleFontSize=12;
        self.contentFontSize=10;
        self.isNightMode=false;
        self.theme=@"Day";
    }
    return self;
}
+(UserSetting *)getIntance
{
    if(intance==nil)
    {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            if(intance!=nil)
            {
                return ;
            }
            intance=[[UserSetting new]init];
            NSMutableArray<UserSetting*>* array = [UserSetting searchWithWhere:@"" orderBy:@"" offset:0 count:100];
            if(array==nil||array.count==0)
            {
                
                
            }
            else
            {
                UserSetting* temp= array[0];
                intance.mainColor=temp.mainColor;
                if(temp.titleColor)
                {
                intance.titleColor=temp.titleColor;
                }
                intance.headerFontSize=temp.headerFontSize;
                intance.titleFontSize=temp.titleFontSize;
                intance.contentFontSize=temp.contentFontSize;
                intance.isNightMode=temp.isNightMode;
                intance.backColor=temp.backColor;
                intance.theme=temp.theme;
                if(intance.theme==nil)
                {
                    intance.theme=@"Day";
                }
            }
            [intance deleteToDB];
            [intance saveToDB];
        });
    }
    return intance;
}

+(void)save
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeNotifier object:nil];
    [intance deleteToDB];
    [intance saveToDB];
}

+(UIImage*) imgWithName:(NSString *)name ofType:(NSString* __nullable)ext;
{
    if (!name || [name isNullOrWhiteSpaceEmpty]) {
        return nil;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext inDirectory:[NSString stringWithFormat:@"Theme/%@",[UserSetting getIntance].theme]];
    UIImage *img= [UIImage imageWithContentsOfFile:path];
    return img;
}
+(UIImageView*) imgViewWithName:(NSString *)name ofType:(NSString* __nullable)ext;
{
    UIImageView  *imgView=[[UIImageView new]init];
    imgView.image= [UserSetting imgWithName:name ofType:ext];
    return imgView;
}

+(UIImage*) imgWithName:(NSString *)name
{
    return  [UserSetting imgWithName:name ofType:@"png"  ];
}

+(UIImageView*) imgViewWithName:(NSString *)name
{
    return  [UserSetting imgViewWithName:name ofType:@"png" ];
}

+(NSString*) imgPathWithName:(NSString *)name ofType:(NSString* __nullable)ext
{
    if (!name || [name isNullOrWhiteSpaceEmpty]) {
        return nil;
    }
    if(!ext)
    {
        ext=@"png";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext inDirectory:[NSString stringWithFormat:@"Theme/%@",[UserSetting getIntance].theme]];
    return path;
}

 
@end
