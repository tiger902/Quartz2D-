//
//  ZXHView.h
//  Quartz2D绘图
//
//  Created by zengxiaohu on 16/4/23.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXHView : UIView

@property (nonatomic,assign) CGFloat progress;

@property (nonatomic,strong) UILabel *progressLabel;

@property (nonatomic,assign) BOOL timerStartOrNot;

@end
