//
//  PaperModel.h
//  CellAutoHeightWithMasonryDemo
//
//  Created by 阳光 on 17/1/12.
//  Copyright © 2017年 阳光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaperModel : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *desTitle;

@property(nonatomic,assign)int uid;

// 是否折叠
@property(nonatomic,assign)BOOL isExpand;

@end
