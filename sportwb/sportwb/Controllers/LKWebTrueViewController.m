//
//  LKWebTrueViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKWebTrueViewController.h"

@interface LKWebTrueViewController ()

@end

@implementation LKWebTrueViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadWithURL:self.webURL Cookies:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;

}
@end
