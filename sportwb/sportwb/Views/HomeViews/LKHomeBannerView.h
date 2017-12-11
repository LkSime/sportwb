//
//  LKHomeBannerView.h
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKHomeBannerAdvertList;

@interface LKHomeBannerView : UIView

- (void)createBannerView;
- (void)loadBannerDatas:(LKHomeBannerAdvertList *)datasArray;
@end
