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
    this.webView.scrollView.bounces=NO;
    [this.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle]URLForResource:@"content" withExtension:@"html" subdirectory:@"Web"]]];
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // [this.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"utility" withExtension:@"js" subdirectory:@"Web"] encoding:NSUTF8StringEncoding error:nil]];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"txt" subdirectory:@"Web"];
    NSString *myString = [NSString stringWithContentsOfURL:url usedEncoding:NULL error:NULL];
    [this callJSFunc:@"updateContent" withArgs:myString];

    this.webView.scrollView.bounces = NO;
    this.webView.scrollView.scrollEnabled = false;
    this.webView.scrollView.showsHorizontalScrollIndicator = false;
    this.webView.scrollView.showsVerticalScrollIndicator = false;

    [this callJSFunc:@"setProperty" withArgs:[NSString stringWithFormat:@"readColor=%ld", [UserSetting getIntance].readColor]];
    [this callJSFunc:@"setProperty" withArgs:[NSString stringWithFormat:@"readSize=%ld", [UserSetting getIntance].readSize]];
    [this callJSFunc:@"setProperty" withArgs:[NSString stringWithFormat:@"downCount=%ld", [UserSetting getIntance].downCount]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([@"ios" isEqualToString:request.URL.scheme]) {
        NSString *url = request.URL.absoluteString;
        NSRange startRange = [url rangeOfString:@":"];
        NSRange endRange = [url rangeOfString:@"?"];
        NSUInteger length = endRange.length == 0 ? (url.length - startRange.location - 1) : (endRange.location - 1 - startRange.location);
        NSRange methodRang = NSMakeRange(startRange.location + 1, length);
        NSString *method = [request.URL.absoluteString substringWithRange:methodRang];


        NSMutableDictionary *args = [url getUrlArgs];
        if ([method isEqualToString:@"test"]) {
            [this test:args];
        }
        if ([method isEqualToString:@"log"]) {
            [this log:args];
        }
        if ([method isEqualToString:@"back"]) {
            [this backToMain];
        }
        if ([method isEqualToString:@"property"]) {
            [this setProperty:args];
        }
        if ([method isEqualToString:@"list"]) {
            [this showChapterList];
        }
        return NO;
    }
    return YES;
}
-(void)showChapterList{
    if (self.navigationController.visibleViewController == self) {
        
        [self performSegueWithIdentifier:@"ToChapterList" sender:self];
    }
}

- (void)backToMain {
    [this.navigationController popViewControllerAnimated:YES];
    this.navigationController.navigationBar.hidden = NO;
}

-(void)callJSFunc:(NSString *)funcName withArgs:(NSString * )args {

    NSString *callStr = [[NSString alloc]
            initWithFormat:@"callFunc(\"%@\",\"%@\");", funcName, args];

    NSString *path = [this.webView stringByEvaluatingJavaScriptFromString:callStr];
    NSLog(@"%@", path);
}

-(void)setProperty:(NSMutableDictionary<NSString*,NSString*> *)args {
    for (NSString *key in args) {
        if ([key isEqualToString:@"readColor"]);
        {
            [UserSetting getIntance].readColor= [[args objectForKey:key] intValue];

        }
        if ([key isEqualToString:@"readSize"]);
        {
            [UserSetting getIntance].readSize= [[args objectForKey:key] intValue];
        }
    }
    [[UserSetting getIntance] saveToDB];
}

-(void)log:(NSMutableDictionary<NSString*,NSString*> *) args{
    for (NSString* key in args) {
        NSLog([args objectForKey:key]);
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ToChapterList"]) {
        ChapterListViewController *controller = (ChapterListViewController *)[segue destinationViewController] ;
        controller.book=this.book;
    }
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
