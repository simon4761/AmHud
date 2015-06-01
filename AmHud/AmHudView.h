//
//  AmHudView.h
//  AmHud
//
//  Created by Aimeow on 6/1/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmHudView : UIView

#define IMAGE_SIZE 28
#define HUD_NORMAL_SIZE 75
#define HUD_MAX_WIDTH 200
#define HUD_MIN_WIDTH 75


//没有设置图片和文字则HUD中显示菊花
//只有设置图片则HUD中只显示图片
//只有设置主文字则HUD中只显示contentLabel
//只有设置主文字和辅文字，则HUD中上下显示contentLabel及detailLabel;
//HUD图片尺寸要求28x28
- (void)am_setHudImageView : (NSString *)fileName;
- (void)am_setContent : (NSString *)content;

//设置HUD的文字颜色以及HUD的背景颜色
- (void)am_setHudBackgroundColor : (UIColor *)color;
- (void)am_setHudTextColor : (UIColor *)color;
- (void)am_setHudTextFont : (UIFont *)font;

//必须调用
- (void)layout;

@end