//
//  LKRegisterViewController.h
//  sportwb
//
//  Created by LkSime on 2017/12/15.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseViewController.h"

@protocol LKRegisterVCDelegate <NSObject>
- (void)registerSuccess;
@end

@interface LKRegisterViewController : LKBaseViewController

@property (nonatomic, weak) id <LKRegisterVCDelegate> delegate;

@end
