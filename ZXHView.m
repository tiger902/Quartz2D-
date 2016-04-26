//
//  ZXHView.m
//  Quartz2D绘图
//
//  Created by zengxiaohu on 16/4/23.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#define kDataCount      100

#import "ZXHView.h"

@interface ZXHView()
@property (nonatomic,assign) CGContextRef lastContextRef;

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ZXHView


-(void)setTimerStartOrNot:(BOOL)timerStartOrNot{
    
    _timerStartOrNot=timerStartOrNot;
    
    if (_timerStartOrNot) {
        
        [self setupTimer];
        
    } else {
        
        [_timer invalidate];
        
        _timer=nil;
    }
}

-(void)setupTimer{
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

-(CGContextRef)lastContextRef{
    
    if (_lastContextRef==nil) {
        
        _lastContextRef=UIGraphicsGetCurrentContext();
    }
    
    return _lastContextRef;
}

-(NSMutableArray*)dataList{
    
    if (_dataList==nil) {
        
        _dataList=[NSMutableArray arrayWithCapacity:kDataCount];
    }
    
    return _dataList;
}

-(void)timerAction{
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self drawRect1];
//    [self drawRect2];
//    [self drawRect3];
//    [self drawRect4];
//    [self drawRectByBerzierPath3];
//    [self drawRectPath];
//    [self drawRectFill];
//    [self drawPieChart];
//    [self drawBarChart];
//    [self drawDynamicChart];
//    [self drawString];
    [self drawDynamicChart1];
//    [self drawImage];
//    [self drawClipImage];
}

-(void)drawClipImage{
    
    UIImage *image=[UIImage imageNamed:@"me"];
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGPoint centerPoint=CGPointMake(image.size.width/2, image.size.height/2);
    
    CGFloat radius=MIN(image.size.width, image.size.height)/2;
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextClip(ctx);
    
    [image drawAtPoint:CGPointZero];
}

-(void)drawImage{
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextClip(ctx);
    
    UIImage *image=[UIImage imageNamed:@"me"];
    
//    [image drawAtPoint:CGPointZero];
    [image drawAtPoint:CGPointMake(50, 50)];
}

-(void)drawDynamicChart1{
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    NSNumber *newData=[NSNumber numberWithFloat:arc4random_uniform(50)/1.0f+200];
    
    [self.dataList addObject:newData];
    
    CGFloat detaX=self.bounds.size.width/kDataCount;
    
    
    NSInteger initX=kDataCount-self.dataList.count;
    
    CGFloat xInit=detaX*initX;
    
    CGFloat yInit=self.bounds.size.height-[self.dataList[0] floatValue];
    
    CGContextMoveToPoint(ctx, xInit, yInit);
    
    for (int i=0; i<self.dataList.count; i++) {
        
        CGFloat pointX=detaX*i+xInit;
        
        CGFloat pointY=self.bounds.size.height-[self.dataList[i] floatValue];
        
        CGContextAddLineToPoint(ctx, pointX, pointY);
        
    }
    
    [[UIColor redColor]set];
    
    CGContextSetLineWidth(ctx, 2);
    
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    
    CGContextStrokePath(ctx);
    
    
    if (self.dataList.count==kDataCount) {
        
        [self.dataList removeObjectAtIndex:0];
    }
    
}

-(void)drawString{
    
    NSString *str=@"welcome to my house";
    
    NSDictionary *attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:25.0f],NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineColorAttributeName:@5};
    
    [str drawInRect:CGRectMake(50, 40, 300, 300) withAttributes:attributes ];
}

-(void)drawDynamicChart{
    
    //static float lastX=(self.bounds.size.width-20);
    
    CGContextRef ctx=self.lastContextRef;
    
    //CGContextRestoreGState(ctx);
    
    CGContextTranslateCTM(ctx, -10, 0);
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    CGFloat y=self.bounds.size.height-arc4random_uniform(300);
    CGFloat yy=self.bounds.size.height-arc4random_uniform(300);
    
    
    [path moveToPoint:CGPointMake(self.bounds.size.width-40,yy)];
    
    [path addLineToPoint:CGPointMake(self.bounds.size.width-20, y)];
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //CGContextSaveGState(ctx);
    self.lastContextRef=ctx;
}

-(void)drawBarChart{
    
    NSArray *dat=@[@43,@32,@64,@89,@78,@12,@84,@52];
    
    CGFloat width=self.bounds.size.width/(2*dat.count+1);
    
    for (int i=0; i<dat.count; i++) {
        
        CGFloat x=width*i*2+width;
        
        CGFloat height=[dat[i]floatValue]/100*self.bounds.size.height;
        
        CGFloat y=self.bounds.size.height-height;
        
        UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(x, y, width, height)];
        
        [[self randomColor]set];
        
        [path fill];
    }
}

-(void)drawPieChart{
    
    NSArray *dat=@[@43,@32,@64,@89,@78,@12,@84,@52];
    
    float datTotal=0;
    
    for (NSString *temp in dat) {
        
        datTotal +=[temp floatValue];
    }
    
    CGPoint centerPoint=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    CGFloat radius=MIN(centerPoint.x, centerPoint.y);
    
    CGFloat start=0;
    
    CGFloat end=0;
    
    for (NSString *tmp in dat) {
        
        end=[tmp floatValue]/datTotal*M_PI*2+start;
        
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:start endAngle:end clockwise:YES];
        
        [path addLineToPoint:centerPoint];
        
        [[self randomColor]set];
        
        [path fill];
        
        start=end;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setNeedsDisplay];
}

-(UIColor*)randomColor{
    
    CGFloat red=arc4random_uniform(256)/255.0f;
    CGFloat green=arc4random_uniform(256)/255.0f;
    CGFloat blue=arc4random_uniform(256)/255.0f;
    
    UIColor *color=[UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    return color;
}

-(void)drawRectFill{
    
    //1.获取图形上下文对象
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.添加图形上下文对象路径
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    UIBezierPath *path1=[UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    
    
    UIBezierPath *path2=[UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:20 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    UIBezierPath *path4=[UIBezierPath bezierPathWithRect:CGRectMake(150, 50, 200, 200)];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path2.CGPath);
    CGContextAddPath(ctx, path3.CGPath);
    CGContextAddPath(ctx, path4.CGPath);
    
    //3.绘制
    CGContextFillPath(ctx);
}

-(void)drawRectPath{
    
    //1.获取图形上下文对象
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.添加图形上下文对象路径
    CGContextMoveToPoint(ctx, 20, 20);
    
    CGContextAddLineToPoint(ctx, 200, 200);
    
    CGContextAddLineToPoint(ctx, 20, 200);
    
    CGContextClosePath(ctx);
    
    //3.设置线宽及颜色
    CGContextSetLineWidth(ctx, 2);
    
    CGContextSetLineJoin(ctx, kCGLineJoinMiter);
    
    [[UIColor redColor]set];
    
    //4.绘制
    CGContextStrokePath(ctx);
}

-(void)drawRectByBerzierPath3{
    
    //1.获取图形上下文对象
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.创建UIBerzierPath对象
//    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 200, 200)];
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) cornerRadius:20];
    
    //3.添加UIBerzierPath对象到图形上下文对象路径
    CGContextAddPath(ctx, path.CGPath);
    
    //4.执行绘制
    CGContextDrawPath(ctx, kCGPathStroke);
}

-(void)drawRectByBerzierPath2{
    
    //1.获取图形上下文对象
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.创建UIBerzierPath对象
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    //3.把创建的UIBerzierPath对象添加到图形上下文对象路径
    CGContextAddPath(ctx, path.CGPath);
    
    //4.执行绘制
    CGContextDrawPath(ctx, kCGPathStroke);
}

-(void)drawRectByBerzierPath1{
    
    //1.获取图形上下文对象
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.创建BerzierPath路径对象
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    
    [path addLineToPoint:CGPointMake(200, 50)];
    
    [path addLineToPoint:CGPointMake(200, 200)];
    
    [path closePath];
    
    //3.添加UIBerzierPath对象到图形上下文对象路径
    CGContextAddPath(ctx, path.CGPath);
    
    //4.渲染或填充
//    CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}

-(void)drawRect4{
    
    //1.创建UIBerierPath对象
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    //2.填充
    [path fill];
}

-(void)drawRect3{
    
    //1.获取图形上下文对象
    CGContextRef contextRef=UIGraphicsGetCurrentContext();
    
    //2.创建UIBezierPath对象
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    //3.向图形上下文对象添加路径
    CGContextAddPath(contextRef, path.CGPath);
    
    //4.渲染或填充
//    CGContextStrokePath(contextRef);
    CGContextFillPath(contextRef);
}

-(void)drawRect2{
    
    //1.获取图形上下文对象
    CGContextRef contextRef=UIGraphicsGetCurrentContext();
    
    //2.向图形上下文对象添加路径
    CGContextAddRect(contextRef, CGRectMake(50, 50, 200, 200));
    
    //3.渲染或填充
//    CGContextStrokePath(contextRef);
    CGContextFillPath(contextRef);
}


-(void)drawRect1{
    
    // 1.获取图形上下文对象
    CGContextRef contextRef=UIGraphicsGetCurrentContext();
    
    // 2.向图形上下文对象中添加路径
    CGContextMoveToPoint(contextRef, 50, 50);
    
    CGContextAddLineToPoint(contextRef, 150, 50);
    
    CGContextAddLineToPoint(contextRef, 150, 150);
    
    //CGContextAddLineToPoint(contextRef, 50, 50);
    CGContextClosePath(contextRef);
    
    CGContextMoveToPoint(contextRef, 200, 200);
    
    CGContextAddLineToPoint(contextRef, 250, 250);
    
    // 3.渲染
    CGContextStrokePath(contextRef);
}

@end
