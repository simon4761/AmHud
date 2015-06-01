//
//  AmHudView.m
//  AmHud
//
//  Created by Aimeow on 6/1/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "AmHudView.h"
#import "UIView+frame.h"

@interface AmHudView(){
    
}
//显示优先级1,imageview , 2 , contentLabel , 3 . detailLabel
@property (strong , nonatomic) UIImageView *hudImageView;
@property (strong , nonatomic) UILabel *hudContentLabel;

@property (strong , nonatomic) UIActivityIndicatorView *spinner;

@property (nonatomic) UIColor *hud_fontColor;
@property (nonatomic) UIColor *hud_backgroundColor;
@property (nonatomic) UIFont *font;

@end

@implementation AmHudView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hudImageView = nil;
        _hudContentLabel = nil;
        
        _hud_fontColor = [UIColor whiteColor];
        _hud_backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _font = [UIFont systemFontOfSize:12];
        
        //        self.layer.borderColor = [ZAUtil colorwithHexString:@"#ffffff" alpha:0.2].CGColor;
        //        self.layer.borderWidth = 0.5;
        [self layout];
        
    }
    return self;
}

- (void)am_setHudImageView : (NSString *)fileName
{
    if(![fileName isEqualToString:@""] && fileName != nil)
        [self.hudImageView setImage:[UIImage imageNamed:fileName]];
    [self layout];
}

- (void)am_setContent : (NSString *)content
{
    if(![content isEqualToString:@""] && content != nil)
    {
        self.hudContentLabel.text = content;
        CGSize labelSize = [content sizeWithFont:_font
                               constrainedToSize:CGSizeMake(HUD_MAX_WIDTH , 100)
                                   lineBreakMode:NSLineBreakByCharWrapping];
        
        self.hudContentLabel.height = labelSize.height;
        self.hudContentLabel.width = labelSize.width;
    }
    [self layout];
    
}


- (void)am_setHudBackgroundColor : (UIColor *)color
{
    _hud_backgroundColor = color;
}
- (void)am_setHudTextColor : (UIColor *)color
{
    _hud_fontColor = color;
}

- (void)am_setHudTextFont : (UIFont *)font
{
    _font = font;
}

- (void)layout{
    //当都为空时，显示无限菊花
    
    [_hudContentLabel removeFromSuperview];
    [_hudImageView removeFromSuperview];
    [_spinner removeFromSuperview];
    
    if((_hudImageView == nil)  && (_hudContentLabel == nil))
    {
        
        [self addSubview:self.spinner];
        [_spinner startAnimating];
        
        self.height = self.width = HUD_NORMAL_SIZE;
        
        //设置菊花的X,Y坐标
        _spinner.top = self.height/2 - _spinner.height/2;
        _spinner.left = self.width/2 - _spinner.width / 2;
    }
    //当只有图片时，则只显示图片
    else if ( _hudContentLabel == nil && _hudImageView != nil)
    {
        [self addSubview:_hudImageView];
        
        self.height = self.width = HUD_NORMAL_SIZE;
        _hudImageView.top = self.height/2 - _hudImageView.height/2;
        _hudImageView.left = self.width/2 - _hudImageView.width / 2;
    }
    //当只有主文字时，则只显示contentLabel
    else if (_hudImageView == nil && _hudContentLabel != nil )
    {
        [self addSubview:_hudContentLabel];
        
        self.height = 50;
        self.width = _hudContentLabel.width + 30;
        _hudContentLabel.left = 15;
        _hudContentLabel.top = self.height/2 - _hudContentLabel.height/2;
    }
    else if (_hudImageView != nil && _hudContentLabel != nil )
    {
        [self addSubview:_hudImageView];
        [self addSubview:_hudContentLabel];
        
        self.height = HUD_NORMAL_SIZE - 10;
        self.width = (_hudContentLabel.width > _hudImageView.width)?_hudContentLabel.width+40:_hudImageView.width+40;
        _hudContentLabel.left = self.width/2 - _hudContentLabel.width/2;
        _hudImageView.left = self.width/2 - _hudImageView.width/2;
        
        _hudImageView.top = 8;
        _hudContentLabel.bottom = self.bottom -8;
        
    }
    
    self.layer.cornerRadius = 5;
    self.backgroundColor = _hud_backgroundColor;
}


- (UIImageView *)hudImageView
{
    if(_hudImageView == nil)
    {
        _hudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMAGE_SIZE, IMAGE_SIZE)];
        
    }
    return _hudImageView;
}

- (UIActivityIndicatorView *) spinner
{
    if (_spinner == nil)
    {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.color = _hud_fontColor;
        _spinner.hidesWhenStopped = YES;
    }
    return _spinner;
}

- (UILabel *)hudContentLabel{
    if(_hudContentLabel == nil)
    {
        _hudContentLabel = UILabel.new;
        [_hudContentLabel setTextColor:_hud_fontColor];
        _hudContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _hudContentLabel.font = _font;
        _hudContentLabel.textAlignment = NSTextAlignmentCenter;
        _hudContentLabel.numberOfLines = 0;
        _hudContentLabel.backgroundColor = [UIColor clearColor];
    }
    return _hudContentLabel;
}

@end
