//
//  HZCommentCell.h
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "HCSStarRatingView.h"

@interface HZCommentCell : UITableViewCell

@property(nonatomic) UIImageView *iconImg;

@property(nonatomic) UILabel *nameLb;

@property(nonatomic) UIImageView *starImg;
@property(nonatomic) StarView *starView;

@property(nonatomic) HCSStarRatingView *starRatingView;

@property(nonatomic) UILabel *contentLb;

@property(nonatomic) UILabel *timeLb;



@end
