//
//  AmHud.h
//  AmHud
//
//  Created by Aimeow on 6/1/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HUD_IMAGE_SIZE 24
#define HUD_CORNER_RADIUS 15
#define HUD_SHOW_TIME 1


@interface AmHud : UIView

/** 接口名称: 显示只有Content的HUD
 * content为内容 ，默认时间内自动消失
 */
+ (void)showWithContent:(NSString *)content;

/** 接口名称: 显示只有Content的HUD，并自动消失
 * content为内容,time为多久后消失（time等于-1则不消失）.不需要调用dismiss让HUD消失
 */
+ (void)showWithContent:(NSString *)content withTime:(float)time;




/** 接口名称: 显示只有图片的HUD
 * imageName为图片的文件名 ，默认时间内自动消失
 */
+ (void)showWithImage:(NSString *)imageName;

/** 接口名称: 显示只有图片与content的HUD
 * imageName为图片的文件名，content为主内容 ，默认时间内自动消失
 */
+ (void)showWithImage:(NSString *)imageName withContent:(NSString *)content;

/** 接口名称: 显示只有图片与content的HUD，并自动消失
 * imageName为图片的文件名，content为主内容 ，time为多久后消失（time等于-1则不消失）.不需要调用dismiss让HUD消失
 */
+ (void)showWithImage:(NSString *)imageName withContent:(NSString *)content withTime:(float)time;

/** 接口名称: 无限菊花
 *isLock代表是否锁定
 */
+ (void)showWithProgress:(BOOL)isLock;

+ (void)dismiss;

@end
