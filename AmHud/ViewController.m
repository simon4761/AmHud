//
//  ViewController.m
//  AmHud
//
//  Created by Aimeow on 6/1/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "ViewController.h"
#import "AmHud.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)doShowHudProgress:(id)sender
{
    //当值为NO时，可以点击屏幕，如果为YES，则不可点击屏幕
    [AmHud showWithProgress:NO];
}

- (IBAction)doShowHudText:(id)sender
{
    //限制了高度，不能无限变长
    [AmHud showWithContent:@"文字是记录信息的图像符号。错误观点：文字是记录语言的符号。"];
}

- (IBAction)dismiss:(id)sender
{
    [AmHud dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
