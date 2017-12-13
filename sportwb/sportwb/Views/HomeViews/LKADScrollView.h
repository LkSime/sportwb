//
//  LKADScrollView.h
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OPADView;

@protocol LKADScrollViewDelegate <NSObject>
//- (void)skipWeatherView;
@end

@interface LKADScrollView : UIView
@property (nonatomic, strong) OPADView * mainImage;
@property (nonatomic, strong) UIScrollView * mainScrollView;

@property (nonatomic, weak) id <LKADScrollViewDelegate> delegate;

@end
