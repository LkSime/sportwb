//
//  LKCollectCell.h
//  sportwb
//
//  Created by LkSime on 2017/12/22.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKNewsSocialListModel;

@interface LKCollectCell : UITableViewCell
@property (nonatomic, copy) NSString * newsUrl;
@property (nonatomic, copy) NSString * title;
- (void)setNewsCellData:(LKNewsSocialListModel *)dataModal;
@end
