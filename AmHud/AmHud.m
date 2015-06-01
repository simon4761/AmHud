//
//  AmHud.m
//  AmHud
//
//  Created by Aimeow on 6/1/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "AmHud.h"
#import "AmHudView.h"
#import "UIView+frame.h"

@interface AmHud()

@property (atomic, strong) UIWindow *window;
@property (strong , nonatomic) UIControl *overlayView;
@property (strong , nonatomic) AmHudView *hudView;
@property (nonatomic, readonly) CGFloat visibleKeyboardHeight;
@property (nonatomic) BOOL isClear;
@property (nonatomic) NSTimer *timer;

@end

@implementation AmHud
@synthesize hudView;
@synthesize window;

+ (void)showWithContent:(NSString *)content
{
    [[AmHud sharedInstance] showWithContent:content];
}

+ (void)showWithContent:(NSString *)content withTime:(float)time
{
    [[AmHud sharedInstance] showWithContent:content withTime:time];
}

+ (void)showWithImage:(NSString *)imageName
{
    [[AmHud sharedInstance] showWithImage:imageName];
}

+ (void)showWithImage:(NSString *)imageName withContent:(NSString *)content
{
    [[AmHud sharedInstance] showWithImage:imageName withContent:content];
}

+ (void)showWithImage : (NSString *)imageName withContent : (NSString *)content withTime : (float)time
{
    [[AmHud sharedInstance] showWithImage:imageName withContent:content withTime:time];
}


+ (void)showWithProgress:(BOOL)isLock
{
    [[AmHud sharedInstance] showWithProgress:isLock];
}

+ (void)dismiss
{
    [[AmHud sharedInstance] dismiss];
}

+ (AmHud *)sharedInstance {
    static dispatch_once_t once;
    static AmHud *sharedView;
    dispatch_once(&once, ^ { sharedView = [[AmHud alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate respondsToSelector:@selector(window)])
            window = [delegate performSelector:@selector(window)];
        else
            window = [[UIApplication sharedApplication] keyWindow];
        
        self.alpha = 0;
        _isClear = YES;
    }
    return self;
}


- (void)showWithContent:(NSString *)content
{
    if([content isKindOfClass:[NSString class]]){
        if(![content isEqualToString:@""])
            [self showWithImage:nil withContent:content withTime:HUD_SHOW_TIME];
    }
}

- (void)showWithContent:(NSString *)content withTime:(float)time
{
    if(![content isEqualToString:@""])
        [self showWithImage:nil withContent:content withTime:time];
}



- (void)showWithImage:(NSString *)imageName
{
    if(![imageName isEqualToString:@""])
        [self showWithImage:imageName withContent:nil withTime:HUD_SHOW_TIME];
}

- (void)showWithImage:(NSString *)imageName withContent:(NSString *)content
{
    if(![imageName isEqualToString:@""] && ![content isEqualToString:@""])
        [self showWithImage:imageName withContent:content withTime:HUD_SHOW_TIME];
}

- (void)showWithProgress:(BOOL)isLock
{
    _isClear = !isLock;
    [self showWithImage:nil withContent:nil withTime:-1];
}

- (void)showWithImage : (NSString *)imageName withContent : (NSString *)content withTime : (float)time
{
    [AmHud cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    
    [self.hudView removeFromSuperview];
    self.hudView = nil;
    
    if(!_isClear) {
        [window addSubview:self.overlayView];
        self.overlayView.userInteractionEnabled = YES;
    }
    
    [window addSubview:self.hudView];
    
    [self.hudView am_setHudImageView:imageName];
    [self.hudView am_setContent:content];
    
    self.hudView.top = window.height / 2 - self.hudView.height/2;
    self.hudView.left = window.width / 2 - self.hudView.width/2;
    
    self.alpha =0;
    
    [self hudShow];
    if(time > -1) [self performSelector:@selector(dismiss) withObject:nil afterDelay:time];
    
}

- (void)dismiss
{
    [self hudHide];
}

- (void)hudShow
{
    //    [self dismiss];
    if (self.alpha == 0)
    {
        self.alpha = 1;
        
        self.hudView.alpha = 0;
        hudView.transform = CGAffineTransformScale(hudView.transform, 1.4, 1.4);
        
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
        
        [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            hudView.transform = CGAffineTransformScale(hudView.transform, 1/1.4, 1/1.4);
            hudView.alpha = 1;
            _overlayView.alpha = 1;
        }completion:^(BOOL finished){ }];
    }
}

- (void)hudHide
{
    if (self.alpha == 1)
    {
        [AmHud cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
        
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
        
        [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            self.hudView.transform = CGAffineTransformScale(hudView.transform, 0.7, 0.7);
            hudView.alpha = 0;
            _overlayView.alpha = 0;
        }completion:^(BOOL finished)
         {
             [self.hudView removeFromSuperview];
             self.hudView = nil;
             self.alpha = 0;
             _isClear = YES;
             [self.overlayView removeFromSuperview];
         }];
    }
}

- (UIControl *)overlayView {
    if(!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _overlayView.alpha = 0;
    }
    return _overlayView;
}

- (AmHudView *)hudView {
    if(!hudView) {
        hudView = AmHudView.new;
    }
    return hudView;
}

@end
