//
//  TableViewCell.h
//  CellAutoHeightWithMasonryDemo
//
//  Created by 阳光 on 17/1/12.
//  Copyright © 2017年 阳光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperModel.h"

typedef void(^IsExpandBlock)(BOOL IsExpand);

@interface TableViewCell : UITableViewCell

@property(nonatomic,copy)IsExpandBlock isExpandBlock;

-(void)configCellWithModel:(PaperModel *)paperModel;

@end
