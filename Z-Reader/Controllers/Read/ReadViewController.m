//
//  ReadViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/27.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    this.rootView.backgroundColor = [UIColor colorWithPatternImage:[UserSetting imgWithName:@"readback"]];
    this.navigationController.navigationBar.hidden=YES;
    this.webView.delegate=this;
    [this.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle]URLForResource:@"content" withExtension:@"html" subdirectory:@"Web"]]];
    // Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [this.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"utility" withExtension:@"js" subdirectory:@"Web"] encoding:NSUTF8StringEncoding error:nil]];

    [this callJSFunc:@"updateContent" withArgs:@"123123"];
   // NSString  * path=[UserSetting imgPathWithName:@"readback" ofType:@"png"];
    //NSLog(path);
    //[this callJSFunc:@"setBackground" withArgs:path];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 说明协议头是ios
    if ([@"ios" isEqualToString:request.URL.scheme]) {
        NSString *url = request.URL.absoluteString;
        NSRange startRange = [url rangeOfString:@":"];
        NSRange endRange =[url rangeOfString:@"?"];
        NSUInteger length= endRange.length==0?(url.length-startRange.location-1):(endRange.location-1-startRange.location);
        NSRange methodRang=NSMakeRange(startRange.location+1,length);
        NSString *method = [request.URL.absoluteString substringWithRange:methodRang];


        NSMutableDictionary * args= [url getUrlArgs];
        if([method isEqualToString:@"test"])
        {
            [this test:args];
        }

        return NO;
    }

    return YES;
}

-(void)callJSFunc:(NSString *)funcName withArgs:(NSString * )args {

  //  NSLog([[NSString alloc]
   ////         initWithFormat:@"callFunc('%@','%@');", funcName, args]);
    NSString *path = [this.webView stringByEvaluatingJavaScriptFromString:[[NSString alloc]
            initWithFormat:@"callFunc('%@','%@');", funcName, args]];
     NSLog(@"%@",path);
}
-(void)test:(NSMutableDictionary<NSString*,NSString*> *) args{
    for (NSString* key in args) {
     //   NSLog([args objectForKey:key]);
    }
   // NSLog(@"ddddd");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnBack_Click
{
    [this.navigationController popViewControllerAnimated:YES];
    this.navigationController.navigationBar.hidden=NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
