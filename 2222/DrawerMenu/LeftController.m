//
//  ViewController.m
//  DrawerMenu
//
//  Created by Wynton on 15/4/4.
//  Copyright (c) 2015年 Wynton. All rights reserved.
//

#import "LeftController.h"


#define DrawerWidth 255

@interface LeftController ()
{
    UIView *mark;
    CGPoint firstPoint;
    BOOL drawerIsAppear;
    BOOL markIsAppear;
}
@end

@implementation LeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    [self _initLeftView];
    
}




- (void)_initLeftView
{
    _drawer = [[UIView alloc]initWithFrame:CGRectMake(-DrawerWidth, 64, DrawerWidth, self.view.bounds.size.height-64)];
    _drawer.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:.8];
    drawerIsAppear = NO;
    [self.view addSubview:_drawer];
    
    mark = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    mark.backgroundColor = [UIColor clearColor];
    
    markIsAppear = NO;
    
    UITapGestureRecognizer *markTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drawerDisAppear)];
    [mark addGestureRecognizer:markTap];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    firstPoint = [touch locationInView:self.view ];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (firstPoint.x < 50 && drawerIsAppear == NO)
    {
        if (markIsAppear == NO) {
            [self.view insertSubview:mark belowSubview:_drawer];
            markIsAppear = YES;
        }
        UITouch *touch = [touches anyObject];
        CGPoint nowPoint = [touch locationInView:self.view ];
        float nowX = nowPoint.x;
        float moveX = nowX - firstPoint.x;
        float dawerX = -DrawerWidth+moveX;
        if (moveX < DrawerWidth) {
            _drawer.frame  = CGRectMake(dawerX, 64, DrawerWidth, self.view.bounds.size.height-64);
        }
    }
    else if (drawerIsAppear == YES && firstPoint.x < DrawerWidth)
    {
        UITouch *touch = [touches anyObject];
        CGPoint nowPoint = [touch locationInView:self.view ];
        float nowX = nowPoint.x;
        float moveX = nowX - firstPoint.x;
        float dawerX = moveX;
        if (moveX < 0) {
            _drawer.frame  = CGRectMake(dawerX, 64, DrawerWidth, self.view.bounds.size.height-64);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (drawerIsAppear == NO) {
        if (_drawer.frame.origin.x > -DrawerWidth+80) {
            [self drawerAppear];
        }else{
            
            [self drawerDisAppear];
        }
    }
    else if (drawerIsAppear == YES)
    {
        if (_drawer.frame.origin.x < -80) {
            [self drawerDisAppear];
        }
        else if (_drawer.frame.origin.x > -100 && _drawer.frame.origin.x < 0)
        {
            [self drawerAppear];
        }
    }
}


- (void)drawerAppear
{
    [UIView beginAnimations:@"aa" context:nil];
    [UIView setAnimationDuration:.2f];
    _drawer.frame = CGRectMake(0, 64, DrawerWidth, self.view.bounds.size.height-64);
    [UIView commitAnimations];//提交动画
    drawerIsAppear = YES;
}


-(void)drawerDisAppear
{
    [UIView beginAnimations:@"aa" context:nil];
    [UIView setAnimationDuration:.2f];
    _drawer.frame = CGRectMake(-DrawerWidth, 64, DrawerWidth, self.view.bounds.size.height-64);
    [UIView commitAnimations];//提交动画
    drawerIsAppear = NO;
    if (markIsAppear == YES) {
        [mark removeFromSuperview];
        markIsAppear = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
