//
//  ViewController.m
//  Quartz2D绘图
//
//  Created by zengxiaohu on 16/4/23.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ViewController.h"
#import "ZXHView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZXHView *drawView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController
- (IBAction)progressValueChanged:(UISlider *)sender {
    
    self.drawView.progress=sender.value;
    
    _drawView.timerStartOrNot=!_drawView.timerStartOrNot;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _drawView.timerStartOrNot=1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
